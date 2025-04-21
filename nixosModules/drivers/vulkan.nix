
{ config, pkgs, lib, ... }:

{

  options.vulkan.enable = lib.mkEnableOption "enables vulkan";

  config = lib.mkIf config.vulkan.enable {
      environment.systemPackages = with pkgs; [
      vulkan-tools
      vulkan-headers
    ];
  };
}
