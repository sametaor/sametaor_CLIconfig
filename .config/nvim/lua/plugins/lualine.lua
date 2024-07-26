-- helper function to loop over string lines
-- copied from https://stackoverflow.com/a/19329565
local function iterlines(s)
  if s:sub(-1) ~= "\n" then
    s = s .. "\n"
  end
  return s:gmatch("(.-)\n")
end

-- current working directory
local function pwd()
  local pwd = vim.fn["getcwd"]()
  pwd = pwd:gsub("/home/christoph", "~")
  pwd = pwd:gsub("/home/hac5", "~")
  return pwd
end

-- current vimtux session
local function vimtux()
  -- get actual window name
  local cmd = "tmux display-message -p -t '"
    .. vim.b.vimtux["session"]
    .. ":"
    .. vim.b.vimtux["window"]
    .. "."
    .. vim.b.vimtux["pane"]
    .. "' -F '#W#F' 2>&1"
  local handle = assert(io.popen(cmd, "r"), "")
  -- output contains empty line at end
  local window_name = assert(handle:read("*a"))
  -- close io
  handle:close()
  -- remove newline
  if window_name:sub(-1) == "\n" then
    window_name = window_name:sub(1, -2)
  end
  if window_name:find("can.t find") then
    return "s:"
      .. vim.b.vimtux["session"]
      .. " w:"
      .. vim.b.vimtux["window"]
      .. " p:"
      .. vim.b.vimtux["pane"]
      .. " -> "
      .. window_name
      .. " !!!"
  end
  -- otherwise add window name
  return "s:"
    .. vim.b.vimtux["session"]
    .. " w:"
    .. vim.b.vimtux["window"]
    .. "|"
    .. window_name
    .. " p:"
    .. vim.b.vimtux["pane"]
end

-- current vim session
local function vim_session()
  local vs = vim.fn["xolox#session#find_current_session"]()
  if vs == nil or vs == "" then
    return vs
  else
    return vs .. ":"
  end
end

-- write file_exists
function check_file_path()
  -- terminal
  if vim.bo.buftype == "terminal" then
    return
  end
  local file = vim.fn.expand("%:p")
  -- fix fugitive etc.
  git_state = { "", "", "", "" }
  if file:find("^[%w-]+://") ~= nil then
    git_state[1] = " " .. file:gsub("^([%w-]+)://.*", "%1") .. " "
    file = file:gsub("^[%w-]+://", "")
  end
  vim.b.git_state = git_state
  -- check file exists?
  ok, err, code = os.rename(file, file)
  -- check dir
  if ok or code == 13 then
    -- write buffer variable
    vim.b["file_exists"] = 1
  else
    vim.b["file_exists"] = 0
  end
end

-- find directory
function find_dir(d)
  -- return if root
  if d == "/" then
    return d
  end
  -- initialize git_state variable
  if vim.b.git_state == nil then
    vim.b.git_state = { "", "", "", "" }
  end
  -- fix terminal
  if d:find("term://") ~= nil then
    return "/tmp"
  end
  -- fix fzf
  if d:find("/tmp/.*FZF") ~= nil then
    return "/tmp"
  end
  -- fix fugitive etc.
  if d:find("^[%w-]+://") ~= nil then
    vim.b.git_state[1] = " " .. d:gsub("^([%w-]+)://.*", "%1") .. " "
    d = d:gsub("^[%w-]+://", "")
  end
  -- check renaming
  local ok, err, code = os.rename(d, d)
  if not ok then
    if code ~= 2 then
      -- all other than not existing
      return d
    end
    -- not existing
    local newd = d:gsub("(.*/)[%w._-]+/?$", "%1")
    return find_dir(newd)
  end
  -- d ok
  return d
end

-- check if file exists
local function file_exists()
  return vim.b["file_exists"] == 1
end

