return {
  -- disable NeoTree
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },

  {
    enabled = false,
    "folke/flash.nvim",
    ---@type Flash.Config
    opts = {
      search = {
        forward = true,
        multi_window = false,
        wrap = false,
        incremental = true,
      },
    },
  },

  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  {
    "nvim-mini/mini.hipatterns",
    event = "BufReadPre",
    opts = {
      highlighters = {
        hsl_color = {
          pattern = "hsl%(%d+,? %d+%%?,? %d+%%?%)",
          group = function(_, match)
            local utils = require("pk.hsl")
            --- @type string, string, string
            local nh, ns, nl = match:match("hsl%((%d+),? (%d+)%%?,? (%d+)%%?%)")
            --- @type number?, number?, number?
            local h, s, l = tonumber(nh), tonumber(ns), tonumber(nl)
            --- @type string
            local hex_color = utils.hslToHex(h, s, l)
            return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
          end,
        },
      },
    },
  },

  {
    "dinhhuy258/git.nvim",
    event = "BufReadPre",
    opts = {
      keymaps = {
        -- Open blame window
        blame = "<Leader>gb",
        -- Open file/folder in git repository
        browse = "<Leader>go",
      },
    },
  },

  {
    "vuki656/package-info.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      package_manager = "pnpm",
      hide_up_to_date = true,
    },
  },

  {
    "fzf-lua",
    opts = function(_, opts)
      local function tbl_isempty(T)
        assert(type(T) == "table", string.format("Expected table, got %s", type(T)))
        return next(T) == nil
      end

      local function is_hl_cleared(hl)
        -- `vim.api.nvim_get_hl_by_name` is deprecated since v0.9.0
        if vim.api.nvim_get_hl then
          local ok, hl_def = pcall(vim.api.nvim_get_hl, 0, { name = hl, link = false })
          if not ok or tbl_isempty(hl_def) then
            return true
          end
        else
          ---@diagnostic disable-next-line: deprecated
          local ok, hl_def = pcall(vim.api.nvim_get_hl_by_name, hl, true)
          -- Not sure if this is the right way but it seems that cleared
          -- highlights return 'hl_def[true] == 6' (?) and 'hl_def[true]'
          -- does not exist at all otherwise
          if not ok or hl_def[true] then
            return true
          end
        end
      end

      local function hl_validate(hl)
        return not is_hl_cleared(hl) and hl or nil
      end

      opts.hls = {
        normal = hl_validate("TelescopeNormal"),
        border = hl_validate("TelescopeBorder"),
        title = hl_validate("TelescopePromptTitle"),
        help_normal = hl_validate("TelescopeNormal"),
        help_border = hl_validate("TelescopeBorder"),
        preview_normal = hl_validate("TelescopeNormal"),
        preview_border = hl_validate("TelescopeBorder"),
        preview_title = hl_validate("TelescopePreviewTitle"),
        -- builtin preview only
        cursor = hl_validate("Cursor"),
        cursorline = hl_validate("TelescopeSelection"),
        cursorlinenr = hl_validate("TelescopeSelection"),
        search = hl_validate("IncSearch"),
      }
      opts.fzf_colors = {
        ["fg"] = { "fg", "TelescopeNormal" },
        ["bg"] = { "bg", "TelescopeNormal" },
        ["hl"] = { "fg", "TelescopeMatching" },
        ["fg+"] = { "fg", "TelescopeSelection" },
        ["bg+"] = { "bg", "TelescopeSelection" },
        ["hl+"] = { "fg", "TelescopeMatching" },
        ["info"] = { "fg", "TelescopeMultiSelection" },
        ["border"] = { "fg", "TelescopeBorder" },
        ["gutter"] = "-1",
        ["query"] = { "fg", "TelescopePromptNormal" },
        ["prompt"] = { "fg", "TelescopePromptPrefix" },
        ["pointer"] = { "fg", "TelescopeSelectionCaret" },
        ["marker"] = { "fg", "TelescopeSelectionCaret" },
        ["header"] = { "fg", "TelescopeTitle" },
      }
    end,
  },
}
