local wezterm = require("wezterm")

local function font_with_fallback(name, params)
    local names = { name, "Apple Color Emoji", "azuki_font", "monospace" }
    return wezterm.font_with_fallback(names, params)
end

local font_name = {
    family = "Cartograph CF Nerd Font",
    harfbuzz_features = { 'calt = 0', 'clig = 0', 'liga=0' }
}

return {
    -- OpenGL for GPU acceleration, Software for CPU
    front_end = "OpenGL",

    -- colors = {
    --     foreground = "#bdbdbd",
    --     background = "#080808",
    --     cursor_bg = "#9e9e9e",
    --     cursor_fg = "#080808",
    --     selection_fg = "#080808",
    --     selection_bg = "#b2ceee",
    --
    --     ansi = {
    --         "#323437",
    --         "#ff5454",
    --         "#8cc85f",
    --         "#e3c78a",
    --         "#80a0ff",
    --         "#cf87e8",
    --         "#79dac8",
    --         "#c6c6c6",
    --     },
    --
    --     brights = {
    --         "#949494",
    --         "#ff5189",
    --         "#36c692",
    --         "#c2c292",
    --         "#74b2ff",
    --         "#ae81ff",
    --         "#85dc85",
    --         "#e4e4e4",
    --     },
    -- },

    -- Font config
    font = font_with_fallback(font_name),
    warn_about_missing_glyphs = false,
    font_size = 12,
    line_height = 1.0,
    dpi = 96.0,

    -- Cursor style
    default_cursor_style = "BlinkingUnderline",

    -- X11
    enable_wayland = false,

    -- Keybinds
    disable_default_key_bindings = true,
    keys = {
        -- standard copy/paste bindings
        {
            key = "x",
            mods = "CTRL",
            action = "ActivateCopyMode",
        },

        { key = '=', mods = 'CTRL', action = wezterm.action.IncreaseFontSize },
        { key = '-', mods = 'CTRL', action = wezterm.action.DecreaseFontSize },

        {
            key = "v",
            mods = "CTRL|SHIFT",
            action = wezterm.action({ PasteFrom = "Clipboard" }),
        },
        {
            key = "c",
            mods = "CTRL|SHIFT",
            action = wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" }),
        },
    },

    -- Aesthetic Night Colorscheme
    bold_brightens_ansi_colors = true,
    -- Padding
    window_padding = {
        left = 15,
        right = 15,
        top = 15,
        bottom = 15,
    },

    -- Tab Bar
    hide_tab_bar_if_only_one_tab = true,
    show_tab_index_in_tab_bar = false,
    tab_bar_at_bottom = true,

    -- General
    automatically_reload_config = true,
    inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 },
    window_background_opacity = 0.95,
    window_close_confirmation = "NeverPrompt",
    window_frame = { active_titlebar_bg = "#45475a", font = font_with_fallback(font_name, { bold = true }) },
    check_for_updates = false,

    color_scheme_dirs = { "~/.config/wezterm/colors" },

    color_scheme = "monochrome_glorb"
}
