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
        alacritty
        lxappearance
	xfce.thunar
        i3status
        i3lock
        i3blocks
        polybar
	pamixer
	xorg.xev
      ];
    };
  };
}
