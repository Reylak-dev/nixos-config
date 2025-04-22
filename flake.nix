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
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs system;};
      modules = [
        ./hosts/<hostname>/configuration.nix
        ./nixosModules
      ];
    };

    #homeConfigurations."reylak" = inputs.home-manager.lib.homeManagerConfiguration {
    #  modules = [
    #    ./users/reylak/home.nix
    #    ./users/reylak/user-modules
    #  ];
    #};

    nixosModules.default = ./nixosModules;
    homeManagerModules.default = ./homeManagerModules;
  };
}
