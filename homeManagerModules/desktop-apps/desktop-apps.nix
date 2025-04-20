# Daily usage apps

{ lib, config, pkgs, ... }:

{
  imports =
    [
      ./gaming/gaming.nix
    ];

  options = {
    desktop-apps.enable = lib.mkEnableOption "Enables the daily usage apps";
  };
  
  config = lib.mkIf config.desktop-apps.enable {
    home.packages = with pkgs; [
      discord
      librewolf
      onlyoffice-desktopeditors
      obs-studio
      github-desktop
      bitwarden-desktop
    ];

    gaming.enable = true;
  };
}
