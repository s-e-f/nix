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
  roslyn-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "roslyn.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "seblyng";
      repo = "roslyn.nvim";
      rev = "633a61c30801a854cf52f4492ec8702a8c4ec0e9";
      hash = "sha256-PX0r8TFF/Y22zmx+5nYpbNjwKg4nk2N5U41uYE7YnE8=";
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
      roslyn-nvim
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
