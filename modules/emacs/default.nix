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
            counsel
            dap-mode
            direnv
            docker
            docker-compose-mode
            dockerfile-mode
            editorconfig
            format-all
            flx
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
            ivy
            ivy-rich
            js2-mode
            kotlin-mode
            log4e
            lsp-ivy
            lsp-java
            lsp-mode
            lsp-ui
            lsp-pyright
            magit
            multi-term
            nix-mode
            npm-mode
            ob-kotlin
            ob-typescript
            org-download
            org-noter
            org-roam
            org-trello
            ox-hugo
            paredit
            pdf-tools
            prettier-js
            projectile
            racer
            racket-mode
            rust-mode
            shackle
            smex
            spaceline
            terraform-mode
            toc-org
            typescript-mode
            use-package
            use-package-ensure-system-package
            vimish-fold
            web-mode
            which-key
            writegood-mode
            yaml-mode
            yasnippet
            yasnippet-snippets
          ]) ++ (with epkgs.orgPackages; [ org-plus-contrib ])))
      ];
  };
}
