-- vim: sw=4 ts=4 sts=4 et

import Data.List
import Graphics.X11.ExtraTypes.XF86
import System.IO
import System.Environment (getEnv)
import System.Exit

import XMonad
import XMonad.Actions.CycleWS (nextWS, prevWS)
import XMonad.Actions.Navigation2D
import XMonad.Actions.WorkspaceNames
import XMonad.Config.Desktop
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.DynamicLog
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.Gaps
import XMonad.Layout.IndependentScreens
import XMonad.Layout.Spacing
import XMonad.Operations
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run

import qualified Data.Map        as M
import qualified XMonad.StackSet as W

-- My settings
myTerminal = "mlclient"
myMenu     = "dmenu_run -fn 'monospace:size=10' -h 25 -w 300 -y 15 -o 0.9 -l 10"
myMailer   = "sylpheed"
myBrowser  = "$BROWSER"

-- Layouts
myLayouts = emptyBSP ||| Tall 1 (3/100) (1/2) ||| Full

-- Workspaces
myWS = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

-- Color Setting
colorOrange    = "#DAA520"
colorBlue      = "#77A0D4"
colorGreen     = "#519CA5"
colorRed       = "#E15F67"
colorGray      = "#6E7E93"
colorWhite     = "#FDFDFE"
colorNormalbg  = "#181818"
colorFg        = "#D0CDD9"

-- Syntax sugar
x ? (y, z) = if x then y else z

