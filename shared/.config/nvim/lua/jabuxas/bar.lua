local Mode = {}

Mode.map = {
    ['n']     = 'NORMAL',
    ['no']    = 'O-PENDING',
    ['nov']   = 'O-PENDING',
    ['noV']   = 'O-PENDING',
    ['no\22'] = 'O-PENDING',
    ['niI']   = 'NORMAL',
    ['niR']   = 'NORMAL',
    ['niV']   = 'NORMAL',
    ['nt']    = 'NORMAL',
    ['ntT']   = 'NORMAL',
    ['v']     = 'VISUAL',
    ['vs']    = 'VISUAL',
    ['V']     = 'V-LINE',
    ['Vs']    = 'V-LINE',
    ['\22']   = 'V-BLOCK',
    ['\22s']  = 'V-BLOCK',
    ['s']     = 'SELECT',
    ['S']     = 'S-LINE',
    ['\19']   = 'S-BLOCK',
    ['i']     = 'INSERT',
    ['ic']    = 'INSERT',
    ['ix']    = 'INSERT',
    ['R']     = 'REPLACE',
    ['Rc']    = 'REPLACE',
    ['Rx']    = 'REPLACE',
    ['Rv']    = 'V-REPLACE',
    ['Rvc']   = 'V-REPLACE',
    ['Rvx']   = 'V-REPLACE',
    ['c']     = 'COMMAND',
    ['cv']    = 'EX',
    ['ce']    = 'EX',
    ['r']     = 'REPLACE',
    ['rm']    = 'MORE',
    ['r?']    = 'CONFIRM',
    ['!']     = 'SHELL',
    ['t']     = 'TERMINAL',
}

function Mode.get_mode()
    local mode_code = vim.api.nvim_get_mode().mode
    if Mode.map[mode_code] == nil then
        return mode_code
    end
    return Mode.map[mode_code]
end

local function filename3()
    return vim.fn.expand("%:t")
end

local function location()
    return vim.fn.line('.') .. ":" .. vim.fn.charcol('.')
end

local function progress()
    local total_lines = vim.fn.line('$')
    local current_line = vim.fn.line('.')
    return math.floor((current_line / total_lines) * 100) .. "%%"
end

local function stats()
    return location() .. "  " .. progress()
end


function statusline_render()
    local components = { Mode.get_mode(), filename3(), stats() }
    local total_length = 0
    for _, component in ipairs(components) do
        total_length = total_length + vim.fn.strwidth(component)
    end

    local statusline_width = vim.fn.winwidth(0)
    local available_space = statusline_width - total_length
    local spaces_between = math.floor(available_space / (#components - 1))

    local statusline = ""
    for i, component in ipairs(components) do
        statusline = statusline .. component
        if i < #components then
            statusline = statusline .. string.rep(" ", spaces_between)
        end
    end

    return statusline
end

local autocmd = vim.api.nvim_create_autocmd
autocmd(
    {
        "WinEnter", "BufEnter", "BufWritePost", "SessionLoadPost", "FileChangedShellPost", "VimResized", "Filetype",
        "CursorMoved", "CursorMovedI", "ModeChanged" },
    {
        pattern = "*",
        callback = function()
            vim.opt.statusline = "%{%v:lua.statusline_render()%}"
        end,
    })
