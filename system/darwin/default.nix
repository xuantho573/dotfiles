{
  config,
  username,
  homeDirectory,
  ...
}:

{
  imports = [
    ./homebrew.nix
    ./defaults.nix
  ];

  system.primaryUser = username;
  users.users."${username}".home = homeDirectory;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    # pkgs.vim
  ];

  nix.settings = {
    # Necessary for using flakes on this system.
    experimental-features = "nix-command flakes";
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  nix.gc = {
    automatic = true;
    interval = {
      Weekday = 0;
      Hour = 0;
      Minute = 0;
    }; # Weekly
    options = "--delete-older-than 7d";
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  nixpkgs.config = {
    allowBroken = false;
    allowUnfree = true;
  };

  environment.systemPath = [
    "${config.homebrew.prefix}/bin"
    "${homeDirectory}/.local/bin"
    "${homeDirectory}/.volta/bin"
  ];

  security.pam.services.sudo_local.touchIdAuth = true;

  system.activationScripts.postActivation.text = ''
    # Following line should allow us to avoid a logout/login cycle when changing settings
    sudo -u ${username} /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
}
