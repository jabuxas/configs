module Main (main) where

import XMonad
import qualified XMonad.Util.Hacks as Hacks

main :: IO ()
main =
  xmonad $
    fullscreenSupport
      def
        { handleEventHook = handleEventHook def <> Hacks.windowedFullscreenFixEventHook
        }
