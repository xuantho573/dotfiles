{
  pkgs,
  config,
  username,
  homeDirectory,
  localHostName,
  ...
}:

{
  system.primaryUser = username;
  users.users."${username}".home = homeDirectory;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    # pkgs.vim
  ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  # system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  networking = {
    inherit localHostName;
  };

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  nixpkgs.config = {
    allowBroken = false;
    allowUnfree = true;
  };

  environment.systemPath = [
    config.homebrew.brewPrefix
  ];

  homebrew = {
    enable = true;
    brews = [
      { name = "mermaid-cli"; }
      { name = "tmux"; }
    ];
    casks = [
      { name = "betterdiscord-installer"; }
      { name = "dockdoor"; }
      { name = "handbrake-app"; }
      { name = "logitech-g-hub"; }
      { name = "megasync"; }
      { name = "messenger"; }
      { name = "zalo"; }
    ];
    onActivation.cleanup = "zap";
  };

  system.defaults = {
    controlcenter = {
      AirDrop = false;
      BatteryShowPercentage = true;
      Bluetooth = false;
      Display = false;
      FocusModes = true;
      NowPlaying = false;
      Sound = true;
    };

    dock = {
      autohide = true;
      largesize = 96;
      magnification = true;
      orientation = "bottom";
      tilesize = 64;
      wvous-bl-corner = 1;
      wvous-br-corner = 1;
      wvous-tl-corner = 1;
      wvous-tr-corner = 1;
      persistent-apps = [
        { app = "/System/Applications/Launchpad.app"; }
        { app = "/System/Applications/Mail.app"; }
        { app = "/System/Applications/Calendar.app"; }
        { app = "/System/Applications/System Settings.app"; }
      ];
    };

    iCal = {
      CalendarSidebarShown = true;
      "first day of week" = "Monday";
    };

    menuExtraClock = {
      Show24Hour = true;
      ShowDate = 1;
      ShowDayOfMonth = true;
      ShowDayOfWeek = true;
      ShowSeconds = false;
    };

    NSGlobalDomain."com.apple.swipescrolldirection" = true;
  };
}
