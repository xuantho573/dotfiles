{
  description = "My personal home-manager config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-unstable,
      darwin,
      home-manager,
      ...
    }:
    let
      system = builtins.currentSystem;
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
      localHostName = "M4";
      username = builtins.getEnv "USER";
      homeDirectory = builtins.getEnv "HOME";
      flakeDir = homeDirectory + "/projects/personal/dotfiles";
      homeManagerExtraSpecialArgs = {
        inherit
          inputs
          pkgs-unstable
          username
          homeDirectory
          flakeDir
          ;
      };
    in
    {
      devShells.${system}.default = pkgs.mkShellNoCC {
        packages = with pkgs; [
          commitlint
          just
          nixfmt
          nixd
          stylua
        ];
        shellHook = ''
          # Point git at the repo's tracked hooks (commit-msg runs commitlint)
          if [ "$(git config --local core.hooksPath)" != ".githooks" ]; then
            git config --local core.hooksPath .githooks
          fi
        '';
      };

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
