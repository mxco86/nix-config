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
        ((emacsPackagesGen (emacsGit.override { nativeComp = true; })).emacsWithPackages (epkgs:
          (with epkgs.melpaPackages; [
            alert
            ace-window
            add-node-modules-path
            ag
            base16-theme
            cargo
            company
            company-go
            consult
            dap-mode
            direnv
            docker
            docker-compose-mode
            dockerfile-mode
            editorconfig
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
            org-download
            org-noter
            org-roam
            org-roam-ui
            ox-hugo
            paredit
            pdf-tools
            prettier-js
            projectile
            racer
            racket-mode
            rust-mode
            selectrum
            selectrum-prescient
            shackle
            simple-httpd
            spaceline
            terraform-mode
            toc-org
            typescript-mode
            use-package
            use-package-ensure-system-package
            vimish-fold
            web-mode
            websocket
            which-key
            writegood-mode
            yaml-mode
            yasnippet
            yasnippet-snippets
          ])
          ++ [ epkgs.elpaPackages.org ]
          ++ [ epkgs.nongnuPackages.org-contrib ]))
      ];
  };
}
