build-darwin:
    darwin-rebuild switch --flake ${HOME}/Config/nix-config

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
    ln -s ${HOME}/Security/.password-store ${HOME}/.local/share/password-store

create-public-key:
    ssh-keygen -f ${HOME}/.ssh/id_rsa -y > ${HOME}/.ssh/id_rsa.pub

install-passff-macos:
    ln -s ${HOME}/.nix-profile/lib/mozilla/native-messaging-hosts/passff.json ${HOME}/Library/Application\ Support/Mozilla
