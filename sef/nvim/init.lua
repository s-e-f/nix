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
				local telescope = require("telescope")
				telescope.load_extension("media_files")
				telescope.setup({
					extensions = {
						media_files = {
							filetypes = { "png", "webp", "jpg", "jpeg", "gif", "pdf", "mp4", "webm" },
							find_cmd = "rg",
						},
					},
				})
				local telescope_builtin = require("telescope.builtin")
				vim.keymap.set("n", "<leader>ff", function()
					telescope_builtin.find_files()
				end, { desc = "Fuzzy find files" })
				vim.keymap.set("n", "<leader>fh", function()
					telescope_builtin.help_tags()
				end, { desc = "Fuzzy find help" })
				vim.keymap.set("n", "<leader>fg", function()
					telescope_builtin.live_grep()
				end, { desc = "Live grep" })
				local telescope_ext = telescope.extensions
				vim.keymap.set("n", "<leader>fm", function()
					telescope_ext.media_files.media_files()
				end, { silent = true })
			end,
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope-fzf-native.nvim",
				"nvim-telescope/telescope-media-files.nvim",
			},
		},
		{
			"folke/snacks.nvim",
			priority = 1000,
			opts = {
				statuscolumn = {},
				quickfile = {},
			},
		},
		{
			"williamboman/mason.nvim",
			config = function()
				require("mason").setup({
					registries = {
						"github:mason-org/mason-registry",
						"github:crashdummyy/mason-registry",
					},
				})
			end,
		},
		{
			"seblyng/roslyn.nvim",
			ft = { "cs", "razor" },
			dependencies = {
				{
					"tris203/rzls.nvim",
					config = function()
						require("rzls").setup({})
					end,
				},
			},
			config = function()
				require("roslyn").setup({
					args = {
						"--stdio",
						"--logLevel=Information",
						"--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
						"--razorSourceGenerator=" .. vim.fs.joinpath(
							vim.fn.stdpath("data") --[[@as string]],
							"mason",
							"packages",
							"roslyn",
							"libexec",
							"Microsoft.CodeAnalysis.Razor.Compiler.dll"
						),
						"--razorDesignTimePath=" .. vim.fs.joinpath(
							vim.fn.stdpath("data") --[[@as string]],
							"mason",
							"packages",
							"rzls",
							"libexec",
							"Targets",
							"Microsoft.NET.Sdk.Razor.DesignTime.targets"
						),
					},
					---@diagnostic disable-next-line: missing-fields
					config = {
						handlers = require("rzls.roslyn_handlers"),
						settings = {
							["csharp|inlay_hints"] = {
								csharp_enable_inlay_hints_for_implicit_object_creation = true,
								csharp_enable_inlay_hints_for_implicit_variable_types = true,

								csharp_enable_inlay_hints_for_lambda_parameter_types = true,
								csharp_enable_inlay_hints_for_types = true,
								dotnet_enable_inlay_hints_for_indexer_parameters = true,
								dotnet_enable_inlay_hints_for_literal_parameters = true,
								dotnet_enable_inlay_hints_for_object_creation_parameters = true,
								dotnet_enable_inlay_hints_for_other_parameters = true,
								dotnet_enable_inlay_hints_for_parameters = true,
								dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
								dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
								dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
							},
							["csharp|code_lens"] = {
								dotnet_enable_references_code_lens = true,
							},
						},
					},
				})
			end,
			init = function()
				-- we add the razor filetypes before the plugin loads
				vim.filetype.add({
					extension = {
						razor = "razor",
						cshtml = "razor",
					},
				})
			end,
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
						"go",
						"gomod",
						"gosum",
						"gowork",
						"gotmpl",
						"templ",

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
		{
			"neovim/nvim-lspconfig",
			dependencies = {
				{
					"folke/lazydev.nvim",
					ft = "lua", -- only load on lua files
					opts = {
						library = {
							-- See the configuration section for more details
							-- Load luvit types when the `vim.uv` word is found
							{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
						},
					},
				},
			},
			config = function()
				local lspconfig = require("lspconfig")
				lspconfig.lua_ls.setup({})
				lspconfig.zls.setup({})
				lspconfig.rust_analyzer.setup({})
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
	desc = "LSP keymaps",
	callback = function()
		local telescope = require("telescope.builtin")
		vim.api.nvim_set_hl(0, "NormalFloat", { link = "CursorLine" })
		vim.keymap.set("n", "gd", function()
			telescope.lsp_definitions()
		end, { silent = true })
		vim.keymap.set("n", "gr", function()
			telescope.lsp_references()
		end, { silent = true })
		vim.keymap.set("n", "gi", function()
			telescope.lsp_implementations()
		end, { silent = true })
		vim.keymap.set("n", "<space>le", function()
			vim.diagnostic.open_float()
		end, { silent = true })
		vim.keymap.set("n", "<space>lc", function()
			vim.lsp.buf.code_action()
		end, { silent = true })
	end,
})
