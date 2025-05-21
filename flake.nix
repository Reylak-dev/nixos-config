{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:nix-community/stylix/release-25.05";
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
  in
  {
    # use "nixos", or your hostname as the name of the configuration
    # it's a better practice than "default" shown in the video
    nixosConfigurations = {

      personal = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs system;};
        modules = [
          ./hosts/personal/configuration.nix
          ./nixosModules
	  inputs.stylix.nixosModules.stylix
        ];
      };

      hpnotebook = nixpkgs.lib.nixosSystem {
	specialArgs = {inherit inputs system;};
	modules = [
	  ./hosts/hpnotebook/configuration.nix
	  ./nixosModulesa
	  inputs.stylix.nixosModules.stylix
	];
      };

    };

    nixosModules.default = ./nixosModules;
    homeManagerModules.default = ./homeManagerModules;
  };
}
