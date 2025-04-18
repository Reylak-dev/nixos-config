# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
      ./system/drivers/vulkan.nix
      ./system/drivers/nvidia.nix
      ./system/virtualization/virt.nix
      ./system/hyprland/hypr.nix
      ./system/desktop-apps/desktop-apps.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  services.dbus = {
    enable = true;
    implementation = "broker";
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Gnome-keyring
  services.gnome.gnome-keyring.enable = true;

  # Enable Nix flakes and commands
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "America/Argentina/Buenos_Aires";

  # Select internationalisation properties.
  i18n.defaultLocale = "es_AR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_AR.UTF-8";
    LC_IDENTIFICATION = "es_AR.UTF-8";
    LC_MEASUREMENT = "es_AR.UTF-8";
    LC_MONETARY = "es_AR.UTF-8";
    LC_NAME = "es_AR.UTF-8";
    LC_NUMERIC = "es_AR.UTF-8";
    LC_PAPER = "es_AR.UTF-8";
    LC_TELEPHONE = "es_AR.UTF-8";
    LC_TIME = "es_AR.UTF-8";
  };
  
  programs.starship.enable = true;

  # Enable zsh as default shell
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "starship" ];
      theme = "agnoster";
    };
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Cinnamon Desktop Environment.
  #services.xserver.displayManager.lightdm.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.xserver.desktopManager.cinnamon.enable = true;

  # Home manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      reylak = import ./users/reylak/home.nix;
    };
    backupFileExtension = "backup";
  };


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "latam";
    variant = "";
  };

  # Install all nerdfonts
  fonts.packages = with pkgs; [ 
    nerd-fonts.fira-code
    nerd-fonts.iosevka
    nerd-fonts.arimo 
  ];

  # Configure console keymap
  console.keyMap = "la-latin1";

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplipWithPlugin ];
    browsing = true;
    browsedConf = ''
       BrowseDNSSDSubTypes _cups,_print
       BrowseLocalProtocols all
       BrowseRemoteProtocols all
       CreateIPPPrinterQueues All

       BrowseProtocols all
    '';
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };


  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.reylak = {
    isNormalUser = true;
    description = "reylak";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Nvidia propietary drivers
  #hardware = {
  #  graphics.enable = true;
  #  nvidia = {
  #    modesetting.enable = true;
  #    open = false;
  #    nvidiaSettings = true;
  #    nvidiaPersistenced = true;
  #    package = config.boot.kernelPackages.nvidiaPackages.stable;
  #  };
  #};

  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  boot.kernelModules = [
    "v4l2loopback"
  ];

  # services.xserver.videoDrivers = ["nvidia"];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     home-manager
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     kitty
     htop
     btop
     screenfetch
     wineWowPackages.waylandFull
     glxinfo
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
