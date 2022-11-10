{-# LANGUAGE 
    MultiWayIf   -- Required for `toggleFull` in `myAdditionalKeys`
    , LambdaCase -- Required for `(\case)` statement in `myXmobarPP`
    , FlexibleContexts
    , OverloadedStrings
#-} 
{-# OPTIONS_GHC 
    -Wno-missing-signatures 
    -Wno-orphans 
#-}

-- Data Imports 
import qualified Data.Map                   as M
import           Data.Functor
import           Data.Monoid

-- Used in io exitSuccess 
import           System.Exit
import           System.Environment         (getEnv)
import           System.IO.Unsafe           (unsafeDupablePerformIO)

-- XMonad imports 
import           XMonad
import           XMonad.Hooks.WindowSwallowing
-- import           XMonad.Config.Xfce
import           XMonad.Actions.NoBorders   (toggleBorder)
import           XMonad.Util.Ungrab
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers
import           XMonad.Hooks.SetWMName
import           XMonad.Hooks.StatusBar
import           XMonad.Hooks.StatusBar.PP
import           XMonad.Layout.Fullscreen
-- import           XMonad.Actions.PhysicalScreens
import           XMonad.Layout.SimpleFloat
import           XMonad.Layout.NoBorders    
import           XMonad.Layout.Spacing
import qualified XMonad.StackSet            as W
import           XMonad.Util.ClickableWorkspaces
-- import           XMonad.Util.WorkspaceCompare
import           XMonad.Util.Cursor
import           XMonad.Util.EZConfig       
import qualified XMonad.Util.Hacks          as Hacks
import           XMonad.Util.SpawnOnce
import           XMonad.Util.NamedScratchpad
import           XMonad.Hooks.DynamicProperty
import           XMonad.Layout.PerWorkspace
import           XMonad.Hooks.ManageDebug
-- import qualified DBus                       as D
-- import qualified DBus.Client                as D


main :: IO ()
main = do
    -- dbus <- D.connectSession
    -- getWellKnownName dbus
    xmonad
    $ debugManageHookOn "M-S-d"
    . docks
    . ewmhFullscreen
    . fullscreenSupport
    . ewmh
    . Hacks.javaHack
    -- . withEasySB xmobar toggleSB
    -- . withSB xmobar2 
    $ myConfig
      -- where
         -- toggleSB XConfig {modMask = modm} = (modm, xK_m) 

  -- Windows key/Super key
myModMask :: KeyMask
myModMask = mod4Mask 

  -- Default Terminal
myTerminal :: String
myTerminal = "kitty" 

  -- Default Launcher
myLauncher :: String
myLauncher = myHomeDir ++ "/.config/rofi/launchers/type-7/launcher.sh" 

  -- Default Launcher
myFileManager :: String
myFileManager = "thunar" 

  -- Default Browser
myBrowser :: String
myBrowser = "firefox" 

myPowerMenu :: String
myPowerMenu = myHomeDir ++ "/.config/rofi/powermenu/type-6/powermenu.sh"

  -- Workspaces
myWorkspaces :: [String]
-- myWorkspaces = map show [1 .. 9]
myWorkspaces = ["dev", "web", "irc", "gfx", "vm", "music", "email", "x"]

  -- Border Width
myBorderWidth :: Dimension
myBorderWidth = 2 

  -- Formal Unfocused Color
myNormColor :: String
myNormColor = "#5f819d" 

  -- Focused Color
myFocusColor :: String
myFocusColor = "#de935f" 

  -- Home Directory
myHomeDir :: String
myHomeDir = unsafeDupablePerformIO (getEnv "HOME") 

--  focus follows the mouse pointer
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True 

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1,xK_2,xK_3,xK_4,xK_5,xK_6,xK_7,xK_8,xK_9,xK_0]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ]
    ++
    [ ((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_comma, xK_period, xK_z] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
    ]


myAdditionalKeys :: [(String, X ())]
myAdditionalKeys = 
    base
        ++ window
        ++ applications
        ++ multimedia
    where 
    -- Force killing a frozen window.
        forceKillWindow :: Window -> X ()
        forceKillWindow w = withDisplay $ \d ->
            io $ void $ killClient d w
    -- Making a window have a full float over a workspace.
        toggleFull :: Window -> X () 
        toggleFull w = windows $ \s -> if 
            | M.lookup w (W.floating s) == Just fullscreen -> W.sink w s 
            | otherwise -> W.float w fullscreen s 
                where
                    fullscreen = W.RationalRect 0 0 1 1
    -- Screenshots
        screenShotSelection  = myHomeDir ++ "/.local/bin/print-select" :: String 
        screenShotFullscreen = myHomeDir ++ "/.local/bin/print-fullscreen" :: String
        screenShotTmp        = myHomeDir ++ "/.local/bin/print-tmp" :: String
        screenShotApp        = myHomeDir ++ "/.local/bin/print-select-fr" :: String
    -- XMonad base keybinds.
        base = 
            [ ("M-g",       withFocused toggleBorder)
            , ("M-S-c",     kill)
            , ("M-S-x",     withFocused forceKillWindow)
            , ("M-<Space>", sendMessage NextLayout)
            , ("M-n",       refresh)
            , ("M-S-q",     io exitSuccess)
            , ("C-S-r",     spawn "xmonad --recompile; killall xmobar; xmonad --restart")
            , ("C-S-q",     spawn "pkill -KILL -u $USER")
            ]
    -- Window management keybinds.
        window = 
            [ ("M-<Tab>",    windows W.focusDown)
            , ("M-j",        windows W.focusDown)
            , ("M-k",        windows W.focusUp)
            , ("M-S-m",      windows W.focusMaster)
            , ("M-m",        sendMessage ToggleStruts)
            , ("M-p",        windows W.swapMaster)
            , ("M-S-j",      windows W.swapDown)
            , ("M-S-h",      windows W.swapDown)
            , ("M-S-k",      windows W.swapUp)
            , ("M-S-l",      windows W.swapUp)
            , ("M-h",        sendMessage Shrink)
            , ("M-l",        sendMessage Expand)
            , ("M-t",        withFocused $ windows . W.sink)
            , ("M-f",        withFocused toggleFull)
            ]
    -- Spawning applications.
        applications =
            [ ("M-<Return>",   spawn myTerminal)
            , ("M-S-m",        namedScratchpadAction myScratchpads "ncmpcpp")
            , ("M-C-<Return>", namedScratchpadAction myScratchpads "terminal")
            , ("M-S-<Escape>", spawn myPowerMenu)
            , ("M-b",          spawn myBrowser)
            , ("M-v",          spawn "vscodium")
            , ("S-<Print>",    unGrab *> spawn screenShotSelection)
            , ("C-<Print>",    unGrab *> spawn screenShotTmp)
            , ("C-S-<Print>",  unGrab *> spawn screenShotApp)
            , ("<Print>",      spawn screenShotFullscreen)
            , ("M-S-<Return>", spawn myLauncher)
            , ("M-e",          spawn myFileManager)
            ]
    -- Multimedia keybinds.
        multimedia =
            [ ("<XF86AudioPlay>",        spawn "playerctl play-pause")
            , ("<XF86AudioPrev>",        spawn "playerctl previous")
            , ("<XF86AudioNext>",        spawn "playerctl next")
            , ("<XF86AudioMute>",        spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
            , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -1.5%")
            , ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +1.5%")
            , ("<Pause>",                spawn "amixer sset Capture toggle")
            , ("M-<Escape>",             spawn "mpc toggle")
            , ("M-<F1>",                 spawn "mpc prev")
            , ("M-<F2>",                 spawn "mpc next")
            ]

myMouseBindings :: XConfig l -> M.Map (KeyMask, Button) (Window -> X ())
myMouseBindings XConfig {XMonad.modMask = modm} = M.fromList
  -- Set the window to floating mode and move by dragging.
    [ ((modm, button1), \w -> focus w >> mouseMoveWindow w      >> windows W.shiftMaster)
  -- Raise the window to the top of the stack.
    , ((modm, button2), \w -> focus w >> windows W.shiftMaster)
  -- Set the window to floating mode and resize by dragging.
    , ((modm, button3), \w -> focus w >> mouseResizeWindow w    >> windows W.shiftMaster)
    ]

myStartupHook :: X ()
myStartupHook = do
    traverse spawnOnce
        [ "echo launched" 
        -- , "sh ~/scripts/screenlayout.sh"
        , "nitrogen --restore &"
        , "touch ~/tmp/touchy && rm -rf ~/tmp/*"
        , "lxqt-policykit-agent &"
        , myHomeDir ++ "/.local/bin/picom-jonaburg --glx-no-stencil --xrender-sync-fence -b &"
        , "xinput --set-prop 'pointer:''Gaming Mouse' 'libinput Accel Profile Enabled' 0, 1 && xinput --set-prop 'pointer:''Gaming Mouse' 'libinput Accel Speed' 0.1"
        , "setxkbmap br abnt2"
        , "nm-applet"
        , "trayer-srg -l --edge top --align right --SetDockType true --SetPartialStrut true --expand true --widthtype request --tint 0xFF181814 --height 27 --transparent false --distance 2 --margin 1 --alpha 0 --monitor 0 &"
        , "nvidia-settings --load-config-only"
        , "mpd &"
        , "dunst -config $HOME/.config/dunst/base16-nord.dunstrc &"
        , "lxqt-policykit-agent &"
        , "/usr/bin/emacs --daemon &"
        -- , "redshift -l -23.591672:-46.561005 -t 5700:3600 &"
        ]
    setDefaultCursor xC_left_ptr
    setWMName "jabuxas' bane"

isInstance (ClassApp c _) = className =? c
isInstance (TitleApp t _) = title =? t
isInstance (NameApp n _)  = appName =? n

type AppName      = String
type AppTitle     = String
type AppClassName = String
type AppCommand   = String

data App
  = ClassApp AppClassName AppCommand
  | TitleApp AppTitle AppCommand
  | NameApp AppName AppCommand
  deriving Show

gimp    = ClassApp "Gimp"                  "gimp"
gimp2   = ClassApp "Gimp-2.99"             "gimp-2.99"
multimc = ClassApp "MultiMC"               "MultiMC"
about   = TitleApp "About Mozilla Firefox" "About Mozilla Firefox"
message = ClassApp "Xmessage"              "Xmessage"

myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = manageRules
    where
    -- Hides windows without ignoring it, see doHideIgnore in XMonad contrib.
        doHide = ask >>= doF . W.delete :: ManageHook
    -- WM_WINDOW_ROLE will be parsed with the role variable.
        isRole = stringProperty "WM_WINDOW_ROLE"
    -- To match multiple properties with one operator.
        anyOf = foldl (<||>) (pure False) :: [Query Bool] -> Query Bool
    -- To match multiple classNames with one operator.
        match = anyOf . fmap isInstance :: [App] -> Query Bool
    -- Checking for splash dialogs.
        isSplash = isInProperty "_NET_WM_WINDOW_TYPE" "_NET_WM_WINDOW_TYPE_SPLASH"
    -- Checking for pop-ups.
        isPopup = isRole =? "pop-up"
    -- Checking for file chooser dialog.
        isFileChooserDialog = isRole =? "GtkFileChooserDialog" 
    -- Managing rules for applications.
        manageRules = composeOne
            [ transience
            , isDialog     -?> doCenterFloat
            , isFullscreen -?> (doF W.focusDown <> doFullFloat) 
            , match [ gimp
                    , gimp2
                    , about
                    , message
                    ]      -?> doFloat
                    , match [
                    multimc
                    ]      -?> doCenterFloat
                    , anyOf [ isFileChooserDialog
                    , isDialog
                    , isPopup
                    , isSplash
                    ]      -?> doCenterFloat
            ] <> composeAll
            [ manageDocks <> namedScratchpadManageHook myScratchpads
            , className =? "firefox"    <&&> title    =? "File Upload" --> doFloat
            , className =? "firefox"    <&&> title    =? "Library"     --> doCenterFloat
            , className =? "firefox"    <&&> title    ^? "Save"        --> doFloat
            , className =? "firefox"    <&&> resource =? "Toolkit"     --> doFloat
            , className =? "firefox"    <&&> title    ^? "Sign in"     --> doFloat
            , className ^? "jetbrains-" <&&> title    ^? "Welcome to " --> doCenterFloat
            , className ^? "jetbrains-" <&&> title    =? "splash"      --> doFloat
            , className ^? "Visual "    <&&> isDialog                  --> doCenterFloat
            , className =? "firefox-esr" --> doShift "web" 
            , className =? "steam_app_1172620" --> doShift "gfx" 
            , className =? "discord" --> doShift "irc" 
            , className =? "discord-screenaudio" --> doShift "irc" 
            , className =? "Spotify" --> doShift "music" 
            , className =? "thunderbird" --> doShift "email" 
            , className =? "Steam" --> doShift "x" 
            , className =? "Lutris" --> doShift "gfx" <> doFloat
            , className =? "leagueclientux.exe" --> doShift "gfx"
            , className =? "league of legends.exe" --> doShift "gfx"
            , className =? "leagueclient.exe" --> doShift "gfx"
            , className =? "riotclientux.exe" --> doShift "gfx"
            , className =? "dauntless-win64-shipping.exe" --> doShift "gfx" 
            , className =? "battle.net.exe" --> doShift "gfx" <> doFloat 
            , className =? "Pcmanfm" --> doFloat 
            , className =? "Thunar" --> doFloat 
            , className =? "Pavucontrol" --> doFloat 
            , className =? "Nitrogen" --> doFloat 
            , className =? "Wrapper-2.0" --> doFloat 
            , className =? "TeamSpeak 3" --> doFloat 
            , className =? "easyeffects" --> doFloat 
            , className =? "Arandr" --> doFloat 
            , resource  =? "desktop_window"                            --> doIgnore
            , resource  =? "kdesktop"                                  --> doIgnore
            , className =? "Conky" --> doIgnore
            , isRole    ^? "About"      <||> isRole   ^? "about"       --> doFloat
            , "_NET_WM_WINDOW_TYPE" `isInProperty` "_KDE_NET_WM_WINDOW_TYPE_OVERRIDE" --> doIgnore <> doRaise
        -- Steam Game Fixes 
            , className =? "steam_app_1551360" <&&> title /=? "Forza Horizon 5" --> doHide -- Prevents black screen when fullscreening.
            -- , title     =? "Wine System Tray"                                   --> doHide -- Prevents Wine System Trays from taking input focus.
            -- , title     ^? "Steam - News"                                       --> doHide -- I don't like the Steam news menu 
            ]

myDynHook :: ManageHook
myDynHook =
  composeAll
   [ title=? "Riot Client Main" --> doFloat
   ]

{- May be useful one day 
doClose = ask >>= liftX . killWindow >> mempty :: ManageHook
doForceKill = ask >>= liftX . forceKillWindow >> mempty :: ManageHook
-}

myEventHook :: Event -> X All
myEventHook _ = return (All True)

myLayoutHook =
    avoidStruts
    -- $ onWorkspace "gfx" simpleFloat
    $ lessBorders OnlyScreenFloat
    $ spacingRaw False(Border w w w w) True(Border w w w w) True
    $ tiled ||| simpleFloat ||| Mirror tiled ||| Full
    where
        tiled = Tall nmaster delta ratio
        nmaster = 1     -- Default number of windows in the master pane.
        ratio = 1 / 2   -- Default proportion of screen occupied by master panes.
        delta = 3 / 100 -- Percent of screen increment by when resizing panes.
        w = 5           -- Width of pixel size between windows while tiled. 

myXmobarPP :: X PP
myXmobarPP =
    clickablePP $ filterOutWsPP ["NSP"] $ def
        { ppCurrent          = xmobarColor "#98c379" "" . xmobarFont 5 . wrap "[" "]"
        , ppVisibleNoWindows = Just (xmobarColor "#cc6666" "")
        , ppHidden           = xmobarColor "#d2ba8b" ""
        , ppHiddenNoWindows  = xmobarColor "#a3846e" ""
        , ppUrgent           = xmobarColor "#F7768E" "" . wrap "!" "!"
        , ppTitle            = xmobarColor "#98C379" "" . shorten 49 
        , ppSep              = wrapSep " "
        , ppTitleSanitize    = xmobarStrip
        , ppWsSep            = xmobarColor "" "#212121" "  "
        , ppLayout           = xmobarColor "#212121" "" 
                               . (\case
                                   "Spacing Tall"        -> "<icon=tiled.xpm/>"
                                   "Spacing Mirror Tall" -> "<icon=mirrortiled.xpm/>"
                                   "Spacing Full"        -> "<icon=full.xpm/>"
                                   "Spacing Simple Float"-> "<icon=floating.xpm/>"
                                   "Simple Float"        -> "<icon=floating.xpm/>"
                                 )                     
        }
        where
            wrapSep :: String -> String
            wrapSep = 
                wrap 
                    (xmobarColor "#212121" "#212121:7" (xmobarFont 2 "\xe0b4"))
                    (xmobarColor "#212121" "#212121:7" (xmobarFont 2 "\xe0b6"))

xmobar :: StatusBarConfig
xmobar = statusBarProp myXmobar myXmobarPP

myXmobar :: String
myXmobar = ("xmobar " ++ myHomeDir ++ "/.config/xmonad/src/xmobar.hs")

xmobar2 :: StatusBarConfig
xmobar2 = statusBarProp myXmobar2 myXmobarPP

myXmobar2 :: String
myXmobar2 = ("xmobar-2nd ")

myConfig = 
    def
        { modMask            = myModMask
        , focusFollowsMouse  = myFocusFollowsMouse
        , terminal           = myTerminal
        , mouseBindings      = myMouseBindings
        , borderWidth        = myBorderWidth
        , normalBorderColor  = myNormColor
        -- , logHook            = logTitle dbus
        , focusedBorderColor = myFocusColor
        , layoutHook         = myLayoutHook
                               -- <> onWorkspace "gfx" h8league
        , startupHook        = myStartupHook
        , manageHook         = myManageHook
        , handleEventHook    = Hacks.windowedFullscreenFixEventHook 
                               <> swallowEventHook (className =? "Alacritty"  <||> className =? "kitty" <||> className =? "XTerm") (return True) 
                               <> Hacks.trayerPaddingXmobarEventHook 
                               <> dynamicPropertyChange "WM_CLASS" myDynHook 
                               <> myEventHook
        , workspaces         = myWorkspaces
        , keys               = myKeys
        } 
        `additionalKeysP` myAdditionalKeys


myScratchpads = [ NS "terminal" spawnTerm findTerm manageTerm
                , NS "ncmpcpp" spawnncmpcpp findncmpcpp managencmpcpp
                ]
      where
          spawnTerm = myTerminal ++ " --name scratchpad"
          findTerm  = resource =? "scratchpad"
          manageTerm = customFloating $ W.RationalRect l t w h
                  where
                      h = 0.9
                      w = 0.9
                      t = 0.95 -h
                      l = 0.95 -w
          spawnncmpcpp = myTerminal ++ " --name ncmpcpp -e ncmpcpp"
          findncmpcpp  = resource =? "ncmpcpp"
          managencmpcpp = customFloating $ W.RationalRect l t w h
                  where
                    h = 0.9
                    w = 0.9
                    t = 0.95 -h
                    l = 0.95 -w

-- I GIVE UP ON DBUS.

-- logTitle :: D.Client -> X ()
-- logTitle ch = dynamicLogWithPP def
--                                {ppCurrent         = unPango
--                                ,ppVisible         = pangoInactive
--                                ,ppHidden          = const ""
--                                ,ppHiddenNoWindows = const ""
--                                ,ppUrgent          = pangoBold
--                                ,ppTitle           = unPango
--                                ,ppLayout          = unPango
--                                ,ppWsSep           = " "
--                                ,ppSep             = "⋮"
--                                ,ppOrder           = swapIcons
--                                ,ppSort            = getSortByXineramaPhysicalRule horizontalScreenOrderer
--                                ,ppOutput          = dbusOutput ch
--                                }
--   where swapIcons (ws:l:t:nsp:xs) = ws:l:nsp:t:xs
--         -- @@@ so why do the first 4 invocations *only* not match?!
--         swapIcons xs              = xs

-- getWellKnownName :: D.Client -> IO ()
-- getWellKnownName ch = do
--   _ <- D.requestName ch
--                      (D.busName_ "org.xmonad.Log")
--                      [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]
--   return ()

-- dbusOutput :: D.Client -> String -> IO ()
-- dbusOutput ch s = do
--   let sig = (D.signal "/org/xmonad/Log" "org.xmonad.Log" "Update")
--             {D.signalBody = [D.toVariant s]}
--   D.emit ch sig

-- -- quick and dirty escaping of HTMLish Pango markup
-- unPango :: String -> String
-- unPango []       = []
-- unPango ('<':xs) = "&lt;"  ++ unPango xs
-- unPango ('&':xs) = "&amp;" ++ unPango xs
-- unPango ('>':xs) = "&gt;"  ++ unPango xs
-- unPango (x  :xs) = x:unPango xs

-- -- show a string as inactive
-- -- @@@ should use gtk theme somehow...
-- pangoInactive :: String -> String
-- pangoInactive s = "<span foreground=\"#8f8f8f\">" ++ unPango s ++ "</span>"

-- -- show a string with highlight
-- pangoBold :: String -> String
-- pangoBold s = "<span weight=\"bold\" foreground=\"#ff2f2f\">" ++ unPango s ++ "</span>"

