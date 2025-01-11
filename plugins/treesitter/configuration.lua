local parser_install_dir = vim.fn.stdpath("cache") .. "/treesitters"
vim.fn.mkdir(parser_install_dir, "p")

local new_runtimepath = vim.opt.runtimepath:get()
table.insert(new_runtimepath, 1, parser_install_dir)
vim.opt.runtimepath = new_runtimepath

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "agda",
    "bash",
    "beancount",
    "c",
    "cmake",
    "comment",
    "cpp",
    "css",
    "csv",
    "dockerfile",
    "elixir",
    "erlang",
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "go",
    "gomod",
    "gosum",
    "html",
    "hyprlang",
    "json",
    "latex",
    "llvm",
    "lua",
    "luau",
    "markdown",
    "markdown_inline",
    "mermaid",
    "nix",
    "python",
    "ruby",
    "rust",
    "sql",
    "ssh_config",
    "toml",
    "vim",
    "vimdoc",
    "yaml",
    "zig",
  },
  sync_install = false,
  auto_install = true,
  highlight = { enable = true },
  endwise = { enable = true },
  indent = { enable = true },
  parser_install_dir = parser_install_dir,
})

-- Enable folding using treesitter
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
