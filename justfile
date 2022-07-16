build-darwin:
  darwin-rebuild switch --flake ~/Config/nix-config

build-nixos:
  nixos-rebuild switch --use-remote-sudo --flake /etc/nixos
