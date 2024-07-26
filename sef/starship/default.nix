{ pkgs, inputs, ... }:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      format = " $character";
      right_format = "$all";
      character.success_symbol = "[](bold green)";
      character.error_symbol = "[](bold red)";
    };
  };
}