-- get git status
local function git_status()
  vim.b.git_state = { "", "", "" }
  -- get & check file directory
  file_dir = find_dir(vim.fn.expand("%:p:h"))
  -- check fugitive etc.
  if vim.b.git_state[1] ~= "" then
    return "d"
  end
  -- capture git status call
  local cmd = "git -C " .. file_dir .. " status --porcelain -b 2> /dev/null"
  local handle = assert(io.popen(cmd, "r"), "")
  -- output contains empty line at end (removed by iterlines)
  local output = assert(handle:read("*a"))
  -- close io
  handle:close()

  --  (| not in output, marks start and end of first two chars for readability)
  -- first line, head:
  --   ## master...origin/master => up to date => green
  --   ## master...origin/master [ahead 1] => ahead of origin => green + arrows up ↑
  --   ## master...origin/master [behind 1] => behind origin => green + arrows down ↓
  --   ## master...origin/master [ahead 1, behind 1] => both
  --   ## HEAD (no branch) => HEAD detached => purple
  -- following lines, files:
  --   |??| => untracked file
  --   | D| => deleted = modified
  --   |R | => renamed = staged
  --   etc. first char staged, second char modified

  -- iterate over lines
  -- git_state is array with entries branch/staged/modified/untracked
  local git_state = { "", "", "", "" }
  -- branch coloring: 'o': up to date with origin; 'd': head detached; 'm': not up to date with origin
  local branch_col = "o"

  -- check if git repo
  if output == "" then
    -- not a git repo
    -- save to variable
    vim.b.git_state = git_state
    -- exit
    return branch_col
  end

  -- get line iterator
  local line_iter = iterlines(output)

  -- process first line (HEAD)
  local line = line_iter()
  if line:find("%(no branch%)") ~= nil then
    -- detached head
    branch_col = "d"
  else
    -- on branch
    local ahead = line:gsub(".*ahead (%d+).*", "%1")
    local behind = line:gsub(".*behind (%d+).*", "%1")
    -- convert non-numeric to nil
    ahead = tonumber(ahead)
    behind = tonumber(behind)
    if behind ~= nil then
      git_state[1] = "↓ " .. tostring(behind) .. " "
    end
    if ahead ~= nil then
      git_state[1] = git_state[1] .. "↑ " .. tostring(ahead) .. " "
    end
  end

  -- loop over residual lines (files) &
  -- store number of files
  local git_num = { 0, 0, 0 }
  for line in line_iter do
    branch_col = "m"
    -- get first char
    local first = line:gsub("^(.).*", "%1")
    if first == "?" then
      -- untracked
      git_num[3] = git_num[3] + 1
    elseif first ~= " " then
      -- staged
      git_num[1] = git_num[1] + 1
    end
    -- get second char
    local second = line:gsub("^.(.).*", "%1")
    if second == "M" or second == "D" then
      -- modified or deleted
      git_num[2] = git_num[2] + 1
    end
  end

  -- build output string
  if git_num[1] ~= 0 then
    git_state[2] = "● " .. git_num[1]
  end
  if git_num[2] ~= 0 then
    git_state[3] = "+ " .. git_num[2]
  end
  if git_num[3] ~= 0 then
    git_state[4] = "… " .. git_num[3]
  end

  -- save to variable
  vim.b.git_state = git_state

  return branch_col
end

-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore

local mode_map = {
  ['NORMAL'] = ' N',
  ['O-PENDING'] = ' N?',
  ['INSERT'] = '󱩽  I',
  ['VISUAL'] = '  V',
  ['V-BLOCK'] = '󱂔  VB',
  ['V-LINE'] = '󰡮 VL',
  ['V-REPLACE'] = '󰡬 VR',
  ['REPLACE'] = '  R',
  ['COMMAND'] = '  !',
  ['SHELL'] = '  SH',
  ['TERMINAL'] = '  T',
  ['EX'] = '󰧧 X',
  ['S-BLOCK'] = '  SB',
  ['S-LINE'] = '  SL',
  ['SELECT'] = '󰩭  S',
  ['CONFIRM'] = '󰡕  Y?',
  ['MORE'] = '󰍻  M',
}

local colors = {
  blue = "#0077C2",
  cyan = "#61AFEF",
  darkcyan = "#0ABBC4",
  black = "#1A1B26",
  darkblack = "#010409",
  white = "#FBFBFB",
  lightwhite = "#E6EDF3",
  red = "#E06C75",
  violet = "#8368B5",
  grey = "#9cacb2",
  green = "#4CAF50",
  darkgreen = "#9DCC69",
  yellow = "#F57800",
  paleyellow = "#FFE268",
  darkgray = "#5a6b73",
  lightgray = "#c2ccd1",
  inactivegray = "#333638",
}

