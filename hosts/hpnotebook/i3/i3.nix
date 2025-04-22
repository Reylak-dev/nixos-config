{ config, pkgs, callPackage, ... }:

{
  services.xserver = {
    enable = true;
    
    desktopManager = {
      xterm.enable = false;
    };
    
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        rofi
        lxterminal
        lxappearance
        i3status
        i3lock
        i3blocks
        polybar
      ];
    };
  };
}
