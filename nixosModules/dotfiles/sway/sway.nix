{ config, pkgs, callPackage, ... }:

{

  programs.foot = {

    enable = true;

    enableZshIntegration = true;

  };

  programs.uwsm = {

     enable = true;

     waylandCompositors.sway = {

	prettyName = "Sway";
	comment = "Sway compositor managed by UWSM";
	binPath = "/run/current-system/sw/bin/sway";

     };

  };

  programs.sway = {
    enable = true;
    xwayland.enable = true;
    extraPackages = with pkgs; [
      wofi
      nwg-look
      xfce.thunar
      swaylock
      waybar
      pamixer
    ];

    extraOptions = ["--unsupported-gpu"];

    wrapperFeatures.base = true;
    wrapperFeatures.gtk = true;
  };

  programs.waybar.enable = true;
}
