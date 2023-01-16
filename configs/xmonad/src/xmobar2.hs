import System.Environment
import System.IO.Unsafe (unsafeDupablePerformIO)
import Xmobar

main :: IO ()
main = xmobar =<< configFromArgs =<< myConfig

-- main = xmobar =<< myConfig

myHomeDir :: String
myHomeDir = unsafeDupablePerformIO (getEnv "HOME")

myConfig :: IO Config
myConfig =
  do
    pure
      baseConfig
        { template =
            concat $
              [ " <fn=2><fc=#212121,#212121:7>\xe0b6</fc></fn>\
                \<fn=4><fc=#558c8e,#212121:5>\xf30d </fc></fn>\
                \<fn=2><fc=#212121,#212121:7>\xe0b4</fc></fn> "
              ]
                <> ["<fn=5>@UnsafeXMonadLog@</fn>}{"]
                <> [ "<fn=2><fc=#212121,#212121:7>\xe0b6</fc></fn>\
                     \<fn=4><fc=#E06C75,#212121:5>@music@</fc></fn>\
                     \<fn=2><fc=#212121,#212121:7>\xe0b4</fc></fn> "
                   ]
                <> [ "<fn=2><fc=#212121,#212121:7>\xe0b6</fc></fn>\
                     \<fn=4><fc=#56B6C2,#212121:5>CPU: @cpu@%</fc></fn>\
                     \<fn=2><fc=#212121,#212121:7>\xe0b4</fc></fn> "
                   ]
                <> [ "<fn=2><fc=#212121,#212121:7>\xe0b6</fc></fn>\
                     \<fn=4><fc=#C678DD,#212121:5>Mem: @memory@% </fc></fn>\
                     \<fn=2><fc=#212121,#212121:7>\xe0b4</fc></fn> "
                   ]
                <> [ "<fn=2><fc=#212121,#212121:7>\xe0b6</fc></fn>\
                     \<fn=4><fc=#98C379,#212121:5>@vol@</fc></fn>\
                     \<fn=2><fc=#212121,#212121:7>\xe0b4</fc></fn> "
                   ]
                <> [ "<fn=2><fc=#212121,#212121:7>\xe0b6</fc></fn>\
                     \<fn=4><fc=#61AFEF,#212121:5>@date@</fc></fn>\
                     \<fn=2><fc=#212121,#212121:7>\xe0b4</fc></fn> "
                   ],
          commands = myCommands
        }

myCommands :: [Runnable]
myCommands =
  [ Run UnsafeXMonadLog,
    Run $ Com (myHomeDir <> "/.config/xmonad/scripts/volume.sh") ["vol"] "vol" 100,
    Run $ Date "\xf017 %-l:%M %p" "date" 600,
    Run $ Cpu ["-t", "<fc=#8c7f80><total></fc>", "-f", ":", "-H", "75", "-L", "25", "-h", "#56B6C2", "-n", "#4797a1", "-l", "#3a7b83"] 100,
    Run $ Memory ["-t", "<fc=#8c7f80><usedratio></fc>", "-f", ":", "-H", "75", "-L", "25", "-h", "#c678dd", "-n", "#9f60b1", "-l", "#855094"] 100,
    -- , Run $ Com (myHomeDir <> "/.config/xmonad/scripts/gputemp.sh") ["gpu"] "gpu" 5
    Run $ Com (myHomeDir <> "/.config/xmonad/scripts/trayer-padding.sh") ["trayer"] "trayer" 1000,
    Run $ Com (myHomeDir <> "/.config/xmonad/scripts/mpd.sh") ["music"] "music" 100
    -- , Run $ Com (myHomeDir <> "/.config/xmonad/src/trayer-padding.sh") ["trayer"] "trayer" 50
    -- , Run $ MPD ["-h", "127.0.0.1", "-p", "6600", "-t", "<composer> <title> <track>/<plength> <statei>", "--", "-P", ">>", "-Z", "|", "-S", "><"] 10
  ]

baseConfig :: Config
baseConfig =
  defaultConfig
    { font = "xft:UbuntuMono Nerd Font:pixelsize=12:antialias=true:hinting=true",
      additionalFonts =
        [ "xft:UbuntuMono Nerd Font:pixelsize=10:antialias=true:hinting=true",
          "xft:UbuntuMono Nerd Font:size=13:antialias=true:hinting=true",
          "xft:UbuntuMono Nerd Font:size=11:antialias=true:hinting=true",
          "xft:UbuntuMono Nerd Font:size=11:antialias=true:hinting=true",
          "xft:UbuntuMono Nerd Font:pixelsize=13:antialias=true:hinting=true"
        ],
      textOffsets = [20, 22, 21, 21, 20],
      bgColor = "#212121",
      fgColor = "#c8b6b8",
      borderColor = "#272727",
      border = FullB,
      borderWidth = 0,
      {-
      , position         = Static { xpos = 13, ypos = 1034, width = 1893, height = 32 } Bottom Padded
      , position         = Static { xpos = 0, ypos = 1048, width = 1920, height = 32 } Bottom Flat
      , position         = Static { xpos = 0, ypos = 0, width = 1920, height = 32 } Top Flat
      -}
      position = Static {xpos = 1920, ypos = 148, width = 1920, height = 30},
      alpha = 255,
      overrideRedirect = True,
      lowerOnStart = True,
      hideOnStart = False,
      allDesktops = True,
      persistent = True,
      iconRoot = myHomeDir ++ "/.config/xmonad/icons",
      iconOffset = -1,
      sepChar = "@",
      alignSep = "}{"
    }
