{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    darwin.url = "github:mxco86/nix-darwin/master";

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
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, darwin, nur, deploy-rs, ... }@inputs:
    let
      machost = { sysarch, hostname }:
        darwin.lib.darwinSystem {
          inherit inputs;
          system = sysarch;
          modules = [ ./hosts/macos/${hostname}.nix { nixpkgs.overlays = [ inputs.emacs-overlay.overlay ]; } ];
          specialArgs = {
            x86pkgs = import nixpkgs { system = "x86_64-darwin"; overlays = [ inputs.emacs-overlay.overlay ]; };
          };
        };
      nixoshost = { sysarch, hostname }:
        nixpkgs.lib.nixosSystem {
          system = sysarch;
          modules = [ ./hosts/nixos/${hostname}/default.nix { nixpkgs.overlays = [ inputs.emacs-overlay.overlay ]; } ];
          specialArgs = { inherit inputs; };
        };
      pkglist = pkgs: [
        pkgs.nixfmt
        pkgs.nixpkgs-fmt
        pkgs.rnix-lsp
      ];
    in
    {
      devShell = {
        x86_64-darwin =
          let
            pkgs = nixpkgs.legacyPackages.x86_64-darwin;
          in
          pkgs.mkShell { nativeBuildInputs = pkglist pkgs; };
        x86_64-linux =
          let
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
          in
          pkgs.mkShell { nativeBuildInputs = pkglist pkgs; };
        aarch64-darwin =
          let
            pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          in
          pkgs.mkShell { nativeBuildInputs = pkglist pkgs; };
      };
      nixosConfigurations = {
        sanchez = nixoshost { sysarch = "x86_64-linux"; hostname = "sanchez"; };
        rossi = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./hosts/nixos/workstation/default.nix { nixpkgs.overlays = [ inputs.emacs-overlay.overlay ]; } ];
          specialArgs = { inherit inputs; };
        };
        host = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./ops/host/configuration.nix ./ops/host/hardware-configuration.nix ];
          specialArgs = { inherit inputs; };
        };
      };
      darwinConfigurations = {
        socrates = machost { sysarch = "x86_64-darwin"; hostname = "socrates"; };
        careca = machost { sysarch = "aarch64-darwin"; hostname = "careca"; };
        platini = machost { sysarch = "x86_64-darwin"; hostname = "platini"; };
        robson = machost { sysarch = "x86_64-darwin"; hostname = "robson"; };
      };
      homeConfigurations = {
        mryallNixOSThinkpad = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            {
              home = {
                username = "mryall";
                homeDirectory = "/home/mryall";
                stateVersion = "22.05";
              };
            }
            ./home-manager/nixos/thinkpad-home.nix
            {
              nixpkgs.config.packageOverrides = pkgs: {
                nur = import inputs.nur {
                  inherit pkgs;
                  nurpkgs = import nixpkgs { system = "x86_64-linux"; };
                };
              };
            }
          ];
        };
        mryallNixOSWorkstation = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            {
              home = {
                username = "mryall";
                homeDirectory = "/home/mryall";
                stateVersion = "22.05";
              };
            }
            ./home-manager/nixos/workstation-home.nix
            {
              nixpkgs.config.packageOverrides = pkgs: {
                nur = import inputs.nur {
                  inherit pkgs;
                  nurpkgs = import nixpkgs { system = "x86_64-linux"; };
                };
              };
            }
          ];
        };
        mryallMacOS = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = import inputs.nixpkgs {
            system = "x86_64-darwin";
            config = {
              permittedInsecurePackages = [
                "python2.7-urllib3-1.26.2"
                "python2.7-pyjwt-1.7.1"
              ];
            };
          };
          modules = [
            {
              home = {
                username = "mryall";
                homeDirectory = "/Users/mryall";
                stateVersion = "22.05";
              };
            }
            ./home-manager/macos/home.nix
            {
              nixpkgs.config.packageOverrides = pkgs: {
                nur = import inputs.nur {
                  inherit pkgs;
                  nurpkgs = import nixpkgs { system = "x86_64-darwin"; };
                };
              };
            }
          ];
          extraSpecialArgs = {
            x86pkgs = import nixpkgs { system = "x86_64-darwin"; };
          };
        };
        mryallMacOSWork = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = import inputs.nixpkgs { system = "aarch64-darwin"; };
          modules = [
            {
              home = {
                username = "matthew.ryall";
                homeDirectory = "/Users/matthew.ryall";
                stateVersion = "22.05";
              };
            }
            ./home-manager/macos/work-home.nix
            {
              nixpkgs.config.packageOverrides = pkgs: {
                nur = import inputs.nur
                  {
                    inherit pkgs;
                    nurpkgs = import nixpkgs { system = "aarch64-darwin"; };
                  };
              };
            }
          ];
          extraSpecialArgs = {
            x86pkgs = import nixpkgs { system = "x86_64-darwin"; };
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
