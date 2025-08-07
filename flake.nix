{
  description = "My personal home-manager config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/?rev=7a732ed41ca0dd64b4b71b563ab9805a80a7d693";
    home-manager = {
      url = "github:nix-community/home-manager/?rev=501cfec8277f931a9c9af9f23d3105c537faeafe";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      system = builtins.currentSystem;
      pkgs = nixpkgs.legacyPackages.${system};
      username = builtins.getEnv "USER";
      homeDirectory = builtins.getEnv "HOME";
      homeManagerDir = homeDirectory + "/projects/personal/dotfiles";
    in
    {
      homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit
            inputs
            username
            homeDirectory
            homeManagerDir
            ;
        };
        modules = [ ./home.nix ];
      };
    };
}
