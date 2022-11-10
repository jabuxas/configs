-- ## Modules ## -------------------------------------------------------------------
{-# LANGUAGE MultiWayIf #-}
import           XMonad
import           XMonad.Util.SpawnOnce
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers
import XMonad.ManageHook
import XMonad.Util.Ungrab
import XMonad.Util.Hacks as Hacks
import XMonad.Hooks.WindowSwallowing
import           XMonad.Layout.Fullscreen
import           XMonad.Layout.NoBorders
import           XMonad.Layout.Spacing
import           XMonad.Layout.Gaps
import           XMonad.Hooks.StatusBar
import           XMonad.Hooks.StatusBar.PP
import           System.Exit
import           Control.Monad
import           Data.Monoid
import           Data.Maybe
import XMonad.Util.Cursor
import Graphics.X11.ExtraTypes.XF86
import XMonad.Util.ClickableWorkspaces

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- focus follows the mouse pointer
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- clicking on a window to focus
myClickJustFocuses :: Bool
myClickJustFocuses = True

-- Width of the window border in pixels
myBorderWidth = 2

-- Border colors for focused & unfocused windows
myFocusedBorderColor = "#de935f"
myNormalBorderColor = "#5f819d"

-- modMask : modkey you want to use
-- mod1Mask : left alt Key
-- mod4Mask : Windows or Super Key
myModMask = mod4Mask
myTerminal = "kitty"
-- Workspaces (ewmh)
myWorkspaces = ["dev", "web", "irc", "gfx", "vm", "music", "email", "x"]

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    -- Close focused window
    [ ((modm .|. shiftMask, xK_c),      kill)
    , ((modm, xK_Escape), spawn "mpc toggle")
    , ((modm .|. shiftMask, xK_m), spawn "kitty -e ncmpcpp")
    , ((modm, xK_e), spawn "pcmanfm")
    , ((modm, xK_v), spawn "vscodium")
    , ((modm, xK_Return), spawn myTerminal)
    , ((modm .|. shiftMask, xK_Escape), spawn "/home/klein/.config/rofi/powermenu/type-6/powermenu.sh")
    , ((modm .|. shiftMask, xK_Return), spawn "/home/klein/.config/rofi/launchers/type-7/launcher.sh")
    , ((0 .|. shiftMask, xK_Print), unGrab >> spawn "/home/klein/.local/bin/print-select")
    , ((0, xK_Print), spawn "/home/klein/.local/bin/print-fullscreen")
  -- Change gaps on the fly
    , ((modm .|. controlMask, xK_o), sendMessage $ IncGap 10 L)     -- increment the left-hand gap
    , ((modm .|. shiftMask, xK_o),   sendMessage $ DecGap 10 L)     -- decrement the left-hand gap
    , ((modm .|. controlMask, xK_y), sendMessage $ IncGap 10 U)     -- increment the top gap
    , ((modm .|. shiftMask, xK_y),   sendMessage $ DecGap 10 U)     -- decrement the top gap
    , ((modm .|. controlMask, xK_u), sendMessage $ IncGap 10 D)     -- increment the bottom gap
    , ((modm .|. shiftMask, xK_u),   sendMessage $ DecGap 10 D)     -- decrement the bottom gap
    , ((modm .|. controlMask, xK_i), sendMessage $ IncGap 10 R)     -- increment the right-hand gap
    , ((modm .|. shiftMask, xK_i),   sendMessage $ DecGap 10 R)     -- decrement the right-hand gap
  -- Resize viewed windows to the correct size
    , ((modm, xK_r),     refresh)
  -- Move focus to the master window
    , ((modm, xK_m),     windows W.focusMaster)
  -- Push window back into tiling
    , ((modm, xK_t),     withFocused $ windows . W.sink)
  -- Rotate through the available layout algorithms
    , ((modm, xK_space), sendMessage NextLayout)
  --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf)
  -- Move focus to the next window
    , ((modm, xK_Tab),   windows W.focusDown)
  -- Move focus to the next window
    , ((modm, xK_j),     windows W.focusDown)
    , ((modm, xK_Left),  windows W.focusDown)
  -- Move focus to the previous window
    , ((modm, xK_k),     windows W.focusUp)
    , ((modm, xK_Right), windows W.focusUp)
  -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j),     windows W.swapDown)
    , ((modm .|. shiftMask, xK_h),  windows W.swapDown)
  -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k),     windows W.swapUp)
    , ((modm .|. shiftMask, xK_l), windows W.swapUp)
  -- Shrink the master area
    , ((modm, xK_h),                    sendMessage Shrink)
    , ((modm .|. controlMask, xK_Left), sendMessage Shrink)
  -- Expand the master area
    , ((modm, xK_l),                     sendMessage Expand)
    , ((modm .|. controlMask, xK_Right), sendMessage Expand)
  -- Increment the number of windows in the master area
    , ((modm, xK_comma),  sendMessage (IncMasterN 1))
  -- Deincrement the number of windows in the master area
    , ((modm, xK_period), sendMessage (IncMasterN (-1)))
  -- volume
    , ((0,xF86XK_AudioMute), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    , ((0,xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
    , ((0,xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
  -- Restart xmonad
    , ((controlMask .|. shiftMask, xK_r), spawn "xmonad --recompile; xmonad --restart")
  -- Quit xmonad
    , ((controlMask .|. shiftMask, xK_q), spawn "pkill -KILL -u $USER")
  -- programs
    , ((modm, xK_d),   spawn "cd ~/.config && ./webcordx")
    , ((modm, xK_s),   spawn "spotify")
    , ((modm              , xK_y     ), sendMessage ToggleStruts)
    , ((modm .|. shiftMask, xK_b),   spawn "firefox")
    -- , ((modm, xK_F1),  spawn "dmenu_run")
  -- spotify controls, handy af
    , ((modm, xK_F9),  spawn "playerctl play-pause")
    , ((modm, xK_F11), spawn "playerctl previous")
    , ((modm, xK_F12), spawn "playerctl next")
    , ((modm, xK_p), spawn "flameshot")
    , ((modm, xK_F4), withFocused toggleFull)
    ]
    ++
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    [ ((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1,xK_2,xK_3,xK_4,xK_5,xK_6,xK_7,xK_8,xK_9,xK_0]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ]
    ++
    -- mod-{q,a,z}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{q,a,z}, Move client to screen 1, 2, or 3
    [ ((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_comma, xK_period, xK_z] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
    ]

-- ## Mouse Bindings ## ------------------------------------------------------------------
myMouseBindings :: XConfig l -> M.Map (KeyMask, Button) (Window -> X ())
myMouseBindings XConfig {XMonad.modMask = modm} = M.fromList
  -- Set the window to floating mode and move by dragging.
    [ ((modm, button1), \w -> focus w >> mouseMoveWindow w      >> windows W.shiftMaster)
  -- Raise the window to the top of the stack.
    , ((modm, button2), \w -> focus w >> windows W.shiftMaster)
  -- Set the window to floating mode and resize by dragging.
    , ((modm, button3), \w -> focus w >> mouseResizeWindow w    >> windows W.shiftMaster)
    ]

myLayout =
  avoidStruts
  $ lessBorders OnlyScreenFloat
  $ gaps [(L,5), (R,5), (U,5), (D,5)] 
  $ spacingRaw False (Border 10 0 10 0) True (Border 0 10 0 10) True
  $ tiled ||| Mirror tiled ||| Full
  where
      tiled = Tall nmaster delta ratio
      nmaster = 1     -- Default number of windows in the master pane.
      ratio = 1 / 2   -- Default proportion of screen occupied by master panes.
      delta = 3 / 100 -- Percent of screen increment by when resizing panes.

myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = manageRules
  where
    viewShift = doF . liftM2 (.) W.greedyView W.shift
    manageRules = composeAll . concat $
      [ [ isDialog       --> doCenterFloat ]
      , [ className =? c --> doCenterFloat | c <- myCFloats ]
      , [ title     =? t --> doCenterFloat | t <- myTFloats ]
      , [ resource  =? r --> doFloat       | r <- myRFloats ]
      , [ resource  =? i --> doIgnore      | i <- myIgnores ]
      , [ className =? "firefox" --> viewShift "web" ]
      , [ className =? "firefox-esr" --> doShift "web" ]
      , [ className =? "discord" --> doShift "irc" ]
      , [ className =? "Spotify" --> doShift "music" ]
      , [ className =? "thunderbird" --> doShift "email" ]
      , [ className =? "Steam" --> doShift "x" ]
      , [ className =? "leagueclientux.exe" --> doShift "gfx" <> doFloat ]
      , [ className =? "Lutris" --> doShift "gfx" <> doFloat]
      , [ className =? "league of legends.exe" --> doShift "gfx" <> doFloat ]
      , [ className =? "riotclientux.exe" --> doShift "gfx" <> doFloat ]
      , [ className =? "dauntless-win64-shipping.exe" --> doShift "gfx" ]
      , [ className =? "leagueclient.exe" --> doShift "gfx" <> doFloat ]
      , [ className =? "battle.net.exe" --> doShift "gfx" <> doFloat ]
      , [ className =? "Pcmanfm" --> doFloat ]
      , [ className =? "Pavucontrol" --> doFloat ]
      , [ className =? "Nitrogen" --> doFloat ]

      ] 
      where    
        myCFloats = ["Viewnior", "Alafloat"]
        myTFloats = ["Downloads", "Save As...", "Getting Started"]
        myRFloats = []
        myIgnores = ["desktop_window"]

-- , [className =? "Alacritty" --> viewShift "1"]
-- , [className =? "Thunar" --> viewShift "3"]
-- , [className =? "Geany" --> viewShift "4"]
-- , [className =? "Inkscape" --> viewShift "5"]
-- , [className =? "vlc" --> viewShift "6"]
-- , [className =? "Xfce4-settings-manager" --> viewShift "7"]

toggleFull :: Window -> X ()
toggleFull w = windows $ \s -> if
 | M.lookup w (W.floating s) == Just fullscreen -> W.sink w s
 | otherwise -> W.float w fullscreen s
  where
   fullscreen = W.RationalRect 0 0 1 1

myEventHook :: Event -> X All
myEventHook = mempty $ swallowEventHook (className =? "Alacritty" <||> className =? "kitty") (return True) -- ewmh

myStartupHook :: X ()
myStartupHook = do
  setDefaultCursor xC_left_ptr
  spawnOnce "nitrogen --restore &"
  spawnOnce "/home/klein/scripts/xmonad.sh &"
  -- spawnOnce "/home/klein/.local/bin/xmobar ~/.config/xmonad/src/xmobar.hs &"
  -- spawnOnce "/home/klein/.local/bin/xmobar-2nd &"
  -- spawnOnce "picom --daemon --experimental-backends --backend glx --blur-method dual_kawase --transparent-clipping"
  -- spawnOnce "killall trayer; trayer --edge top --align right --widthtype request --padding 2 --SetDockType true --SetPartialStrut true --expand true --transparent true --alpha 0 --tint 0x161814 --height 25 --distance 3 &"
  -- spawnOnce "dunst"

myLogHook = return ()

myXmobarPP :: PP
myXmobarPP =
  def
    { ppCurrent         = xmobarColor "#de935f" "" . wrap "[" "]",
      ppHidden          = xmobarColor "#d2ba8b" "",
      ppHiddenNoWindows = xmobarColor "#a3846e" "",
      ppSep             = " > ",
      ppOrder           = \(ws : l : t : ex) -> [ws] ++ map (xmobarColor "#E06C75" "") ex ++ [xmobarColor "#ABB2BF" "" t],
      ppExtras          = []
    }

myConfig = 
  def
    { focusFollowsMouse  = myFocusFollowsMouse
    , clickJustFocuses   = myClickJustFocuses
    , borderWidth        = myBorderWidth
    , modMask            = myModMask
    , workspaces         = myWorkspaces
    , normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    , terminal           = myTerminal
  -- Keybindings
    , keys               = myKeys
    , mouseBindings      = myMouseBindings
  -- Hooks and layouts
	  ,	manageHook         = myManageHook
    , layoutHook         = myLayout
    , handleEventHook    = myEventHook
                           <> Hacks.trayerAboveXmobarEventHook
    , logHook            = myLogHook
    , startupHook        = myStartupHook 
    }

main :: IO ()
main = 
  do
    xmonad 
    . ewmhFullscreen 
    . docks 
    . ewmh 
    . fullscreenSupport
    . withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey
    . withEasySB (statusBarProp "xmobar-2nd" (pure myXmobarPP)) defToggleStrutsKey
    $ myConfig
