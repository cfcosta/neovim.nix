-- Eviline config for lualine with Catppuccin colors
local lualine = require('lualine')
local devicons = require('nvim-web-devicons')

-- Color table for highlights
local C = require("catppuccin.palettes").get_palette("mocha")
local O = require("catppuccin").options

local transparent_bg = O.transparent_background and "NONE" or C.mantle

local colors = {
  bg       = C.surface0,
  fg       = C.text,
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
      normal = { c = { fg = colors.fg, bg = transparent_bg } },
      inactive = { c = { fg = colors.fg, bg = transparent_bg } },
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
      ['^V'] = "Visual (block)",
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

    return messages[vim.fn.mode()] or vim.fn.mode()
  end,
  color = function()
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [''] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red,
    }
    return { fg = mode_color[vim.fn.mode()] or colors.red }
  end,
  padding = { right = 1 },
}

ins_left {
  'filename',
  cond = conditions.buffer_not_empty,
  color = { fg = colors.magenta, gui = 'bold' },
}

ins_left { 'location' }

ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

ins_left {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    error = { fg = colors.red },
    warn = { fg = colors.yellow },
    info = { fg = colors.cyan },
  },
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
  color = { fg = colors.fg, gui = 'bold' },
}

ins_right {
  'branch',
  icon = '',
  color = { fg = colors.violet, gui = 'bold' },
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
