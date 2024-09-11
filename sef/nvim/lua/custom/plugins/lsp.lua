return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'stevearc/conform.nvim',
    'b0o/SchemaStore.nvim',
  },
  config = function()
    local capabilities = nil
    if pcall(require, 'cmp_nvim_lsp') then
      capabilities = require('cmp_nvim_lsp').default_capabilities()
    end

    local lspconfig = require('lspconfig')

    local servers = {
      lua_ls = {
        on_init = function(client)
          local path = client.workspace_folders[1].name
          if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
            return
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              version = 'LuaJIT'
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME
              }
            }
          })
        end,
        settings = {
          Lua = {}
        },
        server_capabilities = {
          semanticTokensProvider = vim.NIL,
        },
      },
      tsserver = {
        server_capabilities = {
          documentFormattingProvider = false,
        },
      },
      biome = {},
      eslint = {
        on_attach = function(_, bufnr)
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            command = 'EslintFixAll'
          })
        end,
      },
      jsonls = {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      },
      gleam = {},
      zls = {},
      omnisharp = {
        cmd = { "OmniSharp", "-lsp", "--hostPID", "tostring(vim.fn.getpid())" },
        settings = {

        },
      },
      nil_ls = {
        cmd = { vim.env.NIL_PATH or 'nil' },
        settings = {
          ['nil'] = {
            formatting = { command = { "nixfmt" } }
          }
        }
      },
      rust_analyzer = {}
    }

    for name, config in pairs(servers) do
      config = vim.tbl_deep_extend("force", {}, {
        capabilities = capabilities,
      }, config)

      lspconfig[name].setup(config)
    end

    local disable_semantic_tokens = {
      lua = true
    }

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local bufnr = args.buf
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id), 'must have valid client')
        local settings = servers[client.name]
        if type(settings) ~= "table" then
          settings = {}
        end
        local builtin = require('telescope.builtin')

        vim.keymap.set('n', 'gd', builtin.lsp_definitions, { buffer = 0 })
        vim.keymap.set('n', 'gr', builtin.lsp_references, { buffer = 0 })
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = 0 })
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = 0 })
        vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition, { buffer = 0 })
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = 0 })
        vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float, { buffer = 0 })

        vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { buffer = 0 })
        vim.keymap.set('n', '<leader>lc', vim.lsp.buf.code_action, { buffer = 0 })

        local filetype = vim.bo[bufnr].filetype
        if disable_semantic_tokens[filetype] then
          client.server_capabilities.semanticTokensProvider = nil
        end

        -- Override server capabilities
        if settings.server_capabilities then
          for k, v in pairs(settings.server_capabilities) do
            if v == vim.NIL then
              ---@diagnostic disable-next-line: cast-local-type
              v = nil
            end

            client.server_capabilities[k] = v
          end
        end
      end
    })

    -- Autoformatting Setup
    require("conform").setup {
      formatters_by_ft = {
        lua = { "stylua" },
      },
    }

    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function(args)
        require("conform").format {
          bufnr = args.buf,
          lsp_fallback = true,
          quiet = true,
        }
      end,
    })
  end
}
