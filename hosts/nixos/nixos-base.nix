{ pkgs, ... }:

{
  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      # pinentryFlavor = "gnome3";
    };

    tmux = {
      extraConfig = ''
        set-option -g default-shell $SHELL
        setw -g mouse on
        bind-key -n MouseDown2Pane run "xclip -o | tmux load-buffer - ; tmux paste-buffer"
        bind-key -T copy-mode MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "xclip"
      '';
    };
  };

  services = {
    openssh = { enable = true; };
    tailscale = { enable = true; };
    xserver = {
      displayManager.lightdm.enable = true;
      windowManager.i3 = { enable = true; };
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mryall = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };
}
