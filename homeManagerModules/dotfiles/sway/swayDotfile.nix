{ lib, config, pkgs, ... }:
{

  options = {
    dotfiles.sway.enable = lib.mkEnableOption "Enables the sway dotfile";
  };

  config = lib.mkIf config.dotfiles.sway.enable {
    wayland.windowManager.sway = {

      enable = true;

      config = {
        modifier = "Mod4";
        gaps = {
          inner = 10;
          outer = 3;
	};

	menu = "wofi --show drun --allow-images";

	bars = [
	  { command = "waybar"; }
	];

	startup = [
	  { command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"; }
	  { command = "nm-applet"; }
	  { command = "autotiling"; always = true; }
	];

	window = {
	  titlebar = false;
	  border = 0;

	};

	input = {
	  "*" = {

	    xkb_layout = "latam";
	    xkb_variant = "dvorak";

	  };
	};

	keybindings = let
	  modifier = config.wayland.windowManager.sway.config.modifier;
	  menu = config.wayland.windowManager.sway.config.menu;
	in lib.mkOptionDefault {
	  "${modifier}+Return" = "exec foot"; 
	  "${modifier}+l" = "exec --no-startup-id librewolf";
	  "${modifier}+Shift+u" = "exec --no-startup-id thunar";
          "${modifier}+m" = "exec --no-startup-id ${menu}";
	  "${modifier}+d" = "exec discord";

	  "XF86AudioLowerVolume" = "exec pamixer -d 5";
	  "XF86AudioRaiseVolume" = "exec pamixer -i 5";
	  "XF86AudioMute" = "exec pamixer --toggle-mute";

	  #"${modifier}+Print" = "exec escrotum ~/Imágenes/Screenshots/%Y-%m-%d-%H%M%S_$wx$h_escrotum.png";
	};

	defaultWorkspace = "workspace number 1";

      };

      extraOptions = [ "--unsupported-gpu" ];
    };

    programs.waybar.enable = true;

    programs.wofi = {
      enable = true;
    };

    programs.foot.enable = true;

    home.packages = with pkgs; [
      autotiling
      grim
      slurp
    ];
  };
}
