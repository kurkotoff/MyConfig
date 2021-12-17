import XMonad

import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Util.SpawnOnce
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.ToggleLayouts
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageHelpers
import XMonad.Actions.CycleWS

import Colors 

main :: IO ()
main = xmonad . ewmhFullscreen . ewmh . xmobarProp $ myConfig

myConfig = def
    { modMask            = mod4Mask  -- Binding Mod to Win
    , terminal 	         = "alacritty"
    , workspaces         = myWorkspaces
    , layoutHook         = myLayout
    , borderWidth        = 2 
    , startupHook        = myStartupHook
    , focusedBorderColor = color4
    }
    `additionalKeysP`
    [ ("M-d", spawn "rofi -config $HOME/.config/rofi/my-colors-rofi.rasi -show drun")   -- Rofi
    , ("<Print>", spawn "scrot ~/Pictures/%Y-%m-%d-%T-screenshot.png")
    , ("<XF86AudioRaiseVolume>", spawn "pamixer -ui 5")
    , ("<XF86AudioLowerVolume>", spawn "pamixer -ud 5")
    , ("<XF86AudioMute>", spawn "pamixer --toggle-mute")
    , ("M-C-l", nextWS)
    , ("M-C-h", prevWS)
    , ("M-S-C-l", shiftToNext >> nextWS)
    , ("M-S-C-h", shiftToPrev >> prevWS)
    , ("M-f", sendMessage $ ToggleGaps)
    ]

myWorkspaces :: [String]
myWorkspaces = ["一","二","三","四","五", "六", "七", "八", "九"]

myLayout = spacing 5 . gaps [(U,20),(R,20),(D,60),(L,20)] $ tiled ||| Mirror tiled ||| noBorders Full
  where
    tiled   = Tall nmaster delta ratio
    nmaster = 1       -- Number of windows in master pane
    ratio   = 1/2     -- Proportion of screen occupied by master pane
    delta   = 3/100   -- Resizing delta


myStartupHook = do
    spawn "killall tint2"
    spawn "sleep 2 && tint2 -c ~/.config/tint2/workspaces.tint2rc"
    spawn "sleep 2 && tint2 -c ~/.config/tint2/clock.tint2rc"
    spawn "~/.telegram-palette-gen/telegram-palette-gen --wal"
    
    spawnOnce "picom"
    spawnOnce "wal -R"
    setWMName "LG3D"
