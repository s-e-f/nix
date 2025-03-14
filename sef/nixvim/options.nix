{ ... }:
{
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
      have_nerd_font = true;
    };
    opts = {
      completeopt = [
        "menu"
        "menuone"
        "noselect"
      ];
      number = true;
      relativenumber = true;
      showmode = false;
      breakindent = false;
      undofile = true;
      ignorecase = true;
      smartcase = true;
      updatetime = 100;
      fileencoding = "utf-8";
      tabstop = 4;
      shiftwidth = 4;
      softtabstop = 4;
      expandtab = true;
      smartindent = false;
      autoindent = false;
      smarttab = true;
      wrap = false;
      termguicolors = true;
      conceallevel = 2;
      splitright = true;
      splitbelow = true;
      list = true;
      listchars = {
        tab = "» ";
        trail = "·";
        nbsp = "␣";
      };
      inccommand = "split";
      cursorline = true;
      scrolloff = 10;
      hlsearch = true;
      background = "";
    };
  };
}
