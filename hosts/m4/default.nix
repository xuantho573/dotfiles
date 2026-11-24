{
  inputs,
  localHostName,
  username,
  homeManagerExtraSpecialArgs,
  ...
}:

{
  imports = [
    ../../system/darwin
    inputs.home-manager.darwinModules.home-manager
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  networking.localHostName = localHostName;

  home-manager = {
    useGlobalPkgs = false;
    useUserPackages = false;
    users."${username}" = import ./home.nix;
    extraSpecialArgs = homeManagerExtraSpecialArgs;
  };
}
