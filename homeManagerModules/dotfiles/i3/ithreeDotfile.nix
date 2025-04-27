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
	  { command = "pkill polybar && polybar"; always = true; }
	  { command = "nm-applet"; }
	  { command = "~/.fehbg"; }
	];

	colors = {

	  focused = {

	    background = "#0f0f0f";
	    border = "#9333a6";
	    childBorder = "#9333a6";
	    indicator = "#9333a6";
	    text = "#ffffff";

	  };

	};

	keybindings = let
	  modifier = config.xsession.windowManager.i3.config.modifier;
	in lib.mkOptionDefault {
	  "${modifier}+Return" = "exec alacritty"; 
	  "${modifier}+p" = "exec --no-startup-id librewolf";
	  "${modifier}+Shift+f" = "exec --no-startup-id thunar";
	  "XF86AudioLowerVolume" = "exec pamixer -d 5";
	  "XF86AudioRaiseVolume" = "exec pamixer -i 5";
	  "XF86AudioMute" = "exec pamixer --toggle-mute";
	};

	defaultWorkspace = "workspace number 1";

      };
    };

    programs.rofi = {
      enable = true;
      theme = "rounded-purple-dark";
    };

    services.picom = {
      enable = true;
      package = pkgs.picom-pijulius;
      backend = "xrender";
      activeOpacity = 1.0;
      inactiveOpacity = 0.6;
      menuOpacity = 1.0;
      fadeDelta = 2;
      vSync = true;
      shadow = true;
      shadowOpacity = 0.5;
      settings = {
	detect-client-opacity = true;

	detect-rounded-corners = true;
	corner-radius = 10;
	round-corners = 10;

	opacity-rule = [ "100:class_g *?= 'Rofi'" ];

	experimental-backends = false;
      };

    };

    programs.feh = {
      enable = true;
    };

    polybarConfig.enable = true;

  };
}
