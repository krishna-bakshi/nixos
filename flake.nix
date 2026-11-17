{
  description = "flake for my system";

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-26.05";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    dux-greeter = {
      url = "github:duxlabs-dev/dux-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dux-files = {
      url = "github:duxlabs-dev/dux-files";
      inputs.nixpkgs.follows = "nixpkgs";
    };


  };

  outputs = inputs: {
    nixosConfigurations = {
      l490-kr = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./packages.nix

          inputs.nix-flatpak.nixosModules.nix-flatpak
          inputs.dux-greeter.nixosModules.default
          # inputs.dux-files.homeModules.default
          ./niri.nix
        ];
      };
    };
  };
}

