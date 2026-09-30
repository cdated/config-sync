return {
  {
    "github/copilot.vim",
    config = function()
      -- You can put additional copilot.vim configuration here
    end,
  },
 {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      -- See Configuration section for options
    },
  },
}
