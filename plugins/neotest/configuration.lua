local neotest = require("neotest")

neotest.setup({
  adapters = {
    require("rustaceanvim.neotest"),
  },
})

vim.keymap.set("n", "<leader>ss", function()
  neotest.run.run()
end, { desc = "Neotest: Run nearest test" })

vim.keymap.set("n", "<leader>sf", function()
  neotest.run.run(vim.fn.expand("%"))
end, { desc = "Neotest: Run current file tests" })
