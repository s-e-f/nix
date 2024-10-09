{ pkgs, config, ... }:
{
  programs.nixvim = {
    extraFiles = {
      "after/ftplugin/nix.lua".source = ./after/ftplugin/nix.lua;
      "after/ftplugin/gleam.lua".source = ./after/ftplugin/gleam.lua;
      "after/ftplugin/json.lua".source = ./after/ftplugin/json.lua;
      "after/ftplugin/lua.lua".source = ./after/ftplugin/lua.lua;
      "after/ftplugin/java.lua".source = ./after/ftplugin/java.lua;
    };
    filetype = {
      filename = {
        "Directory.Build.props" = "xml";
        "Directory.Packages.props" = "xml";
        "Directory.Build.targets" = "xml";
      };
    };
  };
}
