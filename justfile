build-darwin:
    darwin-rebuild switch --flake ~/Config/nix-config

build-nixos:
    nixos-rebuild switch --use-remote-sudo --flake /etc/nixos

install-nix-macos:
    # install nix
    # install nix-darwin
    # install home-manager

update-home-manager hostname:
    home-manager switch --flake ${HOME}/Config/nix-config\#{{hostname}}

install-homebrew:
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

link-pass:
    ln -s ~/Security/.password-store ~/.local/share/password-store

create-public-key:
    ssh-keygen -f ~/.ssh/id_rsa -y > ~/.ssh/id_rsa.pub

install-passff-macos:
    ln -s ~/.nix-profile/lib/mozilla/native-messaging-hosts/passff.json ~/Library/Application\ Support/Mozilla
