{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    darwin.url = "github:mxco86/nix-darwin/master";

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

  outputs = { self, nixpkgs, darwin, nur, ... }@inputs:
    let
      kittyOverlay =
        final: prev: {
          kitty-patched = prev.pkgs.kitty.overrideAttrs
            (prevAttrs: rec {
              # patches = prevAttrs.patches ++ [ ./pkgs/kitty/stack-size.patch ];
              doInstallCheck = false;
            });
        };
    in
    {
      devShell = {
        x86_64-darwin =
          let
            pkgs = nixpkgs.legacyPackages.x86_64-darwin;
            pkglist = [
              pkgs.nixfmt
              pkgs.nixpkgs-fmt
              pkgs.rnix-lsp
            ];
          in
          pkgs.mkShell { nativeBuildInputs = pkglist; };
        x86_64-linux =
          let
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            pkglist = [
              pkgs.nixfmt
              pkgs.nixpkgs-fmt
            ];
          in
          pkgs.mkShell { nativeBuildInputs = pkglist; };
        aarch64-darwin =
          let
            pkgs = nixpkgs.legacyPackages.aarch64-darwin;
            pkglist = [
              pkgs.nixfmt
              pkgs.nixpkgs-fmt
            ];
          in
          pkgs.mkShell { nativeBuildInputs = pkglist; };
      };
      nixosConfigurations = {
        sanchez = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./hosts/nixos/thinkpad/default.nix { nixpkgs.overlays = [ inputs.emacs-overlay.overlay ]; } ];
          specialArgs = { inherit inputs; };
        };
        rossi = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./hosts/nixos/workstation/default.nix { nixpkgs.overlays = [ inputs.emacs-overlay.overlay ]; } ];
          specialArgs = { inherit inputs; };
        };
      };
      darwinConfigurations = {
        socrates = darwin.lib.darwinSystem {
          inherit inputs;
          system = "x86_64-darwin";
          modules = [ ./hosts/macos/macbook.nix { nixpkgs.overlays = [ inputs.emacs-overlay.overlay kittyOverlay ]; } ];
          specialArgs = {
            x86pkgs = import nixpkgs { system = "x86_64-darwin"; overlays = [ inputs.emacs-overlay.overlay kittyOverlay ]; };
          };
        };
        careca = darwin.lib.darwinSystem {
          inherit inputs;
          system = "aarch64-darwin";
          modules = [ ./hosts/macos/macbook-work.nix { nixpkgs.overlays = [ inputs.emacs-overlay.overlay kittyOverlay ]; } ];
          specialArgs = {
            x86pkgs = import nixpkgs { system = "x86_64-darwin"; overlays = [ inputs.emacs-overlay.overlay kittyOverlay ]; };
          };
        };
      };
      homeConfigurations = {
        mryallNixOSThinkpad = inputs.home-manager.lib.homeManagerConfiguration {
          system = "x86_64-linux";
          homeDirectory = "/home/mryall";
          username = "mryall";
          configuration.imports = [
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
          system = "x86_64-linux";
          homeDirectory = "/home/mryall";
          username = "mryall";
          configuration.imports = [
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
          system = "x86_64-darwin";
          homeDirectory = "/Users/mryall";
          username = "mryall";
          pkgs = import inputs.nixpkgs {
            system = "x86_64-darwin";
          };
          extraSpecialArgs = {
            x86pkgs = import nixpkgs {
              system = "x86_64-darwin";
              overlays = [ kittyOverlay ];
            };
          };
          configuration.imports = [
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
        };
        mryallMacOSWork = inputs.home-manager.lib.homeManagerConfiguration {
          system = "aarch64-darwin";
          homeDirectory = "/Users/matthew.ryall";
          username = "matthew.ryall";
          pkgs = import inputs.nixpkgs {
            system = "aarch64-darwin";
          };
          extraSpecialArgs = {
            x86pkgs = import nixpkgs { system = "x86_64-darwin"; };
          };
          configuration. imports = [
            ./home-manager/macos/work-home.nix
            {
              nixpkgs.config.packageOverrides = pkgs: {
                nur = import inputs.nur {
                  inherit pkgs;
                  nurpkgs = import nixpkgs { system = "aarch64-darwin"; };
                };
              };
            }
          ];
        };
      };
    };
}
