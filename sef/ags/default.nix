{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [ bun ];
  imports = [ inputs.ags.homeManagerModules.default ];

  programs.ags = {
    enable = true;

    configDir = ./.;
    extraPackages = [ ];
  };
}
