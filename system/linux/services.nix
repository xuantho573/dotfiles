{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    inputs.system-manager.packages.${pkgs.stdenv.hostPlatform.system}.default
    tailscale
  ];

  services.openssh = {
    enable = true;
    openFirewall = false;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  systemd.services.tailscaled = {
    enable = true;
    description = "Tailscale node agent";
    after = [ "network-pre.target" ];
    wants = [ "network-pre.target" ];
    wantedBy = [ "system-manager.target" ];
    path = with pkgs; [
      iproute2
      iptables
      kmod
      procps
    ];
    serviceConfig = {
      ExecStartPre = "${pkgs.tailscale}/bin/tailscaled --cleanup";
      ExecStart = "${pkgs.tailscale}/bin/tailscaled --state=/var/lib/tailscale/tailscaled.state --socket=/run/tailscale/tailscaled.sock --port=41641";
      ExecStopPost = "${pkgs.tailscale}/bin/tailscaled --cleanup";
      Restart = "on-failure";
      RuntimeDirectory = "tailscale";
      RuntimeDirectoryMode = "0755";
      StateDirectory = "tailscale";
      StateDirectoryMode = "0700";
      CacheDirectory = "tailscale";
      CacheDirectoryMode = "0750";
      Type = "notify";
    };
  };
}
