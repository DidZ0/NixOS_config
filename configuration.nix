{ config, pkgs, ... }:



{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;

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
	Freebox-5E5956 = {
		psk = "*1BudokaOne1303*";
	};
  };


 # X11 
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "intl";
  services.xserver.libinput.enable = true;
  services.xserver.windowManager.dwm.enable = true;

  # SOUND
  sound.enable = true;
  security.rtkit.enable = true;

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
    vscode
    arandr
    jdk
    insomnia
    sbt
    nodejs
    yarn
  ];



  # SERVICES
  services.gnome3.gnome-keyring.enable = true;
  services.gnome3.seahorse.enable = true;
  services.openssh.enable = true;
  hardware.bluetooth.enable = true;
  services.pipewire = {
  	enable = true;
	alsa.enable = true;
	alsa.support32Bit = true;
	pulse.enable = true;
	media-session.config.bluez-monitor.rules = [
    {
      # Matches all cards
      matches = [ { "device.name" = "~bluez_card.*"; } ];
      actions = {
        "update-props" = {
          "bluez5.reconnect-profiles" = [ "hfp_hf" "hsp_hs" "a2dp_sink" ];
          # mSBC is not expected to work on all headset + adapter combinations.
          "bluez5.msbc-support" = true;
          # SBC-XQ is not expected to work on all headset + adapter combinations.
          "bluez5.sbc-xq-support" = true;
        };
      };
    }
    {
      matches = [
        # Matches all sources
        { "node.name" = "~bluez_input.*"; }
        # Matches all outputs
        { "node.name" = "~bluez_output.*"; }
      ];
    }
  ];
  };

  environment.sessionVariables = rec {
    PATH = [ 
      "\${XDG_BIN_HOME}:\${HOME}/.npm-global/bin"
    ];
  };


  system.stateVersion = "22.05"; # Did you read the comment?
}

