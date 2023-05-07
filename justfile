macosNix := "${HOME}/Config/nix-config"
nixosNix := "/etc/nixos"

[macos]
rebuild-nix:
    darwin-rebuild switch --flake {{macosNix}}

[linux]
rebuild-nix:
    nixos-rebuild switch --use-remote-sudo --flake {{nixosNix}}

[macos]
install-nix:
    # install nix
    # install nix-darwin
    # install home-manager

[macos]
update-home-manager hostname:
    home-manager switch --flake {{macosNix}}\#{{hostname}}

[linux]
update-home-manager hostname:
    home-manager switch --flake {{nixosNix}}\#{{hostname}}

[macos]
install-homebrew:
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

link-pass:
    ln -s ${HOME}/Security/.password-store ${HOME}/.local/share/password-store

create-public-key:
    ssh-keygen -f ${HOME}/.ssh/id_rsa -y > ${HOME}/.ssh/id_rsa.pub

[macos]
install-ff-native-messaging:
    rm -f ${HOME}/Library/Application\ Support/Mozilla/NativeMessagingHosts/*
    ln -s ${HOME}/.nix-profile/lib/mozilla/native-messaging-hosts/* ${HOME}/Library/Application\ Support/Mozilla/NativeMessagingHosts/
