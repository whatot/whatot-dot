local config = {

  -- Set colorscheme
  colorscheme = "tokyonight-moon",

  -- Add plugins
  plugins = {
      -- Extended file type support
      { "sheerun/vim-polyglot" },
      -- new colorschme
      { "folke/tokyonight.nvim" },
  },

  -- Extend LSP configuration
  lsp = {

    -- override the lsp installer server-registration function
    server_registration = function(server, opts)
        if (server.name == "bashls")
        then
            require("lspconfig")[server.name].setup({
                    filetypes = { "sh", "zsh" }
                })
        else
            require("lspconfig")[server.name].setup(opts)
        end
    end,

    -- Add overrides for LSP server settings, the keys are the name of the server
    ["server-settings"] = {
      yamlls = {
        settings = {
          yaml = {
            schemas = {
              ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
              ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
              ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
              ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.yml",
            },
          },
        },
      },
      dockerls = {
        root_pattern = {"Dockerfile", "Dockerfile.dev", "Dockerfile.prod"}
      }
    },
  },

  -- Diagnostics configuration (for vim.diagnostics.config({}))
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  -- null-ls configuration
  ["null-ls"] = function()
    -- Formatting and linting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim
    local status_ok, null_ls = pcall(require, "null-ls")
    if not status_ok then
      return
    end

    -- Check supported formatters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    local formatting = null_ls.builtins.formatting

    -- Check supported linters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    local diagnostics = null_ls.builtins.diagnostics

    null_ls.setup {
      debug = false,
      sources = {
        -- Set a formatter
        formatting.rufo,
        formatting.prettier,
        -- Set a linter
        diagnostics.rubocop,
        diagnostics.eslint,
      },
      -- NOTE: You can remove this on attach function to disable format on save
      on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
          vim.api.nvim_create_autocmd("BufWritePre", {
            desc = "Auto format before save",
            pattern = "<buffer>",
            callback = vim.lsp.buf.formatting_sync,
          })
        end
      end,
    }
  end,
}

return config
