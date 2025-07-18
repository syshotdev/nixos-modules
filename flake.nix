{
  description = "Syshotdev's beginner flake that also has modules";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    # Cutting edge unstable releases
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  } @ inputs: let
    # Everything inside this "let" statement are variables
    inherit (self) outputs;

    system = "x86_64-linux";
    pkgsUnstable = import nixpkgs-unstable {
      inherit system;
    };
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        (final: prev: {
          unstable = pkgsUnstable;
        })
      ];
    };
    config = pkgs.config;
    lib = pkgs.lib;
    specialArgs = { inherit inputs outputs config lib nixpkgs pkgs home-manager; };
  in {
    # TODO: Un-revert the formatting changes for the module system
    # Everything inside these brackets are attributes, accessable via outputs.attribute
    systemModules = import ./modules/system specialArgs; # Modules for system
    homeModules = import ./modules/home specialArgs; # Modules for users
    scriptModules = import ./modules/scripts specialArgs; # Scripts that I've made

    # Custom packages (to be built) not in the nix repository
    # This variable *only* lists the paths to the packages, you have to build them and include them into pkgs.
    customPackages = import ./modules/custom-packages;

    overlays = import ./modules/overlays { inherit inputs; };

    nixosConfigurations = {
      # Eventually tests
    };
  };
}
