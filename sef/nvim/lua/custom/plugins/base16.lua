return {
  'RRethy/base16-nvim',
  priority = 1000,
  lazy = false,
  config = function()
    require('base16-colorscheme')
    vim.cmd([[colorscheme base16-solarflare]])
  end
}
