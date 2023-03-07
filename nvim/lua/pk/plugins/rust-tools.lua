return {
    'simrat39/rust-tools.nvim',
    config = function()
      local status, rust_tools = pcall(require, 'rust-tools')
      if (not status) then return end

      rust_tools.setup {
          server = {
              settings = {
                  on_attach = function(_, bufnr)
                    -- Hover actions
                    vim.keymap.set('n', '<C-space>', rust_tools.hover_actions.hover_actions, { buffer = bufnr })
                    -- Code action groups
                    vim.keymaps.set('n', '<Leader>a', rust_tools.code_action_group.code_action_group, { buffer = bufnr })
                  end,
                  ["rust-analyzer"] = {
                      checkOnSave = {
                          command = "clippy"
                      }
                  }
              }
          }
      }
    end
}