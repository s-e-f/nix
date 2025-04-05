{ pkgs, inputs, ... }:
{
  home.packages = [
    inputs.zen.packages."${pkgs.system}".default
  ];

  home.sessionVariables = {
    BROWSER = "brave";
    DEFAULT_BROWSER = "brave";
  };

  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/http" = "brave.desktop";
    "x-scheme-handler/https" = "brave.desktop";
  };
}
