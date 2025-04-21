{ pkgs, config, lib, inputs, outputs, myLib, ... }:

{
  imports = 
    [
      ./drivers/nvidia.nix
      ./drivers/vulkan.nix
      ./virtualization/virt.nix
    ];
}
