{ pkgs, config, lib, inputs, outputs, myLib, ... }:

{
  imports = 
    [
      ./desktop-apps/desktop-apps.nix
      ./nixpkgs.nix
    ];
}
