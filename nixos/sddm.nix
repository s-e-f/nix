{ pkgs, inputs, ... }:
{
  # environment.systemPackages = with pkgs; [ sddm-astronaut ];
  #
  # services.displayManager.sddm = {
  #   enable = true;
  #   package = pkgs.kdePackages.sddm;
  #   wayland.enable = true;
  #   theme = "sddm-astronaut-theme";
  #   extraPackages = with pkgs; [ sddm-astronaut ];
  # };
}
