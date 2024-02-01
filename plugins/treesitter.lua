local parser_install_dir = vim.fn.stdpath("cache") .. "/treesitters"
vim.fn.mkdir(parser_install_dir, "p")

local new_runtimepath = vim.opt.runtimepath:get()
table.insert(new_runtimepath, 1, parser_install_dir)
vim.opt.runtimepath = new_runtimepath

-- Add support for just files
require("nvim-treesitter.install").compilers = { "gcc", "clang" }
require("nvim-treesitter.parsers").get_parser_configs().just = {
  install_info = {
    url = "https://github.com/IndianBoy42/tree-sitter-just",
    files = { "src/parser.c", "src/scanner.cc" },
    branch = "main",
    use_makefile = true, -- this may be necessary on MacOS (try if you see compiler errors)
  },
  maintainers = { "@IndianBoy42" },
}

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "bash",
    "c",
    "cmake",
    "cpp",
    "css",
    "csv",
    "dockerfile",
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "go",
    "gomod",
    "gosum",
    "html",
    "json",
    "just",
    "llvm",
    "lua",
    "markdown",
    "markdown_inline",
    "mermaid",
    "nix",
    "python",
    "rust",
    "sql",
    "ssh_config",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
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
