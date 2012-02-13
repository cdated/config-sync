import XMonad
import XMonad.Actions.FloatKeys
import XMonad.Actions.Submap
import XMonad.Actions.OnScreen
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Layout.SimpleFloat
import XMonad.Layout.Decoration
import XMonad.Layout.Maximize
import XMonad.Layout.Named
import XMonad.Layout.ShowWName
import XMonad.Layout.NoBorders
import System.IO

import qualified XMonad.StackSet as W

-- Tabbed decorations theme
myTabTheme = defaultTheme { activeColor = "DarkSlateGray"
                          , activeBorderColor = "orange"
                          , activeTextColor = "orange"
                          , inactiveColor = "DarkSlateGray"
                          , inactiveBorderColor = "DarkSlateGray"
                          , inactiveTextColor = "wheat"
                          , urgentColor = "DarkRed"
                          , urgentBorderColor = "DarkRed"
                          , urgentTextColor = "white"
                          , fontName = "-xos4-terminus-medium-r-normal--12-120-72-72-c-60-iso10646-1"
                          , decoWidth = 200
                          , decoHeight = 16 }

myLayout = avoidStruts (tiled ||| Full ||| myFloat)
    where
      tiled = named "Tiled" (maximize (Tall nmaster delta ratio))
      nmaster = 1
      ratio = 114/175
      delta = 1/175
      myFloat = named "Floating" (maximize (simpleFloat' shrinkText myTabTheme))

myManageHook = composeAll
    [ className =? "Gimp"       --> doFloat
    , className =? "ij-ImageJ"  --> doFloat
    , className =? "Vlc"        --> doFloat
    , className =? "Opera"      --> doShift "1"
    ] <+> manageDocks

main = do
xmproc <- spawnPipe "/usr/bin/xmobar ~/.env/.xmobarrc"
xmonad $ defaultConfig
    { manageHook         = myManageHook,
      layoutHook         = smartBorders $ myLayout,
      terminal           = "gnome-terminal",
      focusedBorderColor = "red"
    }
