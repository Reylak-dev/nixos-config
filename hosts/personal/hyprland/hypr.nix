# Hyprland compositor configuration and packages

{ config, pkgs, ... }:

let
  start-menu = import ./scripts/start-menu.nix { inherit pkgs; };
  notifications-client = import ./scripts/notifications-client.nix { inherit pkgs; };
in
{

   xdg.portal = {
     enable = true;
     wlr.enable = true;
   };

   programs.uwsm.enable = true;
   programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
   };

   programs.hyprlock.enable = true;
   services.hypridle.enable = true;

   environment.systemPackages = with pkgs; [
      waybar
      wofi
      hyprpaper
      hyprpolkitagent
      hyprcursor
      hyprshot
      nwg-look
      swaynotificationcenter
      start-menu
      notifications-client
      swayimg
   ]; 
}
