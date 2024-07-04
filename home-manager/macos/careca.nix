{ pkgs, username, ... }:

{
  imports = [ ./work.nix ];

  home-manager.users.${username} = { pkgs, ... }: {
    programs = {
      alacritty = {
        settings = {
          font = {
            size = 18;
          };
        };
      };
      awscli = {
        enable = true;
        package = pkgs.awscli;
        settings = {
          "default" = {
            output = "json";
            region = "eu-west-2";
          };
          "profile eng-dev" = {
            role_arn = "arn:aws:iam::895523100917:role/BastionDevSSMUsers";
            mfa_serial = "arn:aws:iam::570551521311:mfa/MattRyall";
            region = "eu-west-2";
          };
          "profile eng-prod" = {
            role_arn = "arn:aws:iam::077643444046:role/BastionProdSSMUsers";
            mfa_serial = "arn:aws:iam::570551521311:mfa/MattRyall";
            region = "eu-west-2";
          };
        };
      };
    };
  };
}
