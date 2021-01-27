# 1. Install NixOs config
# 2. Git clone nix-home
# 3. ln -s nix-home ~/.config/nixpkgs
# ?? 4. nix-env -f '<nixpkgs>' -iA home-manager

# 5. nix-channel --add https://github.com/rycee/home-manager/archive/release-20.09.tar.gz home-manager
# 6. nix-channel --update
# 7. nix-shell '<home-manager>' -A install

{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home = {
    packages = with pkgs; [
      awscli
      chroma
      graphviz
      htop
      isync
      jq
      multimarkdown
      nixfmt
      proselint
      python37Packages.yamllint
      rnix-lsp
      shellcheck
      sqlite
      tree
      weechat
      wrk
    ];
  };

  programs = {

    home-manager = { enable = true; };

    git = {
      enable = true;
      delta.enable = true;
      delta.options = {
        features = "side-by-side";
        syntax-theme = "Solarized (dark)";
      };
      userName = "Matthew Ryall";
      userEmail = "matthew@mexico86.co.uk";
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
        credential = { helper = "osxkeychain"; };
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
        prompt = { theme = "pure"; };
      };
      localVariables = { ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=10"; };
    };

    direnv = {
      enable = true;
      enableNixDirenvIntegration = true;
      enableZshIntegration = true;
    };

    tmux = { shell = "${pkgs.zsh}/bin/zsh"; };

    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultOptions = [
        "--color dark,hl:33,hl+:37,fg+:235,bg+:136,fg+:254"
        "--color info:254,prompt:37,spinner:108,pointer:235,marker:235"
      ];
    };
  };
}
