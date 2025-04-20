{ pkgs, config, lib, inputs, outputs, myLib, ... }:

{
  imports = 
    [
      ./drivers/nvidia.nix
      ./drivers/vulkan.nix
      ./hyprland/hypr.nix
      ./virtualization/virt.nix
    ];
}
