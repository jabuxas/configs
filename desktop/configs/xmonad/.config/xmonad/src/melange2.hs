import System.Environment
import System.IO.Unsafe (unsafeDupablePerformIO)
import Xmobar

main :: IO ()
main = xmobar =<< configFromArgs =<< myConfig

myHomeDir :: String
myHomeDir = unsafeDupablePerformIO (getEnv "HOME")

myConfig :: IO Config
myConfig =
  do
    pure
      baseConfig
        { template =
            concat $
              [ "<fn=2><fc=#292522,#292522:7>\xe0b6</fc></fn>\
                \<fn=6><fc=#E49B5D,#292522:5>\xf30d </fc></fn>\
                \<fn=2><fc=#292522,#292522:7>\xe0b4</fc></fn>"
              ]
                <> ["<fn=2>@UnsafeXMonadLog@</fn>}"]
                <> [ "<fn=2><fc=#292522,#292522:7>\xe0b6</fc></fn>\
                     \<fn=4><fc=#ebc06d,#292522:5>\xf017 </fc></fn>\
                     \<fn=5>@date@</fn>{"
                   ]
                <> [ "<fn=2><fc=#292522,#292522:7>\xe0b6</fc></fn>\
                     \<fn=4><fc=#89b3b6,#292522:5>\xf2db </fc></fn>\
                     \<fn=5>CPU: @cpu@% |</fn>"
                   ]
                <> [ "<fn=2><fc=#292522,#292522:7>\xe0b6</fc></fn>\
                     \<fn=4><fc=#b380b0,#292522:5>\xf538 </fc></fn>\
                     \<fn=5>Mem: @memory@% |</fn>"
                   ]
                <> [ "<fn=2><fc=#292522,#292522:7>\xe0b6</fc></fn>\
                     \<fn=4><fc=#78997a,#292522:5>@volicon@</fc></fn>\
                     \<fn=5>@vol@<fc=#78997a,#292522:5>%</fc> |</fn>"
                   ]
                <> [ "<fn=2><fc=#292522,#292522:7>\xe0b6</fc></fn>\
                     \<fn=4><fc=#d47766,#292522:5>\xf001 </fc></fn>\
                     \<fn=5><fc=#d47766,#292522:5>@music@</fc></fn>\
                     \<fn=2><fc=#292522,#292522:7>\xe0b4</fc></fn>"
                   ],
          commands = myCommands
        }

myCommands :: [Runnable]
myCommands =
  [ Run UnsafeXMonadLog,
    Run $ Com (myHomeDir <> "/.config/xmonad/scripts/volume.sh") ["vol"] "vol" 100,
    Run $ Com (myHomeDir <> "/.config/xmonad/scripts/volumeicon.sh") ["volicon"] "volicon" 100,
    Run $ Date "%A, %d/%m/%Y. <fc=#ebc06d,#292522:5>%H:%M</fc>" "date" 600,
    Run $ Cpu ["-t", "<fc=#8c7f80><total></fc>", "-f", ":", "-H", "75", "-L", "25", "-h", "#89b3b6", "-n", "#4797a1", "-l", "#3a7b83"] 100,
    Run $ Memory ["-t", "<fc=#8c7f80><usedratio></fc>", "-f", ":", "-H", "75", "-L", "25", "-h", "#b380b0", "-n", "#9f60b1", "-l", "#855094"] 100,
    -- , Run $ Com (myHomeDir <> "/.config/xmonad/scripts/gputemp.sh") ["gpu"] "gpu" 5
    Run $ XPropertyLog "_XMONAD_TRAYPAD",
    Run $ Com (myHomeDir <> "/.config/xmonad/scripts/mpd.sh") ["music"] "music" 100
    -- , Run $ Com (myHomeDir <> "/.config/xmonad/src/trayer-padding.sh") ["trayer"] "trayer" 50
    -- , Run $ MPD ["-h", "127.0.0.1", "-p", "6600", "-t", "<composer> <title> <track>/<plength> <statei>", "--", "-P", ">>", "-Z", "|", "-S", "><"] 10
  ]

baseConfig :: Config
baseConfig =
  defaultConfig
    { font = "Cartograph CF Italic 11",
      additionalFonts =
        [ "Cartograph CF Italic 10",
          "Cartograph CF Italic 11",
          "Cartograph CF Italic 11",
          "JetBrainsMono Nerd Font 10",
          "Cartograph CF Italic 11",
          "JetBrainsMono Nerd Font 13"
        ],
      -- textOffsets = [20, 22, 21, 21, 20],
      bgColor = "#292522",
      fgColor = "#ECE1d7",
      borderColor = "#272727",
      border = FullB,
      borderWidth = 1,
      {-
      , position         = Static { xpos = 13, ypos = 1034, width = 1893, height = 32 } Bottom Padded
      , position         = Static { xpos = 0, ypos = 1048, width = 1920, height = 32 } Bottom Flat
      , position         = Static { xpos = 0, ypos = 0, width = 1920, height = 32 } Top Flat
      -}
      -- position = Static {xpos = 1920, ypos = 148, width = 1920, height = 25},
      position = TopH 25,
      alpha = 255,
      overrideRedirect = True,
      lowerOnStart = True,
      hideOnStart = False,
      allDesktops = False,
      persistent = False,
      iconRoot = myHomeDir ++ "/.config/xmonad/icons",
      iconOffset = -1,
      sepChar = "@",
      alignSep = "}{"
    }
