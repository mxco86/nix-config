{ config, pkgs, ... }:

{
  imports = [ ./darwin-base.nix ];

  networking.hostName = "platini";

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix = {
    maxJobs = 8;
    buildCores = 0;
  };

}
