import XMonad

import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

import Colors 

main :: IO ()
main = xmonad . ewmhFullscreen . ewmh . xmobarProp $ myConfig

myConfig = def
    { modMask            = mod4Mask  -- Binding Mod to Win
    , terminal 	         = "alacritty"
    , workspaces         = myWorkspaces
    , layoutHook         = myLayout
    , borderWidth        = 2 
    , focusedBorderColor = color4
    }
    `additionalKeysP`
    [ ("M-d", spawn "rofi -config $HOME/.config/rofi/my-colors-rofi.rasi -show drun")   -- Rofi
    , ("<Print>", spawn "scrot ~/Pictures/%Y-%m-%d-%T-screenshot.png")
    , ("<XF86AudioRaiseVolume>", spawn "pamixer -ui 5")
    , ("<XF86AudioLowerVolume>", spawn "pamixer -ud 5")
    , ("<XF86AudioMute>", spawn "pamixer --toggle-mute")
    ]

myWorkspaces :: [String]
myWorkspaces = ["I","II","III","IV","V", "VI", "VII", "VIII", "IX", "X"]

myLayout = spacing 5 $ gaps [(U,20),(R,20),(D,60),(L,20)] $ tiled ||| Mirror tiled ||| Full
  where
    tiled   = Tall nmaster delta ratio
    nmaster = 1       -- Number of windows in master pane
    ratio   = 1/2     -- Proportion of screen occupied by master pane
    delta   = 3/100   -- Resizing delta

