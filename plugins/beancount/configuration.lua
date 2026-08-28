-- `python_path` is injected by default.nix: a Python that can import `beancount`.
require("beancount").setup({
  python_path = python_path,
})

-- We are loaded from a FileType autocmd, so the ftplugin never ran for the
-- buffer that triggered the load. Source it now for any beancount buffer.
for _, buf in ipairs(vim.api.nvim_list_bufs()) do
  if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype == "beancount" then
    vim.api.nvim_buf_call(buf, function()
      vim.cmd.runtime("ftplugin/beancount.lua")
    end)
  end
end
