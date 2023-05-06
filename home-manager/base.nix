{ pkgs, nur, username, ... }:

{
  home-manager.users.${username} = { pkgs, ... }: {

    nixpkgs = {
      config = { allowUnfree = true; };
    };

    home = {
      stateVersion = "22.05";

      packages = with pkgs; [
        authy
        bottom
        difftastic
        dogdns
        duf
        fd
        just
        # slack
        # isync
        ncdu
        nixpkgs-fmt
        rnix-lsp
        sqlite
        # weechat
      ];
      sessionVariables = { EDITOR = "emacsclient"; };

      file = {
        surfingkeys = {
          source = ./files/surfingkeys.conf;
          target = ".config/firefox/surfingkeys.conf";
        };
        tridactyl = {
          source = ./files/tridactyl_emacs_bindings;
          target = ".config/firefox/tridactyl_emacs_bindings";
        };

      };
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
          github = { user = "mxco86"; };
          diff = { tool = "difftastic"; };
          difftool = { prompt = false; };
          difftool = {
            difftastic = {
              cmd = ''difft "$LOCAL" "$REMOTE"'';
            };
          };
          pager = { difftool = true; };
        };
      };

      gpg = { enable = true; };
      bat = { enable = true; };
      broot = {
        enable = true;
        enableZshIntegration = true;
      };
      zoxide = {
        enable = true;
        enableZshIntegration = true;
      };
      htop = { enable = true; };
      jq = { enable = true; };
      password-store = {
        enable = true;
        package = pkgs.pass.withExtensions (exts: [
          # exts.pass-import
          # exts.pass-audit
          # exts.pass-otp
        ]);
      };
      firefox = {
        enable = true;
        profiles = {
          mryall = {
            id = 0;
            settings = {
              "browser.urlbar.placeholderName" = "DuckDuckGo";
              "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
              "ui.key.accelKey" = "91";
            };
            extensions = with nur.repos.rycee.firefox-addons; [
              ghosttext
              privacy-badger
              surfingkeys
              tab-session-manager
              tree-style-tab
              tridactyl
            ];
          };
        };

      };

      zsh = {
        enable = true;
        enableCompletion = true;
        enableAutosuggestions = true;
        defaultKeymap = "emacs";
        history = { ignoreDups = true; };
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
        nix-direnv = {
          enable = true;
        };
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

      tmux = {
        enable = true;
        shell = "${pkgs.zsh}/bin/zsh";
        mouse = true;
        keyMode = "emacs";
        extraConfig = ''
          set -g status-justify left
          set -s escape-time 0
          bind -n C-l next-window
          bind -n C-h previous-window
        '';
        plugins = [
          {
            plugin = pkgs.tmuxPlugins.power-theme;
            extraConfig = ''
              set -g @tmux_power_theme '#93a1a1'
            '';
          }
          pkgs.tmuxPlugins.tmux-fzf
          pkgs.tmuxPlugins.tmux-thumbs
        ];
      };

      kitty = {
        font = { name = "Fira Code"; };
        keybindings = {
          "ctrl+shift+]" = "next_tab";
          "ctrl+shift+[" = "previous_tab";
          "ctrl+shift+t" = "no_op";
        };
        settings = {
          # Fonts
          macos_thicken_font = "0.75";

          # Tabs
          tab_bar_style = "hidden";
          tab_bar_min_tabs = 2;

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

      alacritty = {
        enable = true;
        settings = {
          env = { TERM = "xterm-256color"; };
          font = {
            size = 20.0;
            normal = {
              family = "HackGen Console NF";
            };
          };
          window = {
            decorations = "none";
          };
          colors = {
            primary = {
              background = "#002b36";
              foreground = "#ffffff";
              dim_foreground = "#1e1e1e";
              bright_foreground = "#ffffff";
              normal = {
                black = "#002b36";
                red = "#ff5f59";
                green = "#44bc44";
                yellow = "#d0bc00";
                blue = "#2fafff";
                magenta = "#feacd0";
                cyan = "#00d3d0";
                white = "#ffffff";
              };
              bright = {
                black = "#002b36";
                red = "#ff5f5f";
                green = "#44df44";
                yellow = "#efef00";
                blue = "#338fff";
                magenta = "#ff66ff";
                cyan = "#9ac8e0";
                white = "#ffffff";
              };
              dim = {
                black = "#002b36";
                red = "#ff9580";
                green = "#88ca9f";
                yellow = "#d2b580";
                blue = "#82b0ec";
                magenta = "#caa6df";
                cyan = "#9ac8e0";
                white = "#989898";
              };
            };
          };
        };
      };

      dircolors = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  };
}
