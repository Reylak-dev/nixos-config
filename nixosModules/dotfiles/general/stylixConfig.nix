{ pkgs, ... }:

{
  stylix = {
    enable = true;

    autoEnable = true;

    base16Scheme = {

      base00 = "141414";
      base01 = "141414"; 
      base02 = "4f4f4f";
      base03 = "424242";
      base04 = "9c9c9c";
      base05 = "9c9c9c";
      base06 = "8d3dfc";
      base07 = "ff6666";
      base08 = "ff0000";
      base09 = "fc4e4e";
      base0A = "ff0000";
      base0B = "8d3dfc";
      base0C = "808080";
      base0D = "8d3dfc";
      base0E = "4f4f4f";
      base0F = "43706f";

    };

    image = ./wallpaper_rayo.jpg;

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    polarity = "dark";

    homeManagerIntegration = {

      autoImport = true;
      followSystem = true;

    };

    targets = {
      nixos-icons.enable = true;
    };

  };
}
