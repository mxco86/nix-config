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
        ((pkgs.emacsPackagesGen pkgs.emacs).emacsWithPackages (epkgs:
          (with epkgs.melpaPackages; [
            ace-window
            add-node-modules-path
            ag
            base16-theme
            cargo
            company
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
            ivy
            js2-mode
            kotlin-mode
            lsp-ivy
            lsp-java
            lsp-mode
            lsp-ui
            lsp-pyright
            magit
            multi-term
            nix-mode
            org-download
            org-roam
            org-roam-server
            org-trello
            paredit
            prettier-js
            projectile
            racer
            racket-mode
            rust-mode
            shackle
            smex
            spaceline
            terraform-mode
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
