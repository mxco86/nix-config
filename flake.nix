{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";

    darwin = {
      url = "github:mxco86/nix-darwin/master";
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
      machost = { sysarch, hostname }:
        darwin.lib.darwinSystem {
          inherit inputs;
          system = sysarch;
          modules = [ ./hosts/macos/${hostname}.nix { nixpkgs.overlays = [ emacs-overlay.overlay ]; } ];
          specialArgs = {
            x86pkgs = import nixpkgs { system = "x86_64-darwin"; overlays = [ emacs-overlay.overlay ]; };
          };
        };
      nixoshost = { sysarch, hostname }:
        nixpkgs.lib.nixosSystem {
          system = sysarch;
          modules = [ ./hosts/nixos/${hostname}/default.nix { nixpkgs.overlays = [ emacs-overlay.overlay ]; } ];
          specialArgs = { inherit inputs; };
        };
      pkglist = pkgs: [
        pkgs.nixfmt
        pkgs.nixpkgs-fmt
        pkgs.rnix-lsp
      ];
    in
    {
      devShell = inputs.nixpkgs.lib.listToAttrs (map
        (system: {
          name = system;
          value = nixpkgs.legacyPackages.${system}.mkShell {
            nativeBuildInputs = pkglist nixpkgs.legacyPackages.${system};
          };
        }) [ "x86_64-darwin" "x86_64-linux" "aarch64-darwin" ]);
      nixosConfigurations = {
        sanchez = nixoshost { sysarch = "x86_64-linux"; hostname = "sanchez"; };
        rossi = nixoshost { sysarch = "x86_64-linux"; hostname = "rossi"; };
      };
      darwinConfigurations = {
        socrates = machost { sysarch = "x86_64-darwin"; hostname = "socrates"; };
        careca = machost { sysarch = "aarch64-darwin"; hostname = "careca"; };
        platini = machost { sysarch = "x86_64-darwin"; hostname = "platini"; };
        robson = machost { sysarch = "x86_64-darwin"; hostname = "robson"; };
      };
      homeConfigurations = {
        mryallNixOSThinkpad =
          let
            system = "x86_64-linux";
          in
          home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            modules = [ ./home-manager/nixos/thinkpad-home.nix ];
            extraSpecialArgs = {
              nur = import nur {
                pkgs = import nixpkgs { inherit system; };
                nurpkgs = import nixpkgs { inherit system; };
              };
            };
          };
        mryallNixOSWorkstation =
          let
            system = "x86_64-linux";
          in
          home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            modules = [ ./home-manager/nixos/workstation-home.nix ];
            extraSpecialArgs = {
              nur = import nur {
                pkgs = import nixpkgs { inherit system; };
                nurpkgs = import nixpkgs { inherit system; };
              };
            };
          };
        mryallMacOS =
          let
            system = "x86_64-darwin";
          in
          home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs { inherit system; };
            modules = [ ./home-manager/macos/home.nix ];
            extraSpecialArgs = {
              x86pkgs = import nixpkgs { inherit system; };
              nur = import nur {
                pkgs = import nixpkgs { inherit system; };
                nurpkgs = import nixpkgs { inherit system; };
              };
            };
          };
        mryallMacOSWork =
          let
            system = "aarch64-darwin";
          in
          home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs { inherit system; };
            modules = [ ./home-manager/macos/work-home.nix ];
            extraSpecialArgs = {
              x86pkgs = import nixpkgs { system = "x86_64-darwin"; };
              nur = import nur {
                pkgs = import nixpkgs { inherit system; };
                nurpkgs = import nixpkgs { inherit system; };
              };
            };
          };
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
