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
        root_pattern = { "Dockerfile", "Dockerfile.dev", "Dockerfile.prod" }
      }
    },
  },

  -- Diagnostics configuration (for vim.diagnostics.config({}))
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

}

return config
