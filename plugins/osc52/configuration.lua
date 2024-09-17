local function copy(lines, _)
  require("osc52").copy(table.concat(lines, "\n"))
end

local function paste()
  return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
end

vim.g.clipboard = {
  name = "osc52",
  copy = {
    ["+"] = copy,
    ["*"] = copy,
    ["<D-c>"] = copy, -- Cmd+C on macOS
    ["<M-c>"] = copy, -- Super+C on Linux
  },
  paste = {
    ["+"] = paste,
    ["*"] = paste,
    ["<D-v>"] = paste, -- Cmd+V on macOS
    ["<M-v>"] = paste, -- Super+V on Linux
  },
}
