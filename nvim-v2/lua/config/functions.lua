-- Custom functions used by keymaps
local M = {}

--------------------------------------------------------------------------------
-- COPY FILE PATH (with line numbers)
-- Copies relative path with line number(s) in normal/visual mode
-- Normal: path/file.lua:42
-- Visual: path/file.lua:10-20
--------------------------------------------------------------------------------

function M.copy_path_with_lines()
  local relative_path = vim.fn.expand("%:.")
  local mode = vim.api.nvim_get_mode().mode

  local result
  if mode == "v" or mode == "V" or mode == "\22" then
    local start_line = vim.fn.line("v")
    local end_line = vim.fn.line(".")
    if start_line > end_line then
      start_line, end_line = end_line, start_line
    end

    if start_line == end_line then
      result = string.format("%s:%d", relative_path, start_line)
    else
      result = string.format("%s:%d-%d", relative_path, start_line, end_line)
    end
  else
    local current_line = vim.fn.line(".")
    result = string.format("%s:%d", relative_path, current_line)
  end

  vim.fn.setreg("+", result)
  vim.notify("Copied: " .. result, vim.log.levels.INFO)
end

--------------------------------------------------------------------------------
-- COPY FILE PATH (without line numbers)
--------------------------------------------------------------------------------

function M.copy_path()
  local relative_path = vim.fn.expand("%:.")
  vim.fn.setreg("+", relative_path)
  vim.notify("Copied: " .. relative_path, vim.log.levels.INFO)
end

--------------------------------------------------------------------------------
-- OPEN FILE FROM CLIPBOARD
-- Parses "path/file.lua:42" from clipboard and opens it at that line
--------------------------------------------------------------------------------

function M.open_from_clipboard()
  local clip = vim.fn.getreg("+"):gsub("%s+", "")
  local file, lnum = clip:match("^(.+):(%d+):%d+$")
  if not file then
    file, lnum = clip:match("^(.+):(%d+)$")
  end
  if not file then
    file = clip
  end
  local path = vim.fn.fnamemodify(file, ":p")
  if vim.fn.filereadable(path) == 0 then
    local matches = vim.fn.glob(vim.fn.getcwd() .. "/**/" .. file, false, true)
    if #matches > 0 then
      path = matches[1]
    else
      vim.notify("File not found: " .. file, vim.log.levels.WARN)
      return
    end
  end
  vim.cmd("edit " .. vim.fn.fnameescape(path))
  if lnum then
    vim.api.nvim_win_set_cursor(0, { tonumber(lnum), 0 })
    vim.cmd("normal! zz")
  end
end

--------------------------------------------------------------------------------
-- DELETE OTHER BUFFERS
-- Closes all buffers except the current one (using MiniBufremove)
--------------------------------------------------------------------------------

function M.delete_other_buffers()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.bo[buf].buflisted and vim.bo[buf].buftype == "" then
      MiniBufremove.delete(buf)
    end
  end
end

--------------------------------------------------------------------------------
-- FORMAT WITH EXTERNAL TOOL
-- Runs an external formatter on the whole buffer, preserving cursor position
--------------------------------------------------------------------------------

function M.format_with(cmd)
  return function()
    local cursor_pos = vim.fn.getcurpos()
    vim.cmd(":%!" .. cmd)
    vim.fn.setpos(".", cursor_pos)
  end
end

--------------------------------------------------------------------------------
-- TERMINAL
-- Toggleable bottom split terminal (40% height)
-- Reuses the same terminal buffer across toggles
--------------------------------------------------------------------------------

local term_buf = nil
local term_win = nil

local function find_term_win()
  if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_buf(win) == term_buf then
        return win
      end
    end
  end
  return nil
end

function M.toggle_terminal()
  term_win = find_term_win()

  if term_win then
    vim.api.nvim_win_hide(term_win)
    term_win = nil
    return
  end

  local height = math.floor(vim.o.lines * 0.4)
  vim.cmd("botright " .. height .. "split")
  if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
    vim.api.nvim_win_set_buf(0, term_buf)
  else
    vim.cmd("terminal")
    term_buf = vim.api.nvim_get_current_buf()
  end
  term_win = vim.api.nvim_get_current_win()
  vim.cmd("startinsert")
end

--------------------------------------------------------------------------------
-- WINDOW RESIZE MODE
-- Enter with a keymap, then use h/j/k/l to resize, Esc to exit
--------------------------------------------------------------------------------

function M.resize_mode()
  vim.notify("Resize mode: h/j/k/l to resize, Esc to exit", vim.log.levels.INFO)
  local step = 5
  while true do
    vim.cmd("redraw")
    local key = vim.fn.getcharstr()
    if key == "h" then
      vim.cmd("vertical resize -" .. step)
    elseif key == "l" then
      vim.cmd("vertical resize +" .. step)
    elseif key == "j" then
      vim.cmd("resize -" .. step)
    elseif key == "k" then
      vim.cmd("resize +" .. step)
    else
      break
    end
  end
end

return M
