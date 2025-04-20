{ config, pkgs, lib, ... }:

{
  options = {
    gaming.enable = lib.mkEnableOption "Enables gaming apps";
  };

  config = lib.mkIf config.gaming.enable {

    home.packages = with pkgs; [
      lutris
      heroic
      mangohud
      goverlay
      steam
      steam-run
      gamemode
      gamescope
    ];
  };
}
