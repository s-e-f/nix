{ pkgs, inputs, ... }:
let
  theme = "${pkgs.base16-schemes}/share/themes/solarflare.yaml";
in
{
  stylix = {
    enable = true;
    base16Scheme = theme;
    polarity = "dark";
  };
}
