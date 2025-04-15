
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vulkan-tools
    vulkan-headers
  ];
}
