{ pkgs, inputs, ... }:
{
  home.packages = [
    inputs.zen.packages."${pkgs.system}".specific
  ];

  home.sessionVariables = {
    BROWSER = "zen";
    DEFAULT_BROWSER = "zen";
  };

  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/http" = "zen.desktop";
    "x-scheme-handler/https" = "zen.desktop";
  };

  xdg.desktopEntries.zen = {
    exec = "zen %U";
    genericName = "Browser";
    name = "Zen";
    type = "Application";
    terminal = false;
  };
}