local samline = {
  normal = {
    a = { bg = colors.white, fg = colors.blue, gui = "bold" },
    b = { bg = colors.blue, fg = colors.white },
    c = { fg = colors.lightwhite },
    x = { bg = "", fg = colors.lightwhite },
    y = { bg = colors.green, fg = colors.lightwhite },
    z = { bg = colors.cyan, fg = colors.lightwhite },
  },
  insert = {
    a = { bg = colors.paleyellow, fg = colors.blue, gui = "bold" },
    b = { bg = colors.blue, fg = colors.white },
    c = { fg = colors.lightwhite },
    x = { bg = "", fg = colors.lightwhite },
    y = { bg = colors.green, fg = colors.lightwhite },
    z = { bg = colors.cyan, fg = colors.lightwhite },
  },
  visual = {
    a = { bg = colors.yellow, fg = colors.white, gui = "bold" },
    b = { bg = colors.blue, fg = colors.white },
    c = { fg = colors.lightwhite },
    x = { bg = "", fg = colors.lightwhite },
    y = { bg = colors.green, fg = colors.lightwhite },
    z = { bg = colors.cyan, fg = colors.lightwhite },
  },
  replace = {
    a = { bg = colors.white, fg = colors.red, gui = "bold" },
    b = { bg = colors.blue, fg = colors.white },
    c = { fg = colors.lightwhite },
    x = { bg = "", fg = colors.lightwhite },
    y = { bg = colors.green, fg = colors.lightwhite },
    z = { bg = colors.cyan, fg = colors.lightwhite },
  },
  command = {
    a = { bg = colors.darkgreen, fg = colors.white, gui = "bold" },
    b = { bg = colors.blue, fg = colors.white },
    c = { fg = colors.lightwhite },
    x = { bg = "", fg = colors.lightwhite },
    y = { bg = colors.green, fg = colors.lightwhite },
    z = { bg = colors.cyan, fg = colors.lightwhite },
  },
  inactive = {
    a = { bg = colors.darkgray, fg = colors.gray, gui = "bold" },
    b = { bg = colors.darkgray, fg = colors.gray },
    c = { fg = colors.gray },
  },
}

return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = samline,
          icons_enabled = true,
          component_separators = "",
          section_separators = "",
        },
        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function(s)
                return mode_map[s] or s
              end,
              separator = { left = "", right = "" },
              left_padding = 1,
            },
          },
          lualine_b = {
            {
              icon = " ",
              "hostname",
              separator = { right = "  " },
            },
          },
          lualine_c = {
            {
              icon = " ",
              "branch",
              color = function(section)
                local gs = git_status()
                if gs == "d" then
                  return { fg = "#916BDD" }
                elseif gs ~= "m" then
                  return { fg = "#769945" }
                end
              end,
            },
            {
              -- head status
              "vim.b.git_state[1]",
              color = function(section)
                if vim.b.git_state[1]:find("^ %w+ $") ~= nil then
                  return { fg = "#F49B55" }
                end
              end,
              padding = { left = 0, right = 0 },
            },
            {
              -- staged files
              "vim.b.git_state[2]",
              color = { fg = "#769945" },
              padding = { left = 0, right = 1 },
            },
            {
              -- modified files
              "vim.b.git_state[3]",
              color = { fg = "#D75F00" },
              padding = { left = 0, right = 1 },
            },
            {
              -- untracked files
              "vim.b.git_state[4]",
              color = { fg = "#D99809" },
              padding = { left = 0, right = 1 },
            },
          },
          lualine_x = {
            { "filetype", left_padding = 1 },
            {
              require("noice").api.status.message.get_hl,
              cond = require("noice").api.status.message.has,
            },
            {
              require("noice").api.status.command.get,
              cond = require("noice").api.status.command.has,
            },
            {
              require("noice").api.status.mode.get,
              cond = require("noice").api.status.mode.has,
            },
            {
              require("noice").api.status.search.get,
              cond = require("noice").api.status.search.has,
            },
          },
          lualine_y = { { icon = " ", "datetime", style = "%H:%M", separator = { left = "" } } },
          lualine_z = {
            { icon = " ", "location", separator = { left = "", right = "" } },
          },
        },
        inactive_sections = {
          lualine_a = { "filename" },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { "location" },
        },
        tabline = {},
        extensions = {},
      })
    end,
  },
}
