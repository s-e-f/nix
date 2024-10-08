{ pkgs, config, ... }:
{
  programs.nixvim.plugins.telescope = {
    enable = true;
    luaConfig.post = ''
      local telescope_extensions = require('telescope').extensions
      vim.keymap.set('n', '<leader>fm', function()
        telescope_extensions.media_files.media_files()
      end, { silent = true })
    '';
    extensions = {
      fzf-native.enable = true;
      media-files = {
        enable = true;
        dependencies = {
          chafa.enable = true;
          ffmpegthumbnailer.enable = true;
          imageMagick.enable = true;
          pdftoppm.enable = true;
        };
        settings = {
          filetypes = [
            "png"
            "jpg"
            "jpeg"
            "webp"
            "gif"
            "pdf"
            "mp4"
            "webm"
          ];
          find_cmd = "rg";
        };
      };
    };
    keymaps = {
      "<leader>ff" = {
        action = "find_files";
        options.silent = true;
      };
      "<leader>fh" = {
        action = "help_tag";
        options.silent = true;
      };
      "<leader>fg" = {
        action = "live_grep";
        options.silent = true;
      };
    };
  };
}