-- Keybindings
myKeys :: XConfig t -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig { modMask = mask }) = M.fromList $
    [ (( mask .|. shiftMask   , xK_Return    ), spawn myTerminal)
    , (( mask                 , xK_comma     ), sendMessage (IncMasterN ( 1)))
    , (( mask                 , xK_period    ), sendMessage (IncMasterN (-1)))
    , (( mask                 , xK_b         ), sendMessage ToggleStruts)
    , (( mask                 , xK_q         ), spawn "pkill xmobar; xmonad --restart")
    , (( mod4Mask             , xK_l         ), spawn "physlock")
    , (( mod4Mask             , xK_x         ), namedScratchpadAction scratchpads "TiS")
    , (( mask                 , xK_d         ), spawn myMenu) ]
    ++ -- Workspace
    [ (( mod4Mask             , xK_Left      ), prevWS)
    , (( mod4Mask             , xK_Right     ), nextWS) ]
    ++ -- Special keys (Audio)
    [ (( 0                    , xF86XK_AudioMute        ), spawn "amixer set Master toggle")
    , (( 0                    , xF86XK_AudioRaiseVolume ), spawn "amixer set Master 5%+")
    , (( 0                    , xF86XK_AudioLowerVolume ), spawn "amixer set Master 5%-") ]
    ++ -- Special keys (Utility)
    [ (( 0                    , xF86XK_Search           ), spawn myMenu)
    , (( 0                    , xF86XK_HomePage         ), spawn myBrowser)
    , (( 0                    , xF86XK_Mail             ), spawn myMailer) ]
    ++ -- Navigation2D
    [ (( mask                 , xK_h         ), windowGo L True)
    , (( mask                 , xK_j         ), windowGo D True)
    , (( mask                 , xK_k         ), windowGo U True)
    , (( mask                 , xK_l         ), windowGo R True)
    , (( mask .|. shiftMask   , xK_h         ), windowSwap L True)
    , (( mask .|. shiftMask   , xK_j         ), windowSwap D True)
    , (( mask .|. shiftMask   , xK_k         ), windowSwap U True)
    , (( mask .|. shiftMask   , xK_l         ), windowSwap R True) ]
    ++ -- BinarySpacePartition
    [ (( mask .|. controlMask , xK_l         ), sendMessage $ ExpandTowards R)
    , (( mask .|. controlMask , xK_h         ), sendMessage $ ExpandTowards L)
    , (( mask .|. controlMask , xK_j         ), sendMessage $ ExpandTowards D)
    , (( mask .|. controlMask , xK_k         ), sendMessage $ ExpandTowards U)
    , (( mask                 , xK_r         ), sendMessage Rotate)
    , (( mask                 , xK_s         ), sendMessage Swap)
    , (( mask                 , xK_n         ), sendMessage FocusParent)
    , (( mask .|. controlMask , xK_n         ), sendMessage SelectNode)
    , (( mask .|. shiftMask   , xK_n         ), sendMessage MoveNode) ]
    ++ -- Switch workspace
    [ (( m .|. mask           , k            ), windows $ onCurrentScreen f i)
        | (i, k) <- zip (workspaces' conf) [ xK_1 .. xK_9 ]
        , (f, m) <- [ (W.view, 0), (W.shift, shiftMask) ]]

-- ManageHook
myManage = composeOne $
    [ isDialog -?> doCenterFloat
    , role =? "pop-up" -?> doCenterFloat
    , role =? "bubble" -?> doCenterFloat
    , role =? "task_dialog" -?> doCenterFloat
    , role =? "Preferences" -?> doCenterFloat
    , role =? "page-info" -?> doCenterFloat
    , className =? "Sylpheed" <&&> appName =? "compose" -?> doCenterFloat
    , className =? "Pcmanfm" -?> doCenterFloat
    , className =? "Pavucontrol" -?> doCenterFloat
    , className =? "Lxappearance" -?> doCenterFloat
    , className =? "Uim-pref-gtk" -?> doCenterFloat
    , className =? "Sxiv" -?> doCenterFloat
    , className =? "qjackctl" -?> doCenterFloat
    , className =? "Ninix_main.rb" -?> doIgnore
    ] where role = stringProperty "WM_WINDOW_ROLE"

-- Named Scratchpad
scratchpads =
    [ NS "TiS" (myTerminal ++ " -N 'TiS'") (appName =? "TiS") doCenterFloat
    ] where role = stringProperty "WM_WINDOW_ROLE"

-- XMobar sttings
wsPP = xmobarPP
    { ppOrder           = \(ws:l:t:_) -> [ws,l,t]
    , ppCurrent         = xmobarColor colorRed     colorNormalbg . \s -> "\xf111"
    , ppUrgent          = xmobarColor colorOrange  colorNormalbg . \s -> "\xf06a"
    , ppVisible         = xmobarColor colorRed     colorNormalbg . \s -> "\xf192"
    , ppHidden          = xmobarColor colorGray    colorNormalbg . \s -> getIcon s "\xf111"
    , ppLayout          = xmobarColor colorFg      colorNormalbg . \s -> getIcon (last $ words s) s
    , ppTitle           = xmobarColor colorOrange  colorNormalbg
    , ppWsSep           = " "
    , ppSep             = "  \xf0da  "
    }
  where
    getIcon x y = case (x) of
        "NSP"  -> "\xf24a"
        "BSP"  -> "\xf009"
        "Tall" -> "\xf0fe"
        "Full" -> "\xf065"
        _      -> y

myStartupHook = do
    spawn "nitrogen --restore"
    spawn "compton"
    spawn "dunst"

myLogHook h = workspaceNamesPP wsPP
    { ppOutput = hPutStrLn h
    } >>= dynamicLogWithPP

-- Main
main :: IO ()
main = do
    nScreens <- countScreens
    h <- spawnPipe "xmobar"
    xmonad . withNavigation2DConfig def $ ewmh def
        { modMask  = mod1Mask
        , terminal = myTerminal
        , focusFollowsMouse = False
        , clickJustFocuses = False
        , normalBorderColor = "#101010"
        , workspaces = withScreens nScreens myWS
        , layoutHook = avoidStruts (gaps [(U,5),(R,5),(L,5),(D,5)] $ spacing 5 $ myLayouts)
        , manageHook = myManage <+> manageHook def <+> namedScratchpadManageHook scratchpads <+> manageDocks
        , keys = myKeys <+> keys def
        , startupHook = ewmhDesktopsStartup <+> myStartupHook <+> docksStartupHook
        , handleEventHook = handleEventHook def <+> fullscreenEventHook <+> docksEventHook
        , logHook = myLogHook h
        }
