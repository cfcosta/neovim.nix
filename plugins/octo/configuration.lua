require("octo").setup({})

vim.treesitter.language.register("markdown", "octo")

vim.api.nvim_create_autocmd("FileType", {
  pattern = "octo",

  callback = function()
    vim.keymap.set("i", "@", "@<C-x><C-o>", { silent = true, buffer = true })
    vim.keymap.set("i", "#", "#<C-x><C-o>", { silent = true, buffer = true })
  end,
})
