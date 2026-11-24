{
  description = "Personal dotfiles for macOS (nix-darwin + home-manager) and Arch Linux (system-manager + home-manager)";

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
    system-manager = {
      url = "github:numtide/system-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      nixpkgs-unstable,
      nixgl,
      darwin,
      home-manager,
      system-manager,
      ...
    }:
    let
      systems = [
        "aarch64-darwin"
        "x86_64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;

      mkPkgs =
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = if nixpkgs.lib.hasSuffix "linux" system then [ nixgl.overlay ] else [ ];
        };

      mkPkgsUnstable =
        system:
        import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };

      flakeRoot = ./.;

      # Pure by default (falls back to `default`); dynamically overridable via
      # DOTFILES_DIR when evaluated with --impure (e.g. via `./init.sh`/`dotfiles switch`).
      resolveFlakeDir =
        default:
        let
          envDir = builtins.getEnv "DOTFILES_DIR";
        in
        if envDir != "" then envDir else default;

      mkHomeArgs =
        {
          system,
          username,
          homeDirectory,
          defaultFlakeDir ? "${homeDirectory}/projects/personal/dotfiles",
        }:
        {
          inherit
            inputs
            username
            homeDirectory
            flakeRoot
            ;
          pkgs-unstable = mkPkgsUnstable system;
          flakeDir = resolveFlakeDir defaultFlakeDir;
        };

      m4HomeArgs = mkHomeArgs {
        system = "aarch64-darwin";
        username = "xuantho573";
        homeDirectory = "/Users/xuantho573";
      };

      archHomeArgs = mkHomeArgs {
        system = "x86_64-linux";
        username = "xuantho573";
        homeDirectory = "/home/xuantho573";
      };
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = mkPkgs system;
        in
        {
          default = pkgs.mkShellNoCC {
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
        }
      );

      darwinConfigurations.M4 = darwin.lib.darwinSystem {
        specialArgs = {
          inherit inputs;
          localHostName = "M4";
          inherit (m4HomeArgs) username homeDirectory flakeDir;
          homeManagerExtraSpecialArgs = m4HomeArgs;
        };
        modules = [
          ./hosts/m4
        ];
      };

      systemConfigs.optiplex-arch = system-manager.lib.makeSystemConfig {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./hosts/optiplex-arch/system.nix
        ];
      };

      homeConfigurations."xuantho573@optiplex-arch" = home-manager.lib.homeManagerConfiguration {
        pkgs = mkPkgs "x86_64-linux";
        extraSpecialArgs = archHomeArgs;
        modules = [
          ./hosts/optiplex-arch/home.nix
        ];
      };
    };
}
