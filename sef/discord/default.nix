{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (discord-canary.override {
      withVencord = true;
      withOpenASAR = true;
    })
  ];
}
