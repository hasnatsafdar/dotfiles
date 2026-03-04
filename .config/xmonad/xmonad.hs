import Data.Map qualified as M
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.InsertPosition
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
import XMonad.Layout.Spiral
import XMonad.Layout.Renamed
import XMonad.Util.Run
import XMonad.Layout.ToggleLayouts
import XMonad.StackSet qualified as W
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Loggers
import XMonad.Util.SpawnOnce

-- TokyoNight Colors
colorBg = "#1a1b26" -- background
colorFg = "#a9b1d6" -- foreground
colorBlk = "#32344a" -- black
colorRed = "#f7768e" -- red
colorGrn = "#9ece6a" -- green
colorYlw = "#e0af68" -- yellow
colorBlu = "#7aa2f7" -- blue
colorMag = "#ad8ee6" -- magenta
colorCyn = "#0db9d7" -- cyan
colorBrBlk = "#444b6a" -- bright black

myBorderWidth = 4

myNormalBorderColor = colorBrBlk

myFocusedBorderColor = colorCyn

mySpacing = spacingWithEdge 3

-- Workspaces
myWorkspaces = ["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"]
-- myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
-- myWorkspaces = ["۱", "۲", "۳", "۴", "۵", "۶", "۷", "۸", "۹"]
-- myWorkspaces = ["", "󰊯", "", "", "󰙯", "󱇤", "", "󱘶", "󰧮"]
-- myWorkspaces = [ "\xf489"  , "\xf268"  , "\xe749" , "\xf198" , "\xf120" , "\xf1bc" , "\xf03d" , "\xf1fc" , "\xf11b" ]
-- myWorkspaces = ["\xf489", "\xf02af", "\xe749", "\xf198", "\xf067f", "\xfb64", "\xf167", "\xf1f6", "\xf86e"]

myModMask = mod4Mask

myTerminal = "alacritty"

-- TODO Layout I'm using stays active

myLayoutHook =
  toggleLayouts (noBorders Full) $
  avoidStruts $
        renamed [Replace "Tall"] (mySpacing tall)
        ||| renamed [Replace "Wide"] (mySpacing (Mirror tall))
        ||| renamed [Replace "Full"] (mySpacing Full)
        ||| renamed [Replace "Spiral"] (mySpacing (spiral (6 / 7)))
  where
    tall = ResizableTall 1 (3 / 100) (11 / 20) []

-- -- Window rules
-- myManageHook =
--   composeAll
--     [ className =? "Gimp" --> doFloat
--     , className =? "Brave-browser" --> doShift "2"
--     , className =? "firefox" --> doShift "3"
--     , className =? "Slack" --> doShift "4"
--     , className =? "kdenlive" --> doShift "8"
--     ]
--     <+> insertPosition Below Newer

------------------------------------------------------------------------
myStartupHook = do
        spawnOnce "nitrogen --restore &"
        spawnOnce "picom &"
        spawnOnce "dunst &"
        spawnOnce "/usr/bin/emacs --daemon"
------------------------------------------------------------------------

-- TODO Setup Clipboard manager
-- TODO Set volume limit to not exceed 100%
-- TODO Setup lock screen and caffiene system
-- TODO Blueberry and nmtui stuff
-- TODO Setup + Exec on boot the todo app (task warrior), the calender (calcurse) and the email (neomutt).
-- TODO redshift or something for nightlight
-- TODO Setup pywal16

