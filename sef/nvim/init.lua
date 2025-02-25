local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
local opt = vim.opt
opt.completeopt = 'menu,menuone,noselect'
opt.number = true
opt.relativenumber = true
opt.showmode = false
opt.breakindent = false
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.updatetime = 100
opt.fileencoding = 'utf-8'
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = false
opt.autoindent = false
opt.smarttab = true
opt.wrap = false
opt.termguicolors = true
opt.conceallevel = 2
opt.splitright = true
opt.splitbelow = true
opt.list = true
opt.listchars = 'tab:» ,trail:·,nbsp:␣'
opt.inccommand = 'split'
opt.cursorline = true
opt.scrolloff = 10
opt.hlsearch = true
opt.signcolumn = 'yes'

require('lazy').setup({
    spec = {
        {
            "vague2k/vague.nvim",
            config = function()
                require('vague').setup({
                    transparent = true
                })
            end
        },
        {
            'echasnovski/mini.nvim',
            version = false,
            config = function()
                -- Extend and create a/i textobjects
                require('mini.ai').setup()

                -- Text edit operators
                require('mini.operators').setup()

                -- Surround actions
                require('mini.surround').setup()

                -- Icon provider
                require('mini.icons').setup()

                -- Completion and signature help
                require('mini.completion').setup()

                -- Statusline
                require('mini.statusline').setup()

                -- Git integration
                require('mini.git').setup()

                -- Work with diff hunks
                require('mini.diff').setup()
            end,
        },
        {
            'stevearc/oil.nvim',
            opts = {},
        },
        {
            "stevearc/conform.nvim",
            opts = {
              formatters_by_ft = {
                lua = { "stylua" },
              },
              formatters = {
              },
            },
        },
        -- init.lua:
        {
            'nvim-telescope/telescope.nvim',
            branch = '0.1.x',
            config = function()
                require('telescope').setup()
                local telescope = require('telescope.builtin')
                vim.keymap.set('n', '<leader>ff', function() telescope.find_files() end, { desc = 'Fuzzy find files' })
                vim.keymap.set('n', '<leader>fh', function() telescope.help_tags() end, { desc = 'Fuzzy find help' })
                vim.keymap.set('n', '<leader>fg', function() telescope.live_grep() end, { desc = 'Live grep' })
            end,
            dependencies = {
                'nvim-lua/plenary.nvim',
                'nvim-telescope/telescope-fzf-native.nvim'
            }
        },
        {
          "folke/snacks.nvim",
          opts = {
            statuscolumn = {},
            words = {},
          }
        },
        {
            'seblyng/roslyn.nvim',
            ft = 'cs',
            opts = {
                exe = 'Microsoft.CodeAnalysis.LanguageServer'
            },
        }
    },
    checker = { enabled = true },
})

vim.keymap.set('n', '<esc>', '<cmd>nohlsearch<cr>', { desc = 'Clear search highlights' })
vim.keymap.set('n', '<leader>x', '<cmd>bd<cr>', { desc = 'Close the current buffer' })
vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = 'Open Oil (file explorer)' })

local augroup = vim.api.nvim_create_augroup('user_cmds', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    group = augroup,
    desc = 'Highlight when yanking text',
    callback = function() vim.highlight.on_yank() end,
})
vim.api.nvim_create_autocmd('LspAttach', {
    group = augroup,
    desc = 'Choose between ts_ls and denols',
    callback = function()

    end,
})

vim.lsp.config['luals'] = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc' },
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.RUNTIME
                },
            }
        }
    },
}
vim.lsp.config['denols'] = {
    cmd = { 'deno' },
    args = { 'lsp' },
    filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
    root_markers = { 'deno.json' },
    settings = {},
}

vim.lsp.enable('luals')

vim.cmd([[colorscheme vague]])
