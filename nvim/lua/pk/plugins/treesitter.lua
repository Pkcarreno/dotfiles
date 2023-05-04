return {
  'nvim-treesitter/nvim-treesitter',
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    highlight             = {
      enable = true,
      disable = {},
    },
    indent                = {
      enable = true,
      disable = {},
    },
    ensure_installed      = {
      "markdown",
      "markdown_inline",
      "tsx",
      "typescript",
      "toml",
      "fish",
      "php",
      "json",
      "yaml",
      "css",
      "html",
      "lua",
      "rust",
      "astro"
    },
    autotag               = {
      enable = true,
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = true,
    }
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)

    local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
    parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
  end
}
