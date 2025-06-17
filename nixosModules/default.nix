{ pkgs, config, lib, inputs, outputs, myLib, ... }:

{
  imports = 
    [
      ./drivers/nvidia.nix
      ./drivers/vulkan.nix
      ./dotfiles/i3/i3.nix
      ./dotfiles/sway/sway.nix
      ./dotfiles/general/stylixConfig.nix
      ./virtualization/virt.nix
      ./fonts/nerdFonts.nix
    ];
}
