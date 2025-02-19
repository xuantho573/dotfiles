{
  description = "My personal home-manager config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      system = builtins.currentSystem;
      pkgs = nixpkgs.legacyPackages.${system};
      username = builtins.getEnv "USER";
      homeDirectory = builtins.getEnv "HOME";
      homeManagerDir = homeDirectory + "/projects/personal/dotfiles";
    in {
      homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs username homeDirectory homeManagerDir; };
        modules = [./home.nix];
      };
    };
}
