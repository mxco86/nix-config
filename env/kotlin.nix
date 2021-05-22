{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell {
  # nativeBuildInputs is usually what you want -- tools you need to run
  nativeBuildInputs = [
    kotlin
    nodejs
    nodePackages.typescript
    nodePackages.eslint
  ];
}
