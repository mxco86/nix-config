{
  nixpkgs,
  pkgs,
  ...
}: {
  imports = [
    ../modules/emacs
    ../cachix.nix
  ];

  # Set your time zone.
  time = {
    timeZone = "Europe/London";
  };

  nix = {
    package = pkgs.nixVersions.latest;
    registry.nixpkgs.flake = nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      extra-platforms = x86_64-darwin aarch64-darwin
      trusted-users = root mryall
    '';
  };

  environment = {
    systemPackages = with pkgs; [
      vim
      cachix
      python3
      nix-search
    ];
    pathsToLink = [
      "/share/zsh"
      "/share/fish"
    ];
  };

  fonts.packages = with pkgs; [
    dejavu_fonts
    fira-code
    font-awesome
    (iosevka.override {
      privateBuildPlan = ''
        [buildPlans.IosevkaCurly]
        family = "Iosevka Curly"
        spacing = "normal"
        serifs = "sans"
        noCvSs = true
        exportGlyphNames = false

        [buildPlans.IosevkaCurly.variants]
        inherits = "ss20"
      '';
      set = "Curly";
    })
  ];

  programs = {
    zsh = {
      enable = true;
    };
    fish = {
      enable = true;
    };
    emacsWithMJRPackages = {
      enable = true;
    };
  };
}
