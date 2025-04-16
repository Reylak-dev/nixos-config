# Daily usage apps

{ config, pkgs, ... }:

{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  environment.systemPackages = with pkgs; [
    discord
    librewolf
    mangohud
    goverlay
    onlyoffice-desktopeditors
    obs-studio
    gamemode
    github-desktop
    bitwarden-desktop
  ];
}
