{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    inputs.system-manager.packages.${pkgs.system}.default
  ];

  systemd.services = { };
}
