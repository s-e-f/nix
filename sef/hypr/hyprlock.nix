{ pkgs, inputs, ... }:
{
  programs.hyprlock.enable = true;
  programs.hyprlock.settings = {

    general = {
      grace = 10;
    };

    background = {
      monitor = "";
      color = "rgba(25, 20, 20, 1.0)";
      blur_passes = 3;
      blur_size = 10;
    };
    label = [
      {
        monitor = "";
        text = "$TIME";
        color = "rgba(200, 200, 200, 1.0)";
        font_size = 100;
        position = "0, 150";
        halign = "center";
        valign = "center";
      }
      {
        monitor = "";
        text = "$PROMPT";
        color = "rgba(200, 200, 200, 1.0)";
        font_size = 25;
        position = "0, 30";
        halign = "center";
        valign = "center";
      }
      {
        monitor = "";
        text = "";
        font_family = "Font Awesome 6 Free";
        color = "rgba(200, 200, 200, 1.0)";
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
      outer_color = "transparent";
      inner_color = "transparent";
      font_color = "rgb(255, 255, 255)";
      fade_on_empty = true;
      placeholder_text = "<i>password...</i>";
      hide_input = false;
      position = "0, -30";
      halign = "center";
      valign = "center";
    };
  };
}
