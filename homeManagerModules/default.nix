{ pkgs, config, lib, inputs, outputs, myLib, ... }:

{
  imports = 
    [
      ./desktop-apps/desktop-apps.nix
      ./dotfiles/i3/ithreeDotfile.nix
      ./nixpkgs.nix
      ./editors/codium.nix
    ];
}
