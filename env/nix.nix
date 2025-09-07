{pkgs ? import <nixpkgs> {}}:
with pkgs;
  mkShell {
    nativeBuildInputs = [
      nix-linter
      nixfmt
      nixpkgs-fmt
      rnix-lsp
    ];
  }
