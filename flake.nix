{
  description = "Nixos config flake";

  inputs = {

    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # stylix
    stylix.url = "github:nix-community/stylix";
  };

  outputs = { self, nixpkgs, home-manager, stylix, ... }@inputs:
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

    # NixOS Configurations

    nixosConfigurations = {

      personal = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs system;};
        modules = [
          ./hosts/personal/configuration.nix
          ./nixosModules
	  stylix.nixosModules.stylix
	  home-manager.nixosModules.home-manager
        ];
      };

      hpnotebook = nixpkgs.lib.nixosSystem {
	specialArgs = {inherit inputs system;};
	modules = [
	  ./hosts/hpnotebook/configuration.nix
	  ./nixosModules
	  stylix.nixosModules.stylix
	  home-manager.nixosModules.home-manager
	];
      };

    };

    # home-manager configurations

    homeConfigurations = {

      "reylak@personal" = home-manager.lib.homeManagerConfiguration {

        pkgs = "x86_64-linux";
	extraSpecialArgs = {inherit inputs;};
	modules = [
	  ./hosts/personal/home.nix
	  ./homeManagerModules
	];
      };

      "reylak@hpnotebook" = home-manager.lib.homeManagerConfiguration {

        pkgs = "x86_64-linux";
	extraSpecialArgs = {inherit inputs;};
	modules = [
	  ./hosts/hpnotebook/home.nix
	  ./homeManagerModules
	];

      };

    };

    # Modules
    nixosModules.default = ./nixosModules;
    homeManagerModules.default = ./homeManagerModules;
  };
}
