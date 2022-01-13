import XMonad

import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Util.SpawnOnce
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageHelpers
import XMonad.Actions.CycleWS
import XMonad.Actions.NoBorders

import Colors 

main :: IO ()
main = xmonad . ewmhFullscreen . ewmh . xmobarProp $ myConfig

myMenu         = "rofi -config $HOME/.config/rofi/my-colors-rofi.rasi -show drun"
myScreenshot   = "scrot ~/Pictures/%Y-%m-%d-%T-screenshot.png"
volumeUp       = "pamixer -ui 5"
volumeDown     = "pamixer -ud 5"
volumeMute     = "pamixer --toggle-mute"
brightnessUp   = "light -A 10"
brightnessDown = "light -U 10"

myConfig = def
    { modMask            = mod4Mask  -- Binding Mod to Win
    , terminal           = "alacritty"
    , workspaces         = myWorkspaces
    , layoutHook         = myLayout
    , borderWidth        = 2 
    , startupHook        = myStartupHook
    , focusedBorderColor = color4
    }
    `additionalKeysP`
    [ ("M-d",                     spawn myMenu)   -- Rofi
    , ("<Print>",                 spawn myScreenshot)
    , ("<XF86AudioRaiseVolume>",  spawn volumeUp)
    , ("<XF86AudioLowerVolume>",  spawn volumeDown) 
    , ("<XF86AudioMute>",         spawn volumeMute)
    , ("<XF86MonBrightnessUp>",   spawn brightnessUp)
    , ("<XF86MonBrightnessDown>", spawn brightnessDown)
    , ("M-.",                     nextWS)
    , ("M-,",                     prevWS)
    , ("M-S-.",                   shiftToNext >> nextWS)
    , ("M-S-,",                   shiftToPrev >> prevWS)
    , ("M-f",                     (sendMessage $ ToggleGaps) <+> (withFocused toggleBorder) <+> (sendMessage $ Toggle FULL) <+> toggleWindowSpacingEnabled )
    ]

myWorkspaces :: [String]
myWorkspaces = ["一","二","三","四","五", "六", "七", "八", "九"]

myLayout = spacing 5 . gaps [(U,20),(R,20),(D,60),(L,20)] $ mkToggle (single FULL) (tiled ||| Mirror tiled)
  where
    tiled   = Tall nmaster delta ratio
    nmaster = 1       -- Number of windows in master pane
    ratio   = 1/2     -- Proportion of screen occupied by master pane
    delta   = 3/100   -- Resizing delta


myStartupHook = do
    spawn "wal -R"
    spawn "killall tint2"
    spawn "sleep 2 && tint2 -c ~/.config/tint2/workspaces.tint2rc"
    spawn "sleep 2 && tint2 -c ~/.config/tint2/clock.tint2rc"
    spawn "killall dunst"
    spawn "sleep 3 && dunst"
    spawn "~/.telegram-palette-gen/telegram-palette-gen --wal"
    
    spawnOnce "picom"
    setWMName "LG3D"
