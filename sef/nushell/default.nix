{ pkgs, ... }:
{
  programs.nushell = {
    enable = false;
    package = pkgs.nushell;
    configFile.text = ''
      $env.config = {
        show_banner: false,
      }
      plugin add ${pkgs.nushellPlugins.gstat}/bin/nu_plugin_gstat
      plugin add ${pkgs.nushellPlugins.query}/bin/nu_plugin_query
    '';
    shellAliases = {
      "cd" = "z";
      "v" = "nvim";
    };
  };
  programs.carapace.enable = true;
}
