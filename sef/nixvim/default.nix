{
  inputs,
  ...
}:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./filetypes.nix
    ./keymaps.nix
    ./autocmd.nix
    ./options.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    performance = {
      byteCompileLua = {
        enable = false;
        nvimRuntime = true;
        plugins = true;
      };
      combinePlugins = {
        enable = false;
        standalonePlugins = [
          "nvim-treesitter"
          "oil.nvim"
          "telescope-media-files.nvim"
        ];
      };
    };
    luaLoader.enable = true;
  };

  stylix.targets.nixvim = {
    plugin = "base16-nvim";
    transparentBackground = {
      main = true;
      signColumn = true;
    };
  };
}
