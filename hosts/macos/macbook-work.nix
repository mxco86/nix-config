{ config, pkgs, ... }:

{
  imports = [ ../nix-base.nix ./darwin-base.nix ];

  networking.hostName = "careca";

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix = {
    maxJobs = 4;
    buildCores = 0;
  };

}
