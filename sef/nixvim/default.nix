{
  pkgs,
  inputs,
  config,
  ...
}:
let
  zmpl-vim = pkgs.vimUtils.buildVimPlugin {
    name = "zmpl.vim";
    src = pkgs.fetchFromGitHub {
      owner = "jetzig-framework";
      repo = "zmpl.vim";
      rev = "d995eb17adda923a4fcbdad34b5a369a6c9a078a";
      hash = "sha256-PfPWtz4K3Fn5a6UjMiIkqKYzWuCbga67+4u/bj925fQ=";
    };
  };
in
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
    extraPlugins = [
      zmpl-vim
    ];
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
    highlight = {
      ColorColumn =
        let
          hexColor = "#${config.lib.stylix.colors.base00}";
        in
        {
          bg = hexColor;
          ctermbg = "Black";
        };
    };
  };

  stylix.targets.nixvim = {
    plugin = "base16-nvim";
    transparentBackground = {
      main = true;
      signColumn = true;
    };
  };
}
