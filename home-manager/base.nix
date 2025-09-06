{
  pkgs,
  nur,
  username,
  lib,
  ...
}: let
  aspellEnv = pkgs.aspellWithDicts (d: [d.en]);
  firefoxCfg = import ./firefox.nix {};
in {
  home-manager.users.${username} = {pkgs, ...}: {
    nixpkgs = {
      config = {
        allowUnfree = true;
      };
    };

    home = {
      stateVersion = "22.05";

      packages = with pkgs; [
        aspellEnv
        bottom
        difftastic
        # dogdns
        # duf
        du-dust
        fd
        iftop
        just
        # slack
        # isync
        # ncdu
        nil
        alejandra
        # soco-cli
        sqlite
        trippy
        # weechat
        # zoom-us
      ];
      sessionVariables = {
        EDITOR = "emacsclient";
      };

      file = {
        ".aspell.conf".text = "data-dir ${aspellEnv}/lib/aspell";
        tridactyl = {
          source = ./files/tridactyl_emacs_bindings;
          target = ".config/firefox/tridactyl_emacs_bindings";
        };
      };
    };

    programs = {
      home-manager = {
        enable = true;
      };

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
          lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
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
          push = {
            default = "simple";
          };
          pull = {
            ff = "only";
          };
          rebase = {
            autoStash = true;
          };
          github = {
            user = "mxco86";
          };
          diff = {
            tool = "difftastic";
            algorithm = "histogram";
          };
          difftool = {
            prompt = false;
            difftastic = {
              cmd = ''difft "$LOCAL" "$REMOTE"'';
            };
          };
          pager = {
            difftool = true;
          };
          merge = {
            conflictstyle = "zdiff3";
          };
          safe = {
            directory = "/home/cgit/ps.git";
          };
        };
      };
      gpg = {
        enable = true;
      };
      bat = {
        enable = true;
      };
      zoxide = {
        enable = true;
        enableZshIntegration = true;
        enableFishIntegration = true;
      };
      jq = {
        enable = true;
      };
      password-store = {
        enable = true;
        package = pkgs.pass.withExtensions (exts: [
          # exts.pass-import
          # exts.pass-audit
          exts.pass-otp
        ]);
      };
      firefox = {
        enable = true;
        profiles = {
          mryall = {
            id = 0;
            settings = firefoxCfg.settings;
            userChrome = firefoxCfg.userChrome;
            search = firefoxCfg.search;
            extensions = {
              packages = with nur.repos.rycee.firefox-addons; [
                ghosttext
                org-capture
                privacy-badger
                sidebery
                tridactyl
                ublock-origin
                i-dont-care-about-cookies
              ];
            };
          };
          miro = {
            id = 1;
            settings = {
              "browser.urlbar.placeholderName" = "ddg";
              "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
              "ui.key.accelKey" = "91";
              "devtools.editor.keymap" = "emacs";
              "sidebar.position_start" = false;
            };
            userChrome = ''
              #TabsToolbar { visibility: collapse !important; }
            '';
            search = {
              force = true;
              default = "ddg";
            };
            extensions = {
              packages = with nur.repos.rycee.firefox-addons; [
                privacy-badger
                sidebery
                ublock-origin
                i-dont-care-about-cookies
              ];
            };
          };
        };
      };

      zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion = {
          enable = true;
        };
        defaultKeymap = "emacs";
        history = {
          ignoreDups = true;
        };
        plugins = [
          {
            name = "fast-syntax-highlighting";
            src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
          }
        ];
        prezto = {
          enable = true;
          color = true;
          editor = {
            promptContext = true;
            dotExpansion = true;
          };
          prompt = {
            theme = "pure";
          };
        };
        localVariables = {
          ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=10";
        };
        initContent = lib.mkMerge [
          (lib.mkBefore ''
              [[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return '')
          ''            bindkey "\e[1;3D" backward-word
                        bindkey "\e[1;3C" forward-word
                        unsetopt pathdirs
          ''
        ];
      };

      fish = {
        enable = true;
        interactiveShellInit = ''
          set -U fish_color_operator 00a6b2
          set -U fish_color_escape 00a6b2
          set -U fish_color_autosuggestion 586e75
          set -U fish_color_comment 586e75
          set -U fish_color_param 839496
          set -U fish_color_error dc322f
          set -U fish_color_end 268bd2
          set -U fish_color_redirection 6c71c4
          set -U fish_color_quote 657b83
          set -U fish_color_command 93a1a1
          set -U pure_color_git_branch pure_color_info
          set -U pure_color_git_dirty pure_color_info
        '';
        plugins = with pkgs.fishPlugins; [
          {
            name = "pure";
            src = pure.src;
          }
        ];
      };

      eza = {
        enable = true;
        enableFishIntegration = true;
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
        enableFishIntegration = true;
        defaultOptions = [
          "--color dark,hl:33,hl+:37,fg+:235,bg+:136,fg+:254"
          "--color info:254,prompt:37,spinner:108,pointer:235,marker:235"
        ];
      };

      zellij = {
        enable = true;
        enableFishIntegration = true;
        settings = {
          theme = "solarized-dark";
          ui = {
            pane_frames = {
              rounded_corners = true;
            };
          };
          "keybinds clear-defaults=true" = {
            normal = {
              "bind \"Alt 1\"" = {
                "GoToTab" = 1;
              };
              "bind \"Alt 2\"" = {
                "GoToTab" = 2;
              };
              "bind \"Alt 3\"" = {
                "GoToTab" = 3;
              };
              "bind \"Alt 4\"" = {
                "GoToTab" = 4;
              };
              "bind \"Alt 5\"" = {
                "GoToTab" = 5;
              };
              "bind \"Alt 6\"" = {
                "GoToTab" = 6;
              };
              "bind \"Alt 7\"" = {
                "GoToTab" = 7;
              };
              "bind \"Alt 8\"" = {
                "GoToTab" = 8;
              };
              "bind \"Alt 9\"" = {
                "GoToTab" = 9;
              };
              "bind \"Alt 0\"" = {
                "GoToTab" = 10;
              };
            };
            tab = {
              "bind \"c\"" = {
                "NewTab; SwitchToMode" = "Normal";
              };
              "bind \"h\"" = {
                "GoToPreviousTab; SwitchToMode" = "Normal";
              };
              "bind \"l\"" = {
                "GoToNextTab; SwitchToMode" = "Normal";
              };
              "bind \"n\"" = {
                "GoToNextTab; SwitchToMode" = "Normal";
              };
              "bind \"Alt t\"" = {
                "SwitchToMode" = "Normal";
              };
            };
            shared_except = {
              _args = ["tab"];
              "bind \"Alt t\"" = {
                "SwitchToMode" = "tab";
              };
            };
          };
        };
      };

      alacritty = {
        enable = true;
        settings = {
          env = {
            TERM = "xterm-256color";
            COLORTERM = "truecolor";
          };
          font = {
            normal = {
              family = "Iosevka";
            };
          };
          window = {
            decorations = "none";
          };
          mouse = {
            bindings = [
              {
                mouse = "Middle";
                action = "PasteSelection";
              }
            ];
          };
          colors = {
            primary = {
              background = "#002b36";
              foreground = "#ffffff";
              dim_foreground = "#1e1e1e";
              bright_foreground = "#ffffff";
            };
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

      ghostty = {
        enable = true;
        enableFishIntegration = true;
        clearDefaultKeybinds = true;
        settings = {
          font-family = "Iosevka";
        };
      };

      dircolors = {
        enable = true;
        enableZshIntegration = true;
        enableFishIntegration = true;
      };
    };
  };
}
