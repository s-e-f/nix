{ pkgs, inputs, ... }:
let
  theme = "${pkgs.base16-themes}/share/themes/solarflare.yaml";
in
{
  stylix.base16Scheme = theme;
}
