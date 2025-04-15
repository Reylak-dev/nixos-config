# Start nwg-menu with waybar

{ pkgs }:

pkgs.writeShellScriptBin "start-menu" ''
    ${pkgs.nwg-menu}/bin/nwg-menu -cmd-lock "hyprlock" -term "kitty" -fm "nemo" -debug
''
