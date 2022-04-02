{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/e5983a9833320d459db9bf6f59ef9f5fb4026377";
    darwin.url = "github:LnL7/nix-darwin/master";

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, darwin, nur, ... }@inputs: {

    devShell = {
      x86_64-darwin =
        let
          pkgs = nixpkgs.legacyPackages.x86_64-darwin;
        in
        pkgs.mkShell { };
      x86_64-linux =
        let
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
        in
        pkgs.mkShell { };
    };

    nixosConfigurations.sanchez =
      let
        overlays = [ inputs.emacs-overlay.overlay ];
      in
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/nixos/thinkpad/default.nix
          { nixpkgs.overlays = overlays; }
        ];
        specialArgs = {
          inherit inputs;
        };
      };

    nixosConfigurations.rossi =
      let
        overlays = [ inputs.emacs-overlay.overlay ];
      in
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/nixos/workstation/default.nix
          { nixpkgs.overlays = overlays; }
        ];
        specialArgs = {
          inherit inputs;
        };
      };

    darwinConfigurations = {
      socrates =
        let
          system = "x86_64-darwin";
          overlays = [ inputs.emacs-overlay.overlay ];
        in
        darwin.lib.darwinSystem
          {
            inherit system inputs;
            modules = [
              ./hosts/macos/macbook.nix
              { nixpkgs.overlays = overlays; }
            ];
          };
      careca =
        let
          system = "x86_64-darwin";
          overlays = [ inputs.emacs-overlay.overlay ];
        in
        darwin.lib.darwinSystem
          {
            inherit system inputs;
            modules = [
              ./hosts/macos/macbook-work.nix
              { nixpkgs.overlays = overlays; }
            ];
          };
    };

    homeConfigurations =
      let
        systemNixOS = "x86_64-linux";
        systemMacOS = "x86_64-darwin";
      in
      {
        mryallNixOSThinkpad = inputs.home-manager.lib.homeManagerConfiguration {
          system = systemNixOS;
          homeDirectory = "/home/mryall";
          username = "mryall";
          configuration.imports = [
            ./home-manager/nixos/thinkpad-home.nix
            {
              nixpkgs.config.packageOverrides = pkgs: {
                nur = import inputs.nur {
                  inherit pkgs;
                  nurpkgs = import nixpkgs { system = systemNixOS; };
                };
              };
            }
          ];
        };
        mryallNixOSWorkstation = inputs.home-manager.lib.homeManagerConfiguration {
          system = systemNixOS;
          homeDirectory = "/home/mryall";
          username = "mryall";
          configuration.imports = [
            ./home-manager/nixos/workstation-home.nix
            {
              nixpkgs.config.packageOverrides = pkgs: {
                nur = import inputs.nur {
                  inherit pkgs;
                  nurpkgs = import nixpkgs { system = systemNixOS; };
                };
              };
            }
          ];
        };
        mryallMacOS = inputs.home-manager.lib.homeManagerConfiguration {
          system = systemMacOS;
          homeDirectory = "/Users/mryall";
          username = "mryall";
          configuration.imports = [
            ./home-manager/macos/home.nix
            {
              nixpkgs.config.packageOverrides = pkgs: {
                nur = import inputs.nur {
                  inherit pkgs;
                  nurpkgs = import nixpkgs { system = systemMacOS; };
                };
              };
            }
          ];
        };
        mryallMacOSWork = inputs.home-manager.lib.homeManagerConfiguration {
          system = systemMacOS;
          homeDirectory = "/Users/matthewryall";
          username = "matthewryall";
          configuration.imports = [
            ./home-manager/macos/work-home.nix
            {
              nixpkgs.config.packageOverrides = pkgs: {
                nur = import inputs.nur {
                  inherit pkgs;
                  nurpkgs = import nixpkgs { system = systemMacOS; };
                };
              };
            }
          ];
        };
      };
  };
}
