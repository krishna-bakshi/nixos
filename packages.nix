# /etc/nixos/packages.nix
{ pkgs, ... }: {

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enabling Flatpak
  services.flatpak.enable = true;

  # Required for Pressure Vessel / Steam Runtime containers
  boot.kernel.sysctl = {
    "kernel.unprivileged_userns_clone" = 1;
  };

  # Getting Waydroid for android apps
  virtualisation.waydroid.enable = true;




  /*
  # Adding Obsidian from the stable branch rather than the unstable branch
  nixpkgs.overlays = [
    (final: prev: {
      obsidian = (import <nixos-stable> {
        inherit (prev.stdenv.hostPlatform) system;
        config.allowUnfree = true;
      }).obsidian;
    })
  ];
  */



  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    ### TEXT EDOTOR(S) ###
    neovim
    kdePackages.kate

    ### ESSENTIALS ###
    thunar
    wget
    #brave
    firefox-bin
    obsidian
    git
    localsend
    remmina
    btop
    aria2
    motrix
    rofi
    mpv
    kdePackages.kdenlive
    gocryptfs
    pysolfc
    libremines
    p7zip
    kdePackages.okular
    bemoji
    wtype
    ydotool
    wl-clipboard
    smile
    p7zip-rar
    unrar
    alacritty
    telegram-desktop

    

    ### Terminal Emulators ###
    wezterm

    ### Gaming ###
    ppsspp

    ### Entertainment ###
    # stremio-linux-shell

    ### Other ###
    discord

    ### Gaming ###
    wineWow64Packages.staging # wine-staging (version with experimental features)
    winetricks # winetricks (all versions)
    wineWow64Packages.waylandFull # native wayland support (unstable)
    heroic
    gamemode


  ];



  ####################
  # Package Settings #
  ####################


  # Enable localsend
  programs.localsend.enable = true;

  # Allow your user profile to use the virtual input device without root sudo prompts
  users.groups.uinput.members = [ "krishna" ];
  users.groups.ydotool.members = [ "krishna" ];

  # Enable the background background daemon for ydotool
  programs.ydotool.enable = true;

  # Chromium Browser Extiensions to be installed. Worked for brave.
	programs.chromium = {
		enable = true;

		extensions = [
			"jcokkipkhhgiakinbnnplhkdbjbgcgpe" # uBlock Origin
			"nngceckbapebfimnlniiiahkandclblb" # Bitwarden Password Manager
			"knemcdpkggnbhpoaaagmjiigenifejfo" # Claude Usage Tracker
			"mckfdaahjhmnchjihljdiakamamondld" # HTML Elements Screenshot
			"hlkljlkdinjnbfmclionhbefbnefcgll" # Microsoft to Microslop
			"mmioliijnhnoblpgimnlajmefafdfilb" # Shazam
			"nbokbjkabcmbfdlbddjidfmibcpneigj" # SmoothScroll
			"mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock for YouTube
			"ehehmcocpegbmagfhajbmeofolnpdfla" # YouTube Screenshot Button
			"eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
			"ihcppnlmkfeclmehgdhjkglkbmiemnmp" # FMHY SafeGuard
			"djlkbfdlljbachafjmfomhaciglnmkgj" # Motrix WebExtension
			"mdgdgieddpndgjlmeblhjgljejejkikf" # Youtube Redux

    ];
  };



}
