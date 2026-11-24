{ ... }:

{
  imports = [
    ./nix.nix
    ./services.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
  system-manager.allowAnyDistro = true;
}
