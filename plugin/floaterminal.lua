-- Store state across the floating window.
local state = {
  floating = {
    buf = -1,
    win = -1
  }
}

-- Create a centered floating window
-- @param opts table Optional configuration
--   - width: number (0-1 for percentage, >1 for absolute) Default: 0.8
--   - height: number (0-1 for percentage, >1 for absolute) Default: 0.8
-- @return number, number bufnr, winnr
local function create_floating_terminal(opts)
  opts = opts or {}

  -- Get editor dimensions
  local ui = vim.api.nvim_list_uis()[1]
  local width = ui.width
  local height = ui.height

  -- Default to 80% of current window
  local float_width = opts.width or 0.8
  local float_height = opts.height or 0.8

  -- Convert percentages to absolute values
  if float_width <= 1 then
    float_width = math.floor(width * float_width)
  end
  if float_height <= 1 then
    float_height = math.floor(height * float_height)
  end

  -- Calculate center position
  local col = math.floor((width - float_width) / 2)
  local row = math.floor((height - float_height) / 2)

  -- Create buffer
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  -- Window configuration
  local win_opts = {
    relative = 'editor',
    width = float_width,
    height = float_height,
    col = col,
    row = row,
    style = 'minimal',
    border = 'rounded'
  }

  -- Create window
  local win = vim.api.nvim_open_win(buf, true, win_opts)

  return { buf = buf, win = win }
end

local toggle_terminal = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_terminal { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

-- User command to create and toggle a terminal.
vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})
vim.keymap.set({ "n", "t" }, "<space>tt", toggle_terminal)

return create_floating_terminal
