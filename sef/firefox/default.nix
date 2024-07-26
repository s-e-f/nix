{ pkgs, inputs, ... }:
{
  programs.firefox = {
    enable = true;
    enableGnomeExtensions = true;
    profiles =
      with pkgs.nur.repos.rycee.firefox-addons;
      let
        default-extensions = [ onepassword-password-manager ];
        default-settings = { };
      in
      {
        sef = {
          id = 0;
          settings = { } // default-settings;
          extensions = [ ] ++ default-extensions;
        };
        boyawave = {
          id = 1;
          settings = { } // default-settings;
          extensions = [ ] ++ default-extensions;
        };
        vintus = {
          id = 2;
          settings = { } // default-settings;
          extensions = [ ] ++ default-extensions;
        };
        ns = {
          id = 3;
          settings = { } // default-settings;
          extensions = [ ] ++ default-extensions;
        };
        bakker = {
          id = 4;
          settings = { } // default-settings;
          extensions = [ ] ++ default-extensions;
        };
      };
  };
  home.sessionVariables = {
    BROWSER = "firefox -P sef";
  };
}
