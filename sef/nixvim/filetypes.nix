{ pkgs, config, ... }:
{
  programs.nixvim = {
    extraFiles = {
      "after/ftplugin/nix.lua" = {
        source = ../nvim/after/ftplugin/nix.lua;
      };
      "after/ftplugin/gleam.lua" = {
        source = ../nvim/after/ftplugin/gleam.lua;
      };
      "after/ftplugin/json.lua" = {
        source = ../nvim/after/ftplugin/json.lua;
      };
      "after/ftplugin/lua.lua" = {
        source = ../nvim/after/ftplugin/lua.lua;
      };
    };
  };
}
