{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];


  # BOOT
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # USERS
   users.users.didzo = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       firefox
     ];
   };

  # LOCALE
   time.timeZone = "Europe/Paris";
   i18n.defaultLocale = "en_US.UTF-8";
   console = {
     font = "Lat2-Terminus16";
     keyMap = "colemak";
  };

  # NETWORK 
  networking.hostName = "nixlap";
  networking.wireless.enable = true;
  networking.wireless.networks = {
	SITIO_BORGNODES = {
		psk = "BGns3.6**";
	};
  };


 # X11 
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "colemak";
  services.xserver.libinput.enable = true;
  services.xserver.windowManager.dwm.enable = true;

  # SOUND
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # PACKAGES
  environment.systemPackages = with pkgs; [
    vim
    wget
    dwm
    st
    dmenu
    neofetch
    neovim
    brave
    flameshot
    git
  ];



  # SERVICES
  # services.openssh.enable = true;



  system.stateVersion = "22.05"; # Did you read the comment?
}

