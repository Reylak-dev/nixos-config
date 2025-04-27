{ pkgs, lib, config, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
    nerd-fonts.arimo
    nerd-fonts.hack
    nerd-fonts.inconsolata
  ];
}
