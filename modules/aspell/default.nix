{ lib, pkgs, config, ... }:
with lib;
let cfg = config.programs.aspellWithDictConfig;
in {

  options = {
    programs.aspellWithDictConfig = {
      enable = mkEnableOption "Aspell with dict config";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ aspell aspellDicts.en ];

    environment.etc = {
      "aspell.conf" = {
        text = ''
          dict-dir ${pkgs.aspellDicts.en}/lib/aspell
        '';

        mode = "0444";
      };
    };
  };
}
