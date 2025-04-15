# Start sway notification center client

{ pkgs }:

pkgs.writeShellScriptBin "notifications-client" ''
    ${pkgs.swaynotificationcenter}/bin/swaync-client --open-panel
''
