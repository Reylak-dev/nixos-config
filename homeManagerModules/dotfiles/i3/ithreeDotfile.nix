{ lib, config, pkgs, ... }:
{
  options = {
    dotfiles.i3.enable = lib.mkEnableOption "Enables the i3wm dotfile";
  };

  config = lib.mkIf config.dotfiles.i3.enable {
    xsession.windowManager.i3 = {
      enable = true;
      config = {
        modifier = "Mod4";
        gaps = {
          inner = 10;
          outer = 3;
        };
      };
    };
  };
}
