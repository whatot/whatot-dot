local options = {
    formatters_by_ft = {
        lua = {"stylua"},
        css = {"prettier"},
        html = {"prettier"},
        markdown = {"markdownfmt"},
        sh = {"shfmt"},
        sql = {"sqlfmt"},
        -- Use the "*" filetype to run formatters on all filetypes.
        ["*"] = {"trim_whitespace"},
        -- Use the "_" filetype to run formatters on filetypes that don't have other formatters configured.
        ["_"] = {"trim_whitespace"}
    },

    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true
    },

    formatters = {
        shfmt = {
            inherit = false,
            command = "shfmt",
            args = {"-p", "-bn", "-ci", "-i", "2"}
        }
    }
}

return options
