-- vim: ft=haskell
--
-- xmobar config - https://github.com/jaor/xmobar
-- depends on:
--   - xmonad
--
Config {
	-- BEHAVIOUR
     overrideRedirect = True
    , lowerOnStart = True
    , persistent = True
    -- APPEARANCE
    , font = "xft:FiraCode Nerd Font:style=Regular:size=12"
    , additionalFonts = ["xft:Open Sans:style=Regular:size=12"]
    --bgColor          = "#0d0e0c",
    , bgColor = "#212121"
    , fgColor = "#c8b6b8"
    , position = Static { xpos = 0, ypos = 0, width = 1920, height = 30 }
    -- MODULES
    , commands =
      [ Run Date "%a %b %d, %H:%M" "date" 10
      , Run Cpu [ "-t", "<fc=#8c7f80><bar></fc>", "-f", ":", "-H", "75", "-L", "25", "-h", "#C15A45", "-n", "#E4966D", "-l", "#BE8961" ] 10
      , Run Memory [ "-t", "<fc=#8c7f80><usedbar></fc>", "-f", ":", "-H", "75", "-L", "25", "-h", "#C15A45", "-n", "#E4966D", "-l", "#BE8961" ] 10
      , Run Com "amixer sget Master | awk -F\"[][]\" '/%/ { print $2 }' | head -n1" [] "volume" 1
     -- , Run ComX "tail" ["-n1", "/tmp/.xmonad-workspace-log"] " Xmonad" "ws" 1
      , Run ComX "tail" ["-n1", "/tmp/.xmonad-title-log"] "" "title" 1
      -- , Run ComX "xkb-switch" [] "en" "lang" 1
      , Run Com "/home/klein/.config/xmonad/xmobar/trayer-padding.sh" [] "trayerpad" 10
      , Run UnsafeStdinReader
      , Run UnsafeXMonadLog
      ]
    -- DISPLAY
    , alignSep = "}{"
    , sepChar = "%"
    , template = "   <fn=5>%UnsafeXMonadLog%</fn> }{ CPU: %cpu%  Mem: %memory%  %date%  %trayerpad%"
  }
