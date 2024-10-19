{ pkgs, ... }:
{
  services.mako = {
    enable = true;
    defaultTimeout = 5000;
    borderRadius = 4;
  };
}
