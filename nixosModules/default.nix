{ pkgs, config, lib, inputs, outputs, myLib, ... }:

{
  imports = 
    [
      ./drivers/nvidia.nix
      ./drivers/vulkan.nix
      ./dotfiles/i3/i3.nix
      ./dotfiles/general/stylix.nix
      ./virtualization/virt.nix
      ./fonts/nerdFonts.nix
    ];
}
