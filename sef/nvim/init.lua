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

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
local opt = vim.opt
opt.completeopt = "menu,menuone,noselect"
opt.number = true
opt.relativenumber = true
opt.showmode = false
opt.breakindent = false
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.updatetime = 100
opt.fileencoding = "utf-8"
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
opt.listchars = "tab:» ,trail:·,nbsp:␣"
opt.inccommand = "split"
opt.cursorline = true
opt.scrolloff = 10
opt.hlsearch = true
opt.signcolumn = "yes"

require("lazy").setup({
	spec = {
		{
			"vague2k/vague.nvim",
			priority = 1000,
			config = function()
				require("vague").setup({
					transparent = true,
				})
				vim.cmd([[colorscheme vague]])
			end,
		},
		{
			"echasnovski/mini.nvim",
			version = false,
			config = function()
				-- Extend and create a/i textobjects
				require("mini.ai").setup()

				-- Text edit operators
				require("mini.operators").setup()

				-- Surround actions
				require("mini.surround").setup()

				-- Auto-pairs
				require("mini.pairs").setup()

				-- Icon provider
				require("mini.icons").setup()

				-- Statusline
				require("mini.statusline").setup()

				-- Git integration
				require("mini.git").setup()

				-- Work with diff hunks
				require("mini.diff").setup()
			end,
		},
		{
			"stevearc/oil.nvim",
			opts = {},
		},
		{
			"stevearc/conform.nvim",
			opts = {
				formatters_by_ft = {
					lua = { "stylua" },
				},
				formatters = {},
				format_on_save = {
					timeout_ms = 1000,
					lsp_format = "fallback",
				},
			},
		},
		{
			"nvim-telescope/telescope.nvim",
			branch = "0.1.x",
			config = function()
				require("telescope").setup()
				local telescope = require("telescope.builtin")
				vim.keymap.set("n", "<leader>ff", function()
					telescope.find_files()
				end, { desc = "Fuzzy find files" })
				vim.keymap.set("n", "<leader>fh", function()
					telescope.help_tags()
				end, { desc = "Fuzzy find help" })
				vim.keymap.set("n", "<leader>fg", function()
					telescope.live_grep()
				end, { desc = "Live grep" })
			end,
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope-fzf-native.nvim",
			},
		},
		{
			"folke/snacks.nvim",
			priority = 1000,
			opts = {
				statuscolumn = {},
				quickfile = {},
				indent = {},
			},
		},
		{
			"seblyng/roslyn.nvim",
			ft = "cs",
			opts = {},
		},
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			config = function()
				local configs = require("nvim-treesitter.configs")
				configs.setup({
					ensure_installed = {
						-- Programming languages
						"lua",
						"c_sharp",
						"razor",
						"gleam",
						"zig",

						-- Web languages
						"javascript",
						"typescript",
						"tsx",
						"html",
						"css",

						-- Config languages
						"hyprlang",
						"yaml",
						"dockerfile",
					},
					sync_install = false,
					highlight = { enable = true },
					indent = { enable = true },
				})
			end,
		},
		{
			"hrsh7th/nvim-cmp",
			dependencies = {
				{
					"L3MON4D3/LuaSnip",
					version = "v2.*",
					build = "make install_jsregexp",
					config = function()
						local luasnip = require("luasnip")
						luasnip.setup({
							history = false,
							updateevents = "TextChanged,TextChangedI",
						})
						vim.keymap.set({ "i", "s" }, "<C-k>", function()
							if luasnip.expand_or_jumpable() then
								luasnip.expand_or_jump()
							end
						end, { silent = true })

						vim.keymap.set({ "i", "s" }, "<C-j>", function()
							if luasnip.jumpable(-1) then
								luasnip.jump(-1)
							end
						end, { silent = true })
					end,
				},
				"hrsh7th/cmp-nvim-lsp",
				"onsails/lspkind.nvim",
			},
			config = function()
				local cmp = require("cmp")
				cmp.setup({
					snippet = {
						expand = function(args)
							require("luasnip").lsp_expand(args.body)
						end,
					},
					window = {
						completion = cmp.config.window.bordered(),
						documentation = cmp.config.window.bordered(),
					},
					mapping = cmp.mapping.preset.insert({
						["<C-a>"] = cmp.mapping.abort(),
						["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
						["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
						["<C-y>"] = cmp.mapping.confirm(
							{ behavior = cmp.ConfirmBehavior.Insert, select = true },
							{ "i", "c" }
						),
					}),
					sources = cmp.config.sources({
						{ name = "nvim_lsp" },
						{ name = "path" },
						{ name = "buffer" },
					}),
					formatting = {
						format = require("lspkind").cmp_format(),
					},
				})
			end,
		},
	},
	checker = { enabled = true },
})

vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlights" })
vim.keymap.set("n", "<leader>x", "<cmd>bd<cr>", { desc = "Close the current buffer" })
vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open Oil (file explorer)" })

local augroup = vim.api.nvim_create_augroup("user_cmds", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	desc = "Highlight when yanking text",
	callback = function()
		vim.highlight.on_yank()
	end,
})
vim.api.nvim_create_autocmd("LspAttach", {
	group = augroup,
	desc = "Choose between ts_ls and denols",
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local is_node_project = vim.fn.filereadable("package.json") == 1
		local is_deno_project = vim.fn.filereadable("deno.json") == 1

		if client.name == "denols" and is_node_project then
			client.stop()
			return
		elseif client.name == "ts_ls" and is_deno_project then
			client.stop()
			return
		end

		local telescope = require("telescope.builtin")
		vim.keymap.set("n", "gi", function()
			telescope.lsp_implementations()
		end, { silent = true })
		vim.keymap.set("n", "gd", function()
			telescope.lsp_definitions()
		end, { silent = true })
		vim.keymap.set("n", "gr", function()
			telescope.lsp_references()
		end, { silent = true })
		vim.keymap.set("n", "gT", function()
			telescope.lsp_type_definitions()
		end, { silent = true })
		vim.keymap.set("n", "gs", function()
			telescope.lsp_workspace_symbols()
		end, { silent = true })
	end,
})

vim.lsp.config["*"] = {
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
}

vim.lsp.config["luals"] = {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.RUNTIME,
				},
			},
			diagnostics = {
				globals = {
					"vim",
				},
			},
		},
	},
}
vim.lsp.config["denols"] = {
	cmd = { "deno", "lsp" },
	filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	root_markers = { "deno.json" },
	settings = {},
}
vim.lsp.config["ts_ls"] = {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	root_markers = { "package.json" },
	settings = {
		completions = {
			completeFunctionCalls = true,
		},
	},
}

vim.lsp.enable("luals")
vim.lsp.enable("denols")
vim.lsp.enable("ts_ls")
