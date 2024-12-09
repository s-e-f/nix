{ pkgs, config, ... }:
{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
  environment.systemPackages = with pkgs; [
    mangohud
    protonup
    (lutris.override {
      extraLibraries = pkgs: [
        # List library dependencies here
      ];
    })
  ];
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATH = "/home/sef/.steam/root/compatibilitytools.d";
  };
  programs.gamemode.enable = true;
}
