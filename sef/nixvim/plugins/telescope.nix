{ pkgs, config, ... }:
{
  programs.nixvim.plugins.telescope = {
    enable = true;
    extensions = {
      fzf-native.enable = true;
      media-files = {
        enable = false;
        dependencies = {
          chafa.enable = false;
          ffmpegthumbnailer.enable = false;
          imageMagick.enable = false;
          pdftoppm.enable = false;
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
