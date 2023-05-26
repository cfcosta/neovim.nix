return {
  "dpayne/CodeGPT.nvim",
  event = "VeryLazy",
  config = function()
    if os.getenv "OPENAI_API_KEY" then
      require "codegpt.config"
    end
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
  },
}
