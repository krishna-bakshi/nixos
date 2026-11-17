# /etc/nixos/packages.nix
{ pkgs, inputs, ... }:

  let
  stable = import inputs.nixpkgs-stable {
    system = pkgs.system;
    config.allowUnfree = true;
  }; # ---> enables me to use stable.<pkgname> to add apps from stable branch
  in {

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Enabling Flatpak
    services.flatpak = {
      enable = true;

      packages = [
        # "com.heroicgameslauncher.hgl"
      ];
    };


    # Required for Pressure Vessel / Steam Runtime containers
    boot.kernel.sysctl = {
      "kernel.unprivileged_userns_clone" = 1;
    };

    # Getting Waydroid for android apps
    virtualisation.waydroid.enable = true;





    # Get Obsidian from stable
#     nixpkgs.overlays = [
#       (final: prev: {
#         obsidian = (import inputs.nixpkgs-stable {
#           inherit (prev.stdenv.hostPlatform) system;
#           config.allowUnfree = true;
#         }).obsidian;
#       })
#     ];


    programs.gamemode.enable = true;


    # List packages installed in system profile.
    # You can use https://search.nixos.org/ to find more packages (and options).

    environment.systemPackages = with pkgs; [
      ### TEXT EDOTOR(S) ###
      neovim
      kdePackages.kate

      ### ESSENTIALS ###
      kdePackages.dolphin
      kdePackages.kio-admin
      wget
      brave-origin
      firefox-bin
      obsidian # obsidian is here
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
      gparted
      atril

      yt-dlp
      ffmpeg



      ### Terminal Emulators ###
      wezterm

      ### Gaming ###
      ppsspp

      ### Entertainment ###
      # stremio-linux-shell

      ### Other ###
      discord
      bat # a very nice replacement of cat

      ### Gaming ###
      wineWow64Packages.staging # wine-staging (version with experimental features)
      winetricks # winetricks (all versions)
      wineWow64Packages.waylandFull # native wayland support (unstable)
      heroic
      gamemode


    ] ++ [

    # ---> add apps needed to be installed from the stable branch
      # stable.obsidian # EXAMPLE

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
