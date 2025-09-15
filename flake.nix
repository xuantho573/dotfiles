{
  description = "My personal home-manager config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/?rev=501cfec8277f931a9c9af9f23d3105c537faeafe";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      darwin,
      home-manager,
      ...
    }:
    let
      system = builtins.currentSystem;
      pkgs = nixpkgs.legacyPackages.${system};
      localHostName = "M4";
      username = "xuantho573";
      homeDirectory = "/Users/${username}";
      flakeDir = homeDirectory + "/projects/personal/dotfiles";
      homeManagerExtraSpecialArgs = {
        inherit
          inputs
          username
          homeDirectory
          flakeDir
          ;
      };
    in
    {
      darwinConfigurations."${localHostName}" = darwin.lib.darwinSystem {
        modules = [
          ./configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = false;
            home-manager.useUserPackages = false;
            home-manager.users."${username}" = ./home.nix;
            home-manager.extraSpecialArgs = homeManagerExtraSpecialArgs;
          }
        ];
        specialArgs = {
          inherit
            username
            homeDirectory
            flakeDir
            localHostName
            ;
        };
      };
      homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = homeManagerExtraSpecialArgs;
        modules = [ ./home.nix ];
      };
    };
}
