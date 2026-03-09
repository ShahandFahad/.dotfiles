return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = true, -- suggestions appear as you type
        debounce = 75,
        keymap = {
          accept = "<M-l>",   -- Alt + l to accept
          accept_word = "<M-w>",
          accept_line = "<M-a>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      panel = { enabled = false }, -- Disabled for better performance
      filetypes = {
        markdown = true,
        help = false,
        gitcommit = false,
        gitrebase = false,
        ["."] = false,
      },
    })

    -- TOGGLE COMMAND
    vim.api.nvim_create_user_command("CopilotToggle", function()
      require("copilot.suggestion").toggle_auto_trigger()
    end, { desc = "Toggle Copilot auto-trigger" })
  end,
}
