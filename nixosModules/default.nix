{ pkgs, config, lib, inputs, outputs, myLib, ... }:

{
  imports = 
    [
      ./drivers/nvidia.nix
      ./drivers/vulkan.nix
      ./dotfiles/general/stylixConfig.nix
      ./virtualization/virt.nix
      ./fonts/nerdFonts.nix
    ];
}
