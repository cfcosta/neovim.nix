-- Eviline config for lualine with Catppuccin colors
local lualine = require("lualine")
local devicons = require("nvim-web-devicons")

-- Color table for highlights
local C = require("catppuccin.palettes").get_palette("mocha")
local O = require("catppuccin").options

local fg = C.text
local bg = O.transparent_background and "NONE" or C.mantle

-- Function to select a deterministic color from the Catppuccin palette based on a string
local function string_to_color(str)
  local hash = 5381
  for i = 1, #str do
    hash = (hash * 33 + string.byte(str, i)) % 2 ^ 32
  end
  local palette_colors = { C.yellow, C.sky, C.blue, C.green, C.peach, C.mauve, C.pink, C.red }
  local index = (hash % #palette_colors) + 1
  return palette_colors[index]
end

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    disabled_filetypes = {
      statusline = {
        "Avante",
      },
    },

    component_separators = "",
    section_separators = "",
    theme = {
      normal = { c = { fg = fg, bg = bg } },
      inactive = { c = { fg = fg, bg = bg } },
    },
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left({
  function()
    local messages = {
      n = "Normal",
      i = "Insert",
      v = "Visual",
      ["\22"] = "Visual (block)",
      V = "Visual (line)",
      c = "Command",
      no = "O-pending",
      s = "Select",
      S = "S-line",
      ic = "Ins-comp",
      R = "Replace",
      Rv = "V-replace",
      cv = "Vim-ex",
      ce = "Ex",
      r = "Prompt",
      rm = "More",
      ["r?"] = "Confirm",
      ["!"] = "Shell",
      t = "Terminal",
    }

    return "󰍛 " .. messages[vim.fn.mode()] or vim.fn.mode()
  end,
  color = function()
    local mode_color = {
      R = C.red,
      Rv = C.red,
      S = C.peach,
      V = C.peach,
      ["!"] = C.red,
      ["\22"] = C.peach,
      ["r?"] = C.sky,
      c = C.mauve,
      ce = C.red,
      cv = C.red,
      i = C.green,
      ic = C.yellow,
      n = C.blue,
      no = C.red,
      r = C.sky,
      rm = C.sky,
      s = C.peach,
      t = C.peach,
      v = C.blue,
    }

    return { fg = mode_color[vim.fn.mode()] or C.red, gui = "bold" }
  end,
  padding = { right = 1 },
})

ins_left({
  "filename",
  color = { fg = C.lavender },
})

ins_left({
  "location",
  color = { fg = C.overlay1 },
  cond = conditions.buffer_not_empty,
})

ins_left({
  "progress",
  color = { fg = C.overlay1 },
  cond = conditions.buffer_not_empty,
})

ins_left({
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = { error = " ", warn = " ", info = " " },
  diagnostics_color = {
    error = { fg = C.red },
    warn = { fg = C.yellow },
    info = { fg = C.sky },
  },
})

ins_left({
  function()
    return "%="
  end,
})

ins_right({
  function()
    local msg = "none"
    local buf_ft = vim.bo.filetype
    local clients = vim.lsp.get_active_clients()

    if next(clients) == nil then
      return msg
    end

    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes

      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        local icon, _ = devicons.get_icon_by_filetype(buf_ft, { default = true })
        return icon .. " " .. client.name
      end
    end

    return msg
  end,
  color = function()
    local buf_ft = vim.bo.filetype
    local clients = vim.lsp.get_active_clients()
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return { fg = string_to_color(client.name), gui = "bold" }
      end
    end
    return { fg = fg, gui = "bold" }
  end,
  cond = conditions.hide_in_width,
})

ins_right({
  "branch",
  icon = "",
  color = { fg = C.lavender, gui = "bold" },
  cond = conditions.hide_in_width,
})

ins_right({
  "diff",
  symbols = { added = " ", modified = "󰝤 ", removed = " " },
  diff_color = {
    added = { fg = C.green },
    modified = { fg = C.peach },
    removed = { fg = C.red },
  },
  cond = conditions.hide_in_width,
})

lualine.setup(config)
