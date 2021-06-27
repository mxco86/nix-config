# 1. Install NixOs config
# 2. Git clone nix-home
# 3. ln -s nix-home ~/.config/nixpkgs
# ?? 4. nix-env -f '<nixpkgs>' -iA home-manager

# 5. nix-channel --add https://github.com/rycee/home-manager/archive/release-20.09.tar.gz home-manager
# 6. nix-channel --update
# 7. nix-shell '<home-manager>' -A install

{ pkgs, ... }: {

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = false;
      allowUnsupportedSystem = false;
    };
    overlays = [ (self: super: { adr-tools = import ../pkgs/adr-tools; }) ];
  };

  home = {
    packages = with pkgs; [
      awscli2
      aws-vault
      discord
      htop
      isync
      jq
      keepassxc
      proselint
      sqlite
      tree
      weechat
    ];
  };

  programs = {

    home-manager = { enable = true; };

    ssh = {
      enable = true;
      compression = true;
      forwardAgent = true;
    };

    git = {
      enable = true;
      delta.enable = true;
      delta.options = {
        features = "side-by-side";
        syntax-theme = "Solarized (dark)";
      };
      aliases = {
        st = "status";
        ci = "commit";
        co = "checkout";
        br = "branch";
        ix = "diff --cached";
        lg =
          "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      };
      extraConfig = {
        core = {
          editor = "${pkgs.emacs}/bin/emacsclient";
          whitespace = "nowarn";
        };
        color = {
          branch = "auto";
          diff = "auto";
          status = "auto";
        };

        push = { default = "simple"; };
        pull = { ff = "only"; };
      };
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      defaultKeymap = "emacs";
      history = { ignoreDups = true; };
      oh-my-zsh = {
        enable = true;
        plugins = [
          "aws"
          "colored-man-pages"
          "colorize"
          "docker"
          "git"
          "gitfast"
          "sudo"
          "tmux"
        ];
      };
      plugins = [{
        name = "fast-syntax-highlighting";
        src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
      }];
      prezto = {
        enable = true;
        color = true;
        editor = {
          promptContext = true;
          dotExpansion = true;
        };
        tmux = { autoStartLocal = true; };
        prompt = { theme = "pure"; };
      };
      localVariables = { ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=10"; };
      initExtra = "
        bindkey \"\e[1;3D\" backward-word
        bindkey \"\e[1;3C\" forward-word
      ";
    };

    direnv = {
      enable = true;
      enableNixDirenvIntegration = true;
      enableZshIntegration = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultOptions = [
        "--color dark,hl:33,hl+:37,fg+:235,bg+:136,fg+:254"
        "--color info:254,prompt:37,spinner:108,pointer:235,marker:235"
      ];
    };

    kitty = {
      enable = true;
      font = { name = "Hack"; };
      settings = {
        # Fonts
        # font_size = 14;
        macos_thicken_font = "0.75";

        # Tabs
        tab_bar_style = "powerline";
        tab_bar_min_tabs = 1;

        # Config
        allow_remote_control = "yes";
        active_border_color = "#93a1a1";
        inactive_border_color = "#586e75";
        window_padding_width = 3;
        window_margin_width = 1;
        placement_strategy = "top-left";
        hide_window_decorations = "yes";
        macos_option_as_alt = "yes";
        copy_on_select = "yes";

        # Color theme
        background = "#002b36";
        foreground = "#657b83";
        cursor = "#93a1a1";
        selection_background = "#586e75";

        # Black
        color0 = "#002b36";
        color8 = "#073642";

        # Red
        color1 = "#dc322f";
        color9 = "#cb4b16";

        # Green
        color2 = "#859900";
        color10 = "#586e75";

        # color2 = "#2aa198";
        # color10 = "#2aa198";

        # Yellow
        color3 = "#b58900";
        color11 = "#657b83";

        # Blue
        color4 = "#268bd2";
        color12 = "#839496";

        # Magenta
        color5 = "#d33682";
        color13 = "#6c71c4";

        # Cyan
        color6 = "#2aa198";
        color14 = "#93a1a1";

        # White
        color7 = "#eee8d5";
        color15 = "#fdf6e3";
      };
    };

    dircolors = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
