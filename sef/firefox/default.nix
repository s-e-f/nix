{
  pkgs,
  inputs,
  username,
  ...
}:
{
  programs.firefox = {
    enable = false;
    package = pkgs.firefox.override { nativeMessagingHosts = [ pkgs.gnome-browser-connector ]; };
    profiles =
      with pkgs.nur.repos.rycee.firefox-addons;
      let
        default-extensions = [
          onepassword-password-manager
          ublock-origin
          multi-account-containers
        ];
        default-settings = { };
      in
      {
        "${username}" = {
          id = 0;
          settings = { } // default-settings;
          extensions = [ ] ++ default-extensions;
        };
      };
  };
  home.sessionVariables = {
    BROWSER = "vivaldi";
  };
}
