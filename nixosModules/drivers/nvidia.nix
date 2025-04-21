# Nvidia propietary drivers

{ lib, config, pkgs, ... }:

{
  options.nvidiaGpu.enable = lib.mkEnableOption "Enable nvidia drivers"; 
  
  config = lib.mkIf config.nvidiaGpu.enable {
    hardware = {
      graphics.enable = true;
      nvidia = {
        modesetting.enable = true;
        open = false;
        nvidiaSettings = true;
        nvidiaPersistenced = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
      };
    };

    services.xserver.videoDrivers = ["nvidia"];
  };
}
