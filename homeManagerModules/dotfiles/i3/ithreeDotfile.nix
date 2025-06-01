{ lib, config, pkgs, ... }:
{

  imports = [
    ./polybar.nix
  ];

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

	menu = "rofi -show drun -show-icons";

	bars = [
	  { command = "polybar"; }
	];

	startup = [
	  { command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"; }
	  { command = "pkill polybar && polybar"; always = true; }
	  { command = "nm-applet"; }
	  { command = "~/.fehbg"; }
	  { command = "autotiling"; always = true; }
	];

	window = {
	  titlebar = false;
	  border = 0;

	};

	keybindings = let
	  modifier = config.xsession.windowManager.i3.config.modifier;
	  menu = config.xsession.windowManager.i3.config.menu;
	in lib.mkOptionDefault {
	  "${modifier}+Return" = "exec alacritty"; 
	  "${modifier}+l" = "exec --no-startup-id librewolf";
	  "${modifier}+Shift+u" = "exec --no-startup-id thunar";
          "${modifier}+m" = "exec --no-startup-id ${menu}";

	  "XF86AudioLowerVolume" = "exec pamixer -d 5";
	  "XF86AudioRaiseVolume" = "exec pamixer -i 5";
	  "XF86AudioMute" = "exec pamixer --toggle-mute";

	  "${modifier}+Print" = "exec escrotum ~/Imágenes/Screenshots/%Y-%m-%d-%H%M%S_$wx$h_escrotum.png";
	};

	defaultWorkspace = "workspace number 1";

      };
    };

    programs.rofi = {
      enable = true;
    };

    services.picom = {
      enable = true;

      activeOpacity = 1.0;
      inactiveOpacity = 0.6;
      menuOpacity = 1.0;

      fade = true;
      fadeDelta = 3;

      vSync = false;

      shadow = true;
      shadowOpacity = 0.5;
      shadowOffsets = [
	15
	15
      ];

      settings = {
	detect-client-opacity = true;

	corner-radius = 15;
	round-corners = 1;

	opacity-rule = [ "100:class_g *?= 'Rofi'" ];

	blur = {

	  method = "dual_kawase";
	  size = 8;

	};

      };

    };

    polybarConfig.enable = true;

    home.packages = with pkgs; [
      rofi-power-menu
      autotiling
      escrotum
    ];
  };
}
