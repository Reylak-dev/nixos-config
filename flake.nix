{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

     home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
     };
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
        ];
      };

      hpnotebook = nixpkgs.lib.nixosSystem {
	specialArgs = {inherit inputs system;};
	modules = [
	  ./hosts/hpnotebook/configuration.nix
	  ./nixosModules
	];
      };

    };

    nixosModules.default = ./nixosModules;
    homeManagerModules.default = ./homeManagerModules;
  };
}
