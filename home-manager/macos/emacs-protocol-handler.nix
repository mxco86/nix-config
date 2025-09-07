{
  config,
  lib,
  pkgs,
  username,
  ...
}:
# Create protocol handler app for Emacs. Add this to Firefox Application
# handler preferences to open custom protocols in Emacs. Created as a
# home-manager activation script due to dependency on osacompile and
# underlying MacOS frameworks
let
  infoPlist = builtins.toJSON [
    {
      CFBundleURLName = "org-protocol handler";
      CFBundleURLSchemes = ["org-protocol"];
    }
  ];

  launcher = pkgs.writeScript "emacsclient" ''
    on open location this_URL
      do shell script "/run/current-system/sw/bin/emacsclient \"" & this_URL & "\""
      tell application "Emacs" to activate
    end open location
  '';

  app = "emacs-protocol-handler.app";
in {
  home-manager.users.${username} = {
    lib,
    config,
    ...
  }: {
    config.home.activation.createEmacsProtocolHandlerApp = lib.hm.dag.entryAfter ["writeBoundary"] ''
      $VERBOSE_ECHO 'Creating ${app}'
      pushd '${config.home.homeDirectory}/Applications'
      $DRY_RUN_CMD rm -rf $VERBOSE_ARG ${app} || true
      $DRY_RUN_CMD /usr/bin/osacompile -o ${app} ${launcher}
      $DRY_RUN_CMD /usr/bin/plutil -insert CFBundleURLTypes -json ${lib.escapeShellArg infoPlist} ${app}/Contents/Info.plist
      popd
    '';
  };
}
