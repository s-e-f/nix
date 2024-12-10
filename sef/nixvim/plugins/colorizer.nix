{
  pkgs,
  config,
  inputs,
  ...
}:
{
  programs.nixvim.plugins.colorizer = {
    enable = true;
    settings = {
      fileTypes = [
        {
          language = "css";
          css = true;
        }
      ];
      userDefaultOptions = {
        AARRGGBB = true;
        RGB = true;
        RRGGBB = true;
        RRGGBBAA = true;
        mode = "background";
      };
    };
  };
  programs.nixvim.keymaps = [
    {
      action = "<cmd>ColorizerToggle<cr>";
      key = "<leader>c";
      mode = "n";
    }
  ];
}
