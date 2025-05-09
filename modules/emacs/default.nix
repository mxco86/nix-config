{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.programs.emacsWithMJRPackages;
in {
  options = {
    programs.emacsWithMJRPackages = {
      enable = mkEnableOption "Emacs with MJR packages";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      emacs-all-the-icons-fonts
      enchant
      ripgrep
      mu
      proselint
      cmake
      cargo
      (aspellWithDicts (d: [d.en]))
      (
        (emacsPackagesFor (
          emacs-git.override {
            withNativeCompilation = true;
            withPgtk = true;
          }
        )).emacsWithPackages
        (
          epkgs:
            (with epkgs.melpaPackages; [
              apheleia
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
              cargo
              consult
              consult-dir
              consult-eglot
              consult-org-roam
              dap-mode
              diff-hl
              docker
              docker-compose-mode
              dockerfile-mode
              dumb-jump
              editorconfig
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
              git-link
              go-eldoc
              go-mode
              gptel
              groovy-mode
              haskell-mode
              helpful
              jinx
              json-mode
              json-snatcher
              js2-mode
              just-mode
              kotlin-mode
              ligature
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
              modus-themes
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
              ox-gfm
              paredit
              password-store
              pdf-tools
              prettier-js
              pr-review
              python-mode
              racer
              racket-mode
              rainbow-delimiters
              rfc-mode
              rg
              rust-mode
              simple-httpd
              smart-shift
              spaceline
              sqlformat
              terraform-mode
              tempel
              tempel-collection
              toc-org
              typescript-mode
              unfill
              uuidgen
              visual-fill-column
              web-mode
              websocket
              winum
              which-key
              yaml-mode
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
              epkgs.treesit-grammars.with-all-grammars
            ]
        )
      )
    ];
  };
}
