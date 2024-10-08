{
  pkgs,
  config,
  inputs,
  ...
}:
{
  programs.nixvim.plugins.nvim-colorizer = {
    enable = true;
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
  programs.nixvim.keymaps = [
    {
      action = "<cmd>ColorizerToggle<cr>";
      key = "<leader>c";
      mode = "n";
    }
  ];
}
