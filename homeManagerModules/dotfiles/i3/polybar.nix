{ lib, config, pkgs, ... }:

{
  options = {
    polybarConfig.enable = lib.mkEnableOption "Enables the polybar configuration for i3wm";
  };
 
  config = lib.mkIf config.polybarConfig.enable {
    services.polybar = {

      enable = true;

      package = pkgs.polybarFull;

      script = "polybar";

      config = {

	"colors" = {

	  background = "#0f0f0f";
	  background-alt = "#353535";
	  foreground = "#ffffff";
	  primary = "#9333a6";
	  secondary = "#bd63cf";
	  alert = "#A54242";
	  disabled = "#707880";

	};

	"bar/reylak" = let
	  colors = config.services.polybar.config."colors";
	in {

	  width = "100%";
	  height = "24pt";
	  radius = 8;

	  background = colors.background;
	  foreground = colors.foreground;

	  line-size = "3pt";

	  border-size = "4pt";
	  border-color = "#00000000";

	  padding-left = 0;
	  padding-right = 1;

	  module-margin = 2;

	  separator = "|";
	  separator-foreground = colors.disabled;

	  font-0 = "Iosevka Nerd Font;2";

	  modules-left = "applications power systray";
	  modules-center = "xworkspaces";
	  modules-right = "pulseaudio memory cpu battery date";

	  cursor-click = "pointer";
	  cursor-scroll = "ns-resize";

	  enable-ipc = true;

	  wm-restack = "i3";

	};

	"module/systray" = {

	  type = "internal/tray";

	  format-margin = "4pt";
	  tray-spacing = "10pt";

        };

	"module/xworkspaces" = let
	  colors = config.services.polybar.config."colors";
	in {

	  type = "internal/xworkspaces";

	  label-active = "%name%";
	  label-active-background = colors.background-alt;
	  label-active-underline = colors.primary;
	  label-active-padding = 1;

	  label-occupied = "%name%";
	  label-occupied-padding = 1;

	  label-urgent = "%name%";
	  label-urgent-background = colors.alert;
	  label-urgent-padding = 1;

	  label-empty = "%name%";
	  label-empty-foreground = colors.disabled;
	  label-empty-padding = 1;

	};

	"module/pulseaudio" = let
	  colors = config.services.polybar.config."colors";
	in {

	  type = "internal/pulseaudio";

	  format-volume = "<ramp-volume> <label-volume>";

	  ramp-volume-0 = " ";
	  ramp-volume-1 = " ";
	  ramp-volume-2 = " ";
	  ramp-volume-foreground = colors.primary;

	  label-volume = "%percentage%%";

	  label-muted = "";
	  label-muted-foreground = colors.disabled;

	};

	"module/memory" = let
	  colors = config.services.polybar.config."colors";
	in {

	  type = "internal/memory";
	  interval = 2;
	  format-prefix = "  ";
	  format-prefix-foreground = colors.primary;
	  label = "%percentage_used:2%%";

	};

	"module/cpu" = let
	  colors = config.services.polybar.config."colors";
	in {

	  type = "internal/cpu";
	  interval = 2;
	  format-prefix = "  ";
	  format-prefix-foreground = colors.primary;
	  label = "%percentage:2%%";

	};

	"module/date" = let
	  colors = config.services.polybar.config."colors";
	in {

	  type = "internal/date";
	  interval = 1;

	  date = "%H:%M";
	  date-alt = "%Y-%m-%d %H:%M:%S";

	  label = "%date%";
	  label-foreground = colors.foreground;
	};

	"module/battery" = let
	  colors = config.services.polybar.config."colors";
	in {
	  type = "internal/battery";

	  label-discharging = "%percentage%%";
	  format-discharging = "<ramp-capacity> <label-discharging>";

	  label-charging = "%percentage%%";
	  format-charging = "<ramp-capacity> <label-discharging>";

	  ramp-capacity-0 = " ";
	  ramp-capacity-1 = " ";
	  ramp-capacity-2 = " ";
	  ramp-capacity-3 = " ";
	  ramp-capacity-4 = " ";

	  full-at = 99;
	  low-at = 10;
	};

	"module/applications" = let
	  colors = config.services.polybar.config."colors";
	in {
	  type = "custom/script";

	  label = " ";
	  label-foreground = colors.primary;
	  format = "<label>";
	  format-padding-left = 5;

	  exec = "echo <format>";
	  click-left = "rofi -show drun -show-icons";
	};

	"module/power" = let
	  colors = config.services.polybar.config."colors";
	in {
	  type = "custom/script";

	  label = "⏻";
	  label-foreground = colors.primary;
	  format = "<label>";

	  exec = "echo <format>";
	  click-left = "rofi -show power-menu -modi power-menu:rofi-power-menu";
	};

	"settings" = {

	  screenchange-reload = true;
	  pseudo-transparency = true;

	};

      };
    };
  };
}
