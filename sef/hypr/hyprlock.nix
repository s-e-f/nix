{ pkgs, inputs, ... }:
{
  programs.hyprlock.enable = true;
  programs.hyprlock.settings = {

    general = {
      grace = 10;
    };

    background = {
      monitor = "";
      blur_passes = 3;
      blur_size = 10;
    };
    label = [
      {
        monitor = "";
        text = "$TIME";
        font_size = 100;
        position = "0, 150";
        halign = "center";
        valign = "center";
      }
      {
        monitor = "";
        text = "$PROMPT";
        font_size = 25;
        position = "0, 30";
        halign = "center";
        valign = "center";
      }
      {
        monitor = "";
        text = "";
        font_family = "Font Awesome 6 Free";
        font_size = 50;
        position = "0, -100";
        halign = "center";
        valign = "center";
      }
    ];

    input-field = {
      monitor = "";
      size = "200, 50";
      outline_thickness = 2;
      dots_size = 0.25;
      dots_spacing = 0.25;
      dots_center = true;
      fade_on_empty = true;
      placeholder_text = "<i>password...</i>";
      hide_input = false;
      position = "0, -30";
      halign = "center";
      valign = "center";
    };
  };
}
