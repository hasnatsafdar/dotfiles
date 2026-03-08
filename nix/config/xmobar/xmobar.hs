-- TokyoNight XMobar Config
-- TODO OBS and mic stuff (optional)

Config {
   -- Appearance
     font            = "JetBrainsMono Nerd Font Mono Bold 10.5"
   , additionalFonts = [ "JetBrainsMono Nerd Font Mono 10.5" ]
   , bgColor         = "#1a1b26"
   , fgColor         = "#a9b1d6"
   , alpha           = 128
   , position        = TopSize C 100 25
   , border          = BottomB
   , borderColor     = "#444b6a"
   , borderWidth     = 2

   -- Layout
   , sepChar         = "%"
   , alignSep        = "}{"
   , template        = " %XMonadLog% }{ %date% │ %volume% │ %brightness% │ %battery% │ %wlp3s0wi% │ %temp% │ %memory% │ %cpu%  "

   -- Plugins
   , commands        =
        [ Run XMonadLog
        , Run Cpu
            [ "-t", "<fc=#7aa2f7> CPU:</fc> <total>%"
            , "-L", "30"
            , "-H", "70"
            , "-l", "#9ece6a"
            , "-n", "#e0af68"
            , "-h", "#f7768e"
            ] 10
        , Run Battery
            [ "-t", "<fc=#7aa2f7>󱐋 BAT:</fc> <acstatus>"
            , "-L", "20"
            , "-H", "80"
            , "-l", "#f7768e"
            , "-n", "#e0af68"
            , "-h", "#9ece6a"
            , "--"
            , "-o", "<left>% (<timeleft>)"
            , "-O", "<fc=#e0af68>Charging</fc> <left>%"
            , "-i", "<fc=#9ece6a>Charged</fc>"
            ] 50
        , Run Com "/home/hxt/.config/xmobar/scripts/memory.sh" [] "memory" 5
        , Run Com "/home/hxt/.config/xmobar/scripts/temp.sh" [] "temp" 10
        , Run Com "/home/hxt/.config/xmobar/scripts/brightness.sh" [] "brightness" 10
        , Run Com "/home/hxt/.config/xmobar/scripts/volume.sh" [] "volume" 5
        , Run Wireless "wlp3s0"
            [ "-t", "<fc=#7aa2f7></fc> <essid> <quality>%"
            , "-L", "30"
            , "-H", "70"
            , "-l", "#f7768e"
            , "-n", "#e0af68"
            , "-h", "#9ece6a"
            ] 10
        , Run Date "<fc=#ad8ee6>󰥔 %I:%M:%S %p │  %a %b %_d</fc>" "date" 10
        ]
   }
