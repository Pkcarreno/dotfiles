return {
  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local jsServersSettings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "literal",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      }
      opts.servers = vim.tbl_extend("force", opts.servers, {
        vtsls = vim.tbl_extend("force", opts.servers.vtsls, {
          settings = jsServersSettings,
        }),
        tsserver = vim.tbl_extend("force", opts.servers.tsserver, {
          settings = jsServersSettings,
        }),
      })
    end,
  },
}
