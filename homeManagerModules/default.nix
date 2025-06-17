{ pkgs, config, lib, inputs, outputs, myLib, ... }:

{
  imports = 
    [
      ./desktop-apps/desktop-apps.nix
      ./dotfiles/i3/ithreeDotfile.nix
      ./dotfiles/sway/swayDotfile.nix
      ./dotfiles/general/stylixDotfile.nix
      ./nixpkgs.nix
      ./editors/codium.nix
    ];
}
