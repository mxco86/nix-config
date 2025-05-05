{}: {
  settings = {
    "browser.urlbar.placeholderName" = "ddg";
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    "ui.key.accelKey" = "91";
    "devtools.editor.keymap" = "emacs";
    "sidebar.position_start" = false;
  };
  userChrome = "#TabsToolbar { visibility: collapse !important; }";
  search = {
    force = true;
    default = "ddg";
  };
  autoDisableScopes = 0;
}
