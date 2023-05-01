{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";

    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR/master";
    };
  };

  outputs = { self, nixpkgs, darwin, emacs-overlay, nur, home-manager, deploy-rs, ... }@inputs:
    let
      machost = { system, host }:
        darwin.lib.darwinSystem {
          inherit inputs;
          inherit system;
          modules = [
            ./hosts/macos/${host}.nix { nixpkgs.overlays = [ emacs-overlay.overlay ]; }
            home-manager.darwinModules.home-manager
            ./home-manager/macos/${host}.nix
          ];
          specialArgs = {
            x86pkgs = import nixpkgs { system = "x86_64-darwin"; overlays = [ emacs-overlay.overlay ]; };
            nur = import nur {
              pkgs = import nixpkgs { inherit system; };
              nurpkgs = import nixpkgs { inherit system; };
            };
          };
        };
      nixoshost = { system, host }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/nixos/${host} { nixpkgs.overlays = [ emacs-overlay.overlay ]; } ];
          specialArgs = { inherit inputs; };
        };
      rpihost = { host }:
        nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
            { config.system.stateVersion = "22.05"; }
          ];
        };
      homeConfig = { system, host }: home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
        modules = [ ./home-manager/${host}.nix ];
        extraSpecialArgs = {
          nur = import nur {
            pkgs = import nixpkgs { inherit system; };
            nurpkgs = import nixpkgs { inherit system; };
          };
        } // (if system == "aarch64-darwin" then { x86pkgs = import nixpkgs { inherit system; }; } else { });
      };
    in
    {
      devShell =
        let
          pkglist = pkgs: [
            pkgs.nixfmt
            pkgs.nixpkgs-fmt
            pkgs.rnix-lsp
          ];
        in
        inputs.nixpkgs.lib.listToAttrs (map
          (system: {
            name = system;
            value = nixpkgs.legacyPackages.${system}.mkShell {
              nativeBuildInputs = pkglist nixpkgs.legacyPackages.${system};
            };
          }) [ "x86_64-darwin" "x86_64-linux" "aarch64-darwin" ]);
      nixosConfigurations = {
        sanchez = nixoshost { system = "x86_64-linux"; host = "sanchez"; };
        rossi = nixoshost { system = "x86_64-linux"; host = "rossi"; };
        rpi = rpihost { host = "test"; };
      };
      darwinConfigurations = {
        socrates = machost { system = "x86_64-darwin"; host = "socrates"; };
        careca = machost { system = "aarch64-darwin"; host = "careca"; };
        platini = machost { system = "x86_64-darwin"; host = "platini"; };
        robson = machost { system = "x86_64-darwin"; host = "robson"; };
      };
      homeConfigurations = {
        socrates = homeConfig { system = "x86_64-darwin"; host = "macos/socrates"; };
        rossi = homeConfig { system = "x86_64-linux"; host = "nixos/rossi"; };
        sanchez = homeConfig { system = "x86_64-linux"; host = "nixos/sanchez"; };
        robson = homeConfig { system = "x86_64-darwin"; host = "macos/robson"; };
      };

      deploy.nodes.host.profiles.system = {
        user = "root";
        hostname = "129.151.93.130";
        path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.host;
      };

      # This is highly advised, and will prevent many possible mistakes
      checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    };
}
