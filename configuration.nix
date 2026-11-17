# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }: {#---------------------------------------------------------------------#
  imports = [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./packages.nix
      ./niri.nix


  ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };


  # Trying to fix the crash happening when kate tries to show a file picker
  ## ---> Started using "rofi -show drun" which did not crash kate when trying to open a file. only dms application launcher did it.
  #environment.sessionVariables = {
  #  QT_USE_PORTAL = "0";
  #};
  

  # Ensure Qt applications integrate smoothly with your desktop
  qt = {
    enable = true;
  #platformTheme = "qt5ct"; # or "kde" if you are on Plasma
  };

  # try switching Waydroid to its nftables-compatible package
  virtualisation.waydroid.package = pkgs.waydroid-nftables;


  networking.hostName = "l490-kr"; # Define your hostname.

  # Enabling Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # using ibus input method, it has a built-in emoji input
  i18n.inputMethod = {
    type = "ibus";
    enable = true;
    ibus.waylandFrontend = true;
  };

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-color-emoji
      nerd-fonts.jetbrains-mono
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif" "Noto Color Emoji" ];
        sansSerif = [ "Noto Sans" "Noto Color Emoji" ];
        monospace = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };


  console = {
    font = "ter-v24n";
    packages = with pkgs; [ terminus_font ];
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;


  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  
  # Enable PLASMA
  # services.desktopManager.plasma6.enable = true;
  # services.displayManager.plasma-login-manager.enable = false;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    krishna = {
      isNormalUser = true;
      extraGroups = [ "wheel" "ydotool" "input" "greeter" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
        ## user specific packages
      ];
    };

    ThePenguin = {
      isNormalUser = true;
      extraGroups = [ "wheel" "greeter" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
        ## user specific packages
      ];
    };

    Guest = {
      isNormalUser = true;
      packages = with pkgs; [
        ## user specific packages
      ];
    };
  };

# Trying to fix white screen on yt videos on brave (firefox worked fine)
# Edit : ! it fixed it.
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Replaces driSupport32Bit

    extraPackages = with pkgs; [
      vulkan-loader
      vulkan-validation-layers
      vulkan-extension-layer
    ];

    extraPackages32 = with pkgs.pkgsi686Linux; [
      vulkan-loader
      vulkan-validation-layers
      vulkan-extension-layer
    ];


  };




  # programs.firefox.enable = true;










  # Allow unfree packages
  #nixpkgs.config.allowUnfree = true;

  # Enable localsend
  #programs.localsend.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  #environment.systemPackages = with pkgs; [
    #neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #wget
    #brave
    #git
    #obsidian
    #localsend
    #remmina
    #btop
  #];












  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}


