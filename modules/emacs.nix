{ pkgs }:

pkgs.emacsWithPackagesFromUsePackage {
  config = ~/.emacs;
  extraEmacsPackages = epkgs: [
    epkgs.ace-window
    epkgs.add-node-modules-path
    epkgs.ag
    epkgs.base16-theme
    epkgs.cargo
    epkgs.company
    epkgs.company-org-roam
    epkgs.counsel
    epkgs.dap-mode
    epkgs.direnv
    epkgs.docker
    epkgs.docker-compose-mode
    epkgs.dockerfile-mode
    epkgs.flx
    epkgs.flycheck
    epkgs.flycheck-kotlin
    epkgs.flycheck-rust
    epkgs.flycheck-yamllint
    epkgs.forge
    epkgs.ivy
    epkgs.js2-mode
    epkgs.kotlin-mode
    epkgs.lsp-ivy
    epkgs.lsp-java
    epkgs.lsp-mode
    epkgs.lsp-ui
    epkgs.lsp-pyright
    epkgs.magit
    epkgs.nix-mode
    epkgs.org-download
    epkgs.org-roam
    epkgs.org-roam-server
    epkgs.paredit
    epkgs.prettier-js
    epkgs.projectile
    epkgs.racer
    epkgs.racket-mode
    epkgs.rust-mode
    epkgs.shackle
    epkgs.smex
    epkgs.spaceline
    epkgs.typescript-mode
    epkgs.use-package
    epkgs.use-package-ensure-system-package
    epkgs.vimish-fold
    epkgs.web-mode
    epkgs.which-key
    epkgs.writegood-mode
    epkgs.yaml-mode
    epkgs.yasnippet
    epkgs.yasnippet-snippets
  ];
}