-- Key bindings
myKeys =
  -- Launch applications
  [ ("M-<Return>", spawn myTerminal)
  , ("M-n", spawn (myTerminal ++ " -e nvim"))
  , ("M-d", spawn "rofi -show drun")
  , ("M-S-x", spawn "rofi -show powermenu -modi 'powermenu:./.local/bin/rofi-power-menu'")
  , ("M-S-d", spawn "dmenu_run")
  , ("M-S-o", spawn "def-lookup")
  , ("M-w", spawn "app.zen_browser.zen")
  , ("M-S-w", spawn "brave")
  , ("M-o", spawn "obsidian")
  , ("M-e", spawn "emacsclient -c -a 'emacs'")
  , ("M-f f", spawn "thunar")
  , ("M-f n", spawn "nautilus")
  , ("C-<Print>", spawn "maim -s | xclip -selection clipboard -t image/png")
  , ("<Print>", spawn "flameshot gui")

  , -- dmenu/rofi scripts
    ("M-p b", spawn "./.local/bin/buku-dmenu")
  , -- Window management
    ("M-q", kill)
  , ("M-j", windows W.focusDown)
  , ("M-k", windows W.focusUp)
  , ("M-<Tab>", windows W.focusDown)
  , -- Master area
    ("M-l", sendMessage Expand)
  , ("M-h", sendMessage Shrink)
  , -- Layout switching
       ("M-S-f", sendMessage ToggleLayout)
  ,    ("M-S-<Space>", withFocused toggleFloat)
  , ("M-a", toggleWindowSpacingEnabled >> toggleScreenSpacingEnabled)
  , ("M-S-a", setWindowSpacing (Border 3 3 3 3) >> setScreenSpacing (Border 3 3 3 3))
  , -- Quit/Restart
    ("M-S-r", spawn "xmonad --recompile; xmonad --restart")
  , -- Keychords for tag navigation (Mod+Space then number)
    -- Volume controls
    ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
  , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
  , ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    -- Brightness controls
  , ("<XF86MonBrightnessUp>", spawn "brightnessctl set +5%")
  , ("<XF86MonBrightnessDown>", spawn "brightnessctl set 5%-")
  ]
    ++
    -- Standard TAGKEYS behavior (Mod+# to view, Mod+Shift+# to move)
    [ (mask ++ "M-" ++ [key], windows $ action tag)
    | (tag, key) <- zip myWorkspaces "123456789"
    , (action, mask) <- [(W.greedyView, ""), (W.shift, "S-")]
    ]

-- Helper function for toggling float
toggleFloat w =
  windows
    ( \s ->
        if M.member w (W.floating s)
          then W.sink w s
          else W.float w (W.RationalRect 0.15 0.15 0.7 0.7) s
    )

-- XMobar PP (Pretty Printer) configuration
myXmobarPP :: PP
myXmobarPP =
  def
    { ppSep = xmobarColor colorBrBlk "" " │ "
    , ppTitleSanitize = xmobarStrip
    , ppCurrent = xmobarColor colorCyn ""
    , ppHidden = xmobarColor colorFg ""
    , ppHiddenNoWindows = xmobarColor colorBrBlk ""
    , ppUrgent = xmobarColor colorRed colorYlw
    , ppOrder = \[ws, l, _, wins] -> [ws, l, wins]
    , ppExtras = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused = wrap (xmobarColor colorCyn "" "[") (xmobarColor colorCyn "" "]") . xmobarColor colorFg "" . ppWindow
    formatUnfocused = wrap (xmobarColor colorBrBlk "" "[") (xmobarColor colorBrBlk "" "]") . xmobarColor colorBrBlk "" . ppWindow
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

-- Main configuration
myConfig =
  def
    { modMask = myModMask
    , terminal = myTerminal
    , workspaces = myWorkspaces
    , borderWidth = myBorderWidth
    , normalBorderColor = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    , layoutHook = myLayoutHook
    -- , manageHook = myManageHook <+> manageDocks
    , startupHook = myStartupHook
    }
    `additionalKeysP` myKeys

-- XMobar status bar configuration
myStatusBar = statusBarProp "xmobar ~/.config/xmobar/xmobar.hs" (pure myXmobarPP)

main :: IO ()
main = xmonad . ewmhFullscreen . ewmh . withEasySB myStatusBar defToggleStrutsKey $ myConfig
