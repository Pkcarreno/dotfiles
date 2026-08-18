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
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", "Window left" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", "Window Down" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", "Window Up" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", "Window Right" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>", "Previous Window" },
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
}
