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
        (aspellWithDicts (d: [ d.en ]))
        ((emacsPackagesFor (emacsGit.override { nativeComp = true; })).emacsWithPackages (epkgs:
          (with epkgs.melpaPackages; [
            all-the-icons
            all-the-icons-dired
            alert
            ace-window
            add-node-modules-path
            base16-theme
            cargo
            company
            company-go
            consult
            consult-dir
            dap-mode
            direnv
            docker
            docker-compose-mode
            dockerfile-mode
            dumb-jump
            editorconfig
            eglot
            embark
            embark-consult
            exec-path-from-shell
            format-all
            flycheck
            flycheck-kotlin
            flycheck-rust
            flycheck-yamllint
            forge
            git-timemachine
            github-review
            go-eldoc
            go-mode
            groovy-mode
            haskell-mode
            js2-mode
            kotlin-mode
            log4e
            lsp-java
            lsp-mode
            lsp-ui
            lsp-pyright
            lsp-sonarlint
            magit
            marginalia
            multi-term
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
            racer
            racket-mode
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
            vimish-fold
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
          ]
          ++ [ epkgs.nongnuPackages.org-contrib ]))
      ];
  };
}
