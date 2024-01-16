{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE MultiWayIf #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-missing-signatures 
    -Wno-orphans #-}

-- Data Imports

import Data.Functor
import qualified Data.Map as M
import Data.Monoid
-- Used in io exitSuccess

import System.Environment (getEnv)
import System.Exit
import System.IO.Unsafe (unsafeDupablePerformIO)
-- XMonad imports
import XMonad
import XMonad.Actions.NoBorders (toggleBorder)
import XMonad.Actions.ToggleFullFloat
import XMonad.Hooks.DebugEvents
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDebug
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.OnPropertyChange (onXPropertyChange)
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook (doAskUrgent)
import XMonad.Hooks.WindowSwallowing
import XMonad.Layout.FocusTracking
import XMonad.Layout.Mosaic
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.Tabbed
import XMonad.Layout.TwoPane
import XMonad.Operations
import qualified XMonad.StackSet as W
import XMonad.Util.Cursor
import XMonad.Util.EZConfig
import qualified XMonad.Util.Hacks as Hacks
import XMonad.Util.NamedScratchpad
import XMonad.Util.SpawnOnce
import XMonad.Util.Ungrab

main :: IO ()
main =
  do
    xmonad
    $ debugManageHookOn "M-S-d"
      . docks
      . setEwmhActivateHook doAskUrgent
      . ewmhFullscreen -- breaks league of legends
      . toggleFullFloatEwmhFullscreen
      -- . fullscreenSupport -- breaks game launchers #450
      . ewmh -- modal dialogs #452
      . Hacks.javaHack
    $ myConfig

myModMask :: KeyMask
myModMask = mod4Mask

-- Default terminal
myTerminal :: String
myTerminal = "kitty"

-- Default Launcher
myLauncher :: String
myLauncher = myHomeDir ++ "/.config/rofi/launchers/type-6/launcher.sh"

-- Default Launcher
myFileManager :: String
-- myFileManager = "kitty -e ranger"
myFileManager = "thunar"

-- Default Browser
myBrowser :: String
myBrowser = "firefox-bin"

myPowerMenu :: String
myPowerMenu = myHomeDir ++ "/.config/rofi/powermenu/type-6/powermenu.sh"

-- Workspaces
myWorkspaces :: [String]
myWorkspaces = ["one", "two", "three", "four", "five", "six", "seven", "eight"]

-- myWorkspaces = map show [1 .. 9]

-- Border Width
myBorderWidth :: Dimension
myBorderWidth = 2

-- Formal Unfocused Color
myNormColor :: String
myNormColor = "#383830"

-- Focused Color
myFocusColor :: String
myFocusColor = "#cb4b16"

-- Home Directory
myHomeDir :: String
myHomeDir = unsafeDupablePerformIO (getEnv "HOME")

--  focus follows the mouse pointer
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myKeys conf@(XConfig {XMonad.modMask = modm}) =
  M.fromList $
    [ ((m .|. modm, k), windows $ f i)
      | (i, k) <- zip (XMonad.workspaces conf) [xK_1, xK_2, xK_3, xK_4, xK_5, xK_6, xK_7, xK_8, xK_9, xK_0],
        (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ]
      ++ [ ((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
           | (key, sc) <- zip [xK_comma, xK_period, xK_semicolon] [0 ..],
             (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
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
    toggleFull w = windows $ \s ->
      if
          | M.lookup w (W.floating s) == Just fullscreen -> W.sink w s
          | otherwise -> W.float w fullscreen s
      where
        fullscreen = W.RationalRect 0 0 1 1
    -- Screenshots
    screenShotSelection = myHomeDir ++ "/.local/bin/print-select" :: String
    screenShotFullscreen = myHomeDir ++ "/.local/bin/print-fullscreen" :: String
    screenShotTmp = myHomeDir ++ "/.local/bin/print-tmp" :: String
    screenShotApp = myHomeDir ++ "/.local/bin/print-window.sh" :: String
    myMainBrowser = myBrowser ++ " -p main" :: String
    myDevBrowser = myBrowser ++ " -p dev" :: String
    mySchoolBrowser = myBrowser ++ " -p school" :: String
    -- XMonad base keybinds.
    base =
      [ ("M-g", withFocused toggleBorder),
        ("M-S-c", kill),
        ("M-S-x", withFocused forceKillWindow),
        ("M-<Space>", sendMessage NextLayout),
        ("M-n", refresh),
        ("M-S-q", io exitSuccess),
        ("C-S-r", spawn "xmonad --recompile && killall xmobar2 ; killall xmobar ; xmonad --restart"),
        ("C-S-q", spawn "pkill -KILL -u $USER")
      ]
    -- Window management keybinds.
    window =
      [ ("M-<Tab>", windows W.focusDown),
        ("M-j", windows W.focusDown),
        ("M-k", windows W.focusUp),
        ("M-S-m", windows W.focusMaster),
        ("M-m", sendMessage ToggleStruts),
        ("M-p", windows W.swapMaster),
        ("M-S-j", windows W.swapDown),
        ("M-S-h", windows W.swapDown),
        ("M-S-k", windows W.swapUp),
        ("M-S-l", windows W.swapUp),
        ("M-h", sendMessage Shrink),
        ("M-l", sendMessage Expand),
        ("M-a", sendMessage Taller),
        ("M-z", sendMessage Wider),
        ("M-r", sendMessage Reset),
        ("M-t", withFocused $ windows . W.sink),
        ("M-f", withFocused toggleFull),
        ("M-C-S-6", withFocused $ \w -> spawn $ "xprop -id " ++ show w ++ " | ${XMONAD_XMESSAGE:-xmessage} -file -"),
        ("M-S-f", withFocused toggleFullFloat)
      ]
    -- Spawning applications.
    applications =
      [ ("M-<Return>", spawn myTerminal),
        ("M-C-<Return>", namedScratchpadAction myScratchpads "terminal"),
        ("M-S-<Escape>", spawn myPowerMenu),
        ("M-b", spawn myMainBrowser),
        ("M-S-b", spawn myDevBrowser),
        ("M-C-b", spawn mySchoolBrowser),
        ("M-S-s", spawn "steam --noverifyfiles"),
        ("S-<Print>", unGrab *> spawn screenShotSelection),
        ("C-S-<Print>", unGrab *> spawn screenShotTmp),
        ("C-<Print>", unGrab *> spawn screenShotApp),
        ("<Print>", spawn screenShotFullscreen),
        ("M-S-<Return>", spawn myLauncher),
        ("M-e", spawn myFileManager),
        ("C-S-m", spawn "~/scripts/macro.sh"),
        ("M-C-o", spawn "VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/amd_pro_icd64.json obs"),
        ("M-C-d", spawn "discord"),
        ("M-M1-x", spawn "XL_SECRET_PROVIDER=FILE xivlauncher"),
        ("M-C-x", spawn "GTK_THEME=Orchis-Dark xournalpp")
      ]
    -- Multimedia keybinds.
    multimedia =
      [ ("<XF86AudioPlay>", spawn "~/volume_brightness.sh play_pause"),
        ("<XF86AudioPrev>", spawn "~/volume_brightness.sh prev_track"),
        ("<XF86AudioNext>", spawn "~/volume_brightness.sh next_track"),
        ("<XF86AudioMute>", spawn "~/volume_brightness.sh volume_mute"),
        ("<XF86AudioLowerVolume>", spawn "~/volume_brightness.sh volume_down"),
        ("<XF86AudioRaiseVolume>", spawn "~/volume_brightness.sh volume_up"),
        ("<XF86AudioPause>", spawn "~/volume_brightness.sh play_pause"),
        ("<XF86AudioPlayPause>", spawn "~/volume_brightness.sh play_pause"),
        ("<XF86MonBrightnessUp>", spawn "~/volume_brightness.sh brightness_up"),
        ("<XF86MonBrightnessDown>", spawn "~/volume_brightness.sh brightness_down"),
        ("<Pause>", spawn "amixer sset Capture toggle"),
        ("M-<Escape>", spawn "mpc toggle"),
        ("M-<F1>", spawn "mpc prev"),
        ("M-<F2>", spawn "mpc next")
      ]

myMouseBindings :: XConfig l -> M.Map (KeyMask, Button) (Window -> X ())
myMouseBindings XConfig {XMonad.modMask = modm} =
  M.fromList
    -- Set the window to floating mode and move by dragging.
    [ ((modm, button1), \w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster),
      -- Raise the window to the top of the stack.
      ((modm, button2), \w -> focus w >> windows W.shiftMaster),
      -- Set the window to floating mode and resize by dragging.
      ((modm, button3), \w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster)
    ]

myStartupHook :: X ()
myStartupHook = do
  _ <-
    traverse
      spawnOnce
      ["sh ~/init.sh"]
  setDefaultCursor xC_left_ptr
  setWMName "xmonad"

isInstance (ClassApp c _) = className =? c
isInstance (TitleApp t _) = title =? t
isInstance (NameApp n _) = appName =? n

type AppName = String

type AppTitle = String

type AppClassName = String

type AppCommand = String

data App
  = ClassApp AppClassName AppCommand
  | TitleApp AppTitle AppCommand
  | NameApp AppName AppCommand
  deriving (Show)

gimp = ClassApp "Gimp" "gimp"

gimp2 = ClassApp "Gimp-2.99" "gimp-2.99"

multimc = ClassApp "MultiMC" "MultiMC"

about = TitleApp "About Mozilla Firefox" "About Mozilla Firefox"

message = ClassApp "Xmessage" "Xmessage"

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
    manageRules =
      composeOne
        [ transience,
          isDialog -?> doCenterFloat,
          isFullscreen -?> (doF W.focusDown <> doFullFloat),
          match
            [ gimp,
              gimp2,
              about,
              message
            ]
            -?> doFloat,
          match
            [ multimc
            ]
            -?> doCenterFloat,
          anyOf
            [ isFileChooserDialog,
              isDialog,
              isPopup,
              isSplash
            ]
            -?> doCenterFloat
        ]
        <> composeAll
          [ manageDocks <> namedScratchpadManageHook myScratchpads,
            "_NET_WM_WINDOW_TYPE" `isInProperty` "_KDE_NET_WM_WINDOW_TYPE_OVERRIDE" --> doIgnore <> doRaise,
            className =? "An Anime Game Launcher" --> doShift "five" <> doCenterFloat <> hasBorder False,
            className =? "Arandr" --> doFloat,
            className =? "Anki" --> doShift "five",
            className =? "Anki" <&&> title =? "Add" --> doFloat,
            className =? "Conky" --> doIgnore,
            className =? "Lutris" --> doShift "five",
            className =? "Mousepad" --> doFloat,
            className =? "Nitrogen" --> doFloat,
            className =? "Pavucontrol" --> doFloat,
            className =? "Pcmanfm" --> doFloat,
            className =? "Pidgin" --> doShift "seven",
            className =? "PrismLauncher" --> doShift "five",
            className =? "Steam" --> doShift "eight",
            className =? "TeamSpeak 3" --> doShift "three",
            className =? "Thunar" --> doFloat,
            className =? "Transformice" --> doShift "four",
            className =? "Virt-manager" --> doShift "six",
            className =? "Wrapper-2.0" --> doFloat,
            className =? "Xfce4-panel" --> doCenterFloat <> hasBorder False,
            className =? "XIVLauncher.Core" --> doShift "five" <> doCenterFloat,
            className =? "Xournalpp" --> doShift "four",
            className =? "amberol" --> doFloat,
            className =? "battle.net.exe" --> doShift "four" <> doCenterFloat,
            className =? "diablo iv.exe" --> doShift "four" <> doCenterFloat <> hasBorder False,
            className =? "discord" --> doShift "three",
            className =? "discord-screenaudio" --> doShift "three",
            className =? "easyeffects" --> doFloat <> doShift "six",
            className =? "explorer.exe" --> doShift "four",
            className =? "ffxiv_dx11.exe" --> doShift "four" <> hasBorder False <> doFullFloat,
            className =? "firefox" <&&> resource =? "Toolkit" --> doFloat,
            className =? "firefox" <&&> title =? "File Upload" --> doFloat,
            className =? "firefox" <&&> title =? "Firefox — Sharing Indicator" --> doForceKill,
            className =? "firefox" <&&> title =? "Library" --> doCenterFloat,
            className =? "firefox" <&&> title ^? "Save" --> doFloat,
            className =? "firefox" <&&> title ^? "Sign in" --> doFloat,
            className =? "gamescope" --> doShift "four" <> doFullFloat <> hasBorder False,
            className =? "heroic" --> doShift "five",
            className =? "obs" --> doShift "five",
            className =? "obsidian" --> doShift "three",
            className =? "parsecd" --> doShift "five",
            className =? "starrail.exe" --> doShift "four",
            className =? "steam" --> doShift "eight",
            className =? "steam_app_1551360" <&&> title /=? "Forza Horizon 5" --> doHide, -- Prevents black screen when fullscreening.
            className =? "steamwebhelper" --> doShift "eight",
            className ~? "Minecraft" --> doShift "four" <> doCenterFloat <> hasBorder False,
            className ~? "csgo" --> doShift "four" <> doCenterFloat <> hasBorder False,
            className ~? "launcher.exe" --> doShift "four" <> doCenterFloat <> hasBorder False,
            className ~? "Warframe" --> doShift "four" <> doFullFloat <> hasBorder False,
            className ~? "dauntless" --> doShift "four",
            className ~? "deceive" --> doShift "four" <> doCenterFloat <> hasBorder False,
            className ~? "league" --> doShift "four" <> doCenterFloat <> hasBorder False,
            className ~? "libreoffice" --> doShift "six",
            className ~? "riot" --> doShift "four" <> doCenterFloat <> hasBorder False,
            className ~? "steam_" --> doShift "four" <> hasBorder False <> doFullFloat,
            className ^? "Visual " <&&> isDialog --> doCenterFloat,
            className ^? "jetbrains-" <&&> title =? "splash" --> doFloat,
            className ^? "jetbrains-" <&&> title ^? "Welcome to " --> doCenterFloat,
            isRole ^? "About" <||> isRole ^? "about" --> doFloat,
            resource =? "desktop_window" --> doIgnore,
            resource =? "kdesktop" --> doIgnore,
            title =? "Wine System Tray" --> doHide -- Prevents Wine System Trays from taking input focus.
          ]

myDynamicManageHook :: ManageHook
myDynamicManageHook =
  composeAll
    [ className ~? "steam_" --> doShift "four",
      title =? "Warframe" --> doShift "four"
    ]

doClose = ask >>= liftX . killWindow >> mempty :: ManageHook

forceKillWindow :: Window -> X ()
forceKillWindow w = withDisplay $ \d ->
  io $ void $ killClient d w

doForceKill = ask >>= liftX . forceKillWindow >> mempty :: ManageHook

myEventHook :: Event -> X All
myEventHook _ = return (All True)

myLayoutHook =
  avoidStruts $
    lessBorders OnlyScreenFloat $
      spacingRaw False (Border w w w w) True (Border w w w w) True $
        focusTracking (tiled ||| Full ||| mosaic 2 [3, 2])
  where
    tiled = Tall nmaster delta ratio
    nmaster = 1 -- Default number of windows in the master pane.
    ratio = 1 / 2 -- Default proportion of screen occupied by master panes.
    delta = 3 / 100 -- Percent of screen increment by when resizing panes.
    w = 8 -- Width of pixel size between windows while tiled.

myConfig =
  def
    { modMask = myModMask,
      focusFollowsMouse = myFocusFollowsMouse,
      terminal = myTerminal,
      mouseBindings = myMouseBindings,
      borderWidth = myBorderWidth,
      normalBorderColor = myNormColor,
      focusedBorderColor = myFocusColor,
      layoutHook = myLayoutHook,
      startupHook = myStartupHook,
      manageHook = myManageHook,
      handleEventHook =
        swallowEventHook (className =? "kitty") (return True)
          -- <> Hacks.windowedFullscreenFixEventHook -- #450
          -- <> debugEventsHook
          -- <> onXPropertyChange "WM_NAME" myDynamicManageHook
          <> myEventHook,
      workspaces = myWorkspaces,
      keys = myKeys
    }
    `additionalKeysP` myAdditionalKeys

myScratchpads =
  [NS "terminal" spawnTerminal findTerminal manageTerminal]
  where
    spawnTerminal = "feh --class scratchpad ~/pics/363032073_179911381762816_6317942459227566936_n.jpg"
    findTerminal = className =? "scratchpad"
    manageTerminal = customFloating $ W.RationalRect l t w h
      where
        h = 0.9
        w = 0.9
        t = 0.95 - h
        l = 0.95 - w
