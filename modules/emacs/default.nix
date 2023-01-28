{ lib, pkgs, config, ... }:
with lib;
let cfg = config.programs.emacsWithMJRPackages;
in
{

  options = {
    programs.emacsWithMJRPackages = {
      enable = mkEnableOption "Emacs with MJR packages";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        emacs-all-the-icons-fonts
        ripgrep
        mu
        proselint
        cmake
        cargo
        (aspellWithDicts (d: [ d.en ]))
        ((emacsPackagesFor (emacsGit.override { nativeComp = true; })).emacsWithPackages (epkgs:
          (with epkgs.melpaPackages; [
            all-the-icons
            all-the-icons-completion
            all-the-icons-dired
            alert
            ace-window
            add-node-modules-path
            atomic-chrome
            base16-theme
            bufler
            cape
            code-review
            cargo
            consult
            consult-dir
            consult-eglot
            dap-mode
            docker
            docker-compose-mode
            dockerfile-mode
            dumb-jump
            editorconfig
            eglot
            embark
            embark-consult
            emojify
            envrc
            exec-path-from-shell
            format-all
            flycheck
            flycheck-kotlin
            flycheck-rust
            flycheck-yamllint
            forge
            git-timemachine
            go-eldoc
            go-mode
            groovy-mode
            haskell-mode
            helpful
            json-mode
            json-snatcher
            js2-mode
            just-mode
            kotlin-mode
            link-hint
            log4e
            lsp-java
            lsp-mode
            lsp-ui
            lsp-pyright
            lsp-sonarlint
            magit
            marginalia
            minions
            mood-line
            nix-mode
            npm-mode
            ob-kotlin
            ob-typescript
            orderless
            org-download
            org-noter
            org-present
            org-roam
            org-roam-ui
            ox-hugo
            paredit
            pdf-tools
            prettier-js
            python-mode
            racer
            racket-mode
            rainbow-delimiters
            rg
            rust-mode
            shackle
            simple-httpd
            spaceline
            sqlformat
            terraform-mode
            toc-org
            typescript-mode
            unfill
            use-package
            uuidgen
            vimish-fold
            visual-fill-column
            web-mode
            websocket
            which-key
            yaml-mode
            yasnippet
            yasnippet-snippets
          ])
          ++ [
            epkgs.elpaPackages.org
            epkgs.elpaPackages.sql-indent
            epkgs.elpaPackages.vertico
            epkgs.elpaPackages.corfu
            epkgs.elpaPackages.kind-icon
            epkgs.elpaPackages.undo-tree
          ]
          ++ [
            epkgs.nongnuPackages.org-contrib
            epkgs.nongnuPackages.eat
          ]))
      ];
  };
}
