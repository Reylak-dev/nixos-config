{ config, pkgs, lib, ... }:

{
  options = {
    gaming.enable = lib.mkEnableOption "Enables gaming apps";
  };

  config = lib.mkIf config.gaming.enable {

    programs.lutris.enable = true;

    programs.mangohud.enable = true;

    home.packages = with pkgs; [
      heroic
      goverlay
      steam
      steam-run
      gamemode
      gamescope
    ];
  };
}
