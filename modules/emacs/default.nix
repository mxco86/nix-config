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
        ripgrep
        proselint
        cmake
        (aspellWithDicts (d: [ d.en ]))
        ((emacsPackagesFor (emacsGit.override { nativeComp = true; })).emacsWithPackages (epkgs:
          (with epkgs.melpaPackages; [
            all-the-icons
            all-the-icons-completion
            all-the-icons-dired
            alert
            ace-window
            add-node-modules-path
            base16-theme
            cape
            code-review
            cargo
            consult
            consult-dir
            consult-eglot
            dap-mode
            diminish
            direnv
            docker
            docker-compose-mode
            dockerfile-mode
            dumb-jump
            editorconfig
            eglot
            embark
            embark-consult
            emojify
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
            js2-mode
            kotlin-mode
            libgit
            log4e
            lsp-java
            lsp-mode
            lsp-ui
            lsp-pyright
            lsp-sonarlint
            magit
            magit-libgit
            marginalia
            nix-mode
            npm-mode
            ob-kotlin
            ob-typescript
            orderless
            org-download
            org-noter
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
            terraform-lsp
            toc-org
            typescript-mode
            use-package
            uuidgen
            vimish-fold
            vterm
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
          ++ [ epkgs.nongnuPackages.org-contrib ]))
      ];
  };
}
