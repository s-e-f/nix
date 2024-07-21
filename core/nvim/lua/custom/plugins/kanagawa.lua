return {
  'rebelot/kanagawa.nvim',
  priority = 1000,
  lazy = false,
  config = function()
    require('kanagawa').setup({
      compile = true,
      theme = 'dragon',
      background = {
        dark = 'dragon',
      },
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = 'none'
            }
          }
        }
      }
    })

    vim.cmd([[colorscheme kanagawa]])
  end
}
