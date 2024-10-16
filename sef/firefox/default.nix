{
  pkgs,
  inputs,
  username,
  ...
}:
{
  programs.firefox = {
    enable = true;
    package =
      (pkgs.wrapFirefox.override { libpulseaudio = pkgs.libpressureaudio; })
        (pkgs.firefox-unwrapped.override {
          pipewireSupport = true;
        })
        {
        };
    nativeMessagingHosts = [ pkgs.gnome-browser-connector ];
    profiles =
      with pkgs.nur.repos.rycee.firefox-addons;
      let
        default-extensions = [
          onepassword-password-manager
          ublock-origin
          multi-account-containers
          simple-tab-groups
          github-file-icons
          # FaviconSwitcher - no NUR entry yet
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
    BROWSER = "firefox";
  };
}
