-- Eviline config for lualine with Catppuccin colors
local lualine = require('lualine')
local devicons = require('nvim-web-devicons')

-- Color table for highlights
local C = require("catppuccin.palettes").get_palette("mocha")
local O = require("catppuccin").options

local fg = C.text
local bg = O.transparent_background and "NONE" or C.mantle

local colors = {
  yellow   = C.yellow,
  cyan     = C.sky,
  darkblue = C.blue,
  green    = C.green,
  orange   = C.peach,
  violet   = C.mauve,
  magenta  = C.pink,
  blue     = C.blue,
  red      = C.red,
}

-- Function to select a deterministic color from the colors table based on a string
local function string_to_color(str)
  local hash = 5381
  for i = 1, #str do
    hash = (hash * 33 + string.byte(str, i)) % 2 ^ 32
  end
  local color_names = {}
  for name, _ in pairs(colors) do
    table.insert(color_names, name)
  end
  local index = (hash % #color_names) + 1
  return colors[color_names[index]]
end

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    component_separators = '',
    section_separators = '',
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

ins_left {
  function()
    local messages = {
      n = "Normal",
      i = "Insert",
      v = "Visual",
      ['\22'] = "Visual (block)",
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
      ['r?'] = "Confirm",
      ['!'] = "Shell",
      t = "Terminal"
    }

    return "󰍛 " .. messages[vim.fn.mode()] or vim.fn.mode()
  end,
  color = function()
    local mode_color = {
      R = colors.red,
      Rv = colors.red,
      S = colors.orange,
      V = colors.blue,
      ['!'] = colors.red,
      ['\22'] = colors.blue,
      ['r?'] = colors.cyan,
      c = colors.magenta,
      ce = colors.red,
      cv = colors.red,
      i = colors.green,
      ic = colors.yellow,
      n = colors.violet,
      no = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      s = colors.orange,
      t = colors.violet,
      v = colors.blue,
    }
    return { fg = mode_color[vim.fn.mode()] or colors.red }
  end,
  padding = { right = 1 },
  cond = conditions.hide_in_width,
}

ins_left {
  'filename',
  cond = conditions.buffer_not_empty and conditions.hide_in_width,
  color = { fg = colors.magenta, gui = 'bold' },
}

ins_left {
  'location',
  cond = conditions.buffer_not_empty,
}

ins_left {
  'progress',
  color = { fg = fg, gui = 'bold' },
  cond = conditions.buffer_not_empty,
}

ins_left {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    error = { fg = colors.red },
    warn = { fg = colors.yellow },
    info = { fg = colors.cyan },
  },
  cond = conditions.hide_in_width,
}

ins_left {
  function()
    return '%='
  end,
}

ins_right {
  function()
    local msg = 'none'
    local buf_ft = vim.bo.filetype
    local clients = vim.lsp.get_active_clients()

    if next(clients) == nil then
      return msg
    end

    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes

      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        local icon, _ = devicons.get_icon_by_filetype(buf_ft, { default = true })
        return icon .. ' ' .. client.name
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
        return { fg = string_to_color(client.name), gui = 'bold' }
      end
    end
    return { fg = fg, gui = 'bold' }
  end,
  cond = conditions.hide_in_width,
}

ins_right {
  'branch',
  icon = '',
  color = { fg = colors.violet, gui = 'bold' },
  cond = conditions.hide_in_width,
}

ins_right {
  'diff',
  symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
}

lualine.setup(config)
