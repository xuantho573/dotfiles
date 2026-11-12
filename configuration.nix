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
      "mermaid-cli"
    ];
    casks = [
      "font-sf-pro"
      "handbrake-app"
      "megasync"
      "slack"
      "zalo"
    ];
    onActivation.cleanup = "zap";
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  system.activationScripts.postActivation.text = ''
    # Following line should allow us to avoid a logout/login cycle when changing settings
    sudo -u ${username} /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';

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

    CustomUserPreferences = {
      "com.apple.symbolichotkeys" = {
        AppleSymbolicHotKeys = {
          # cmd + space
          "64" = {
            enabled = false;
          };
          # ctrl + left arrow
          "79" = {
            enabled = true;
          };
          # ctrl + right arrow
          "81" = {
            enabled = true;
          };
          # ctrl + 1
          "118" = {
            enabled = true;
          };
          # ctrl + 2
          "119" = {
            enabled = true;
          };
          # ctrl + 3
          "120" = {
            enabled = true;
          };
          # ctrl + 4
          "121" = {
            enabled = true;
          };
          # ctrl + 5
          "122" = {
            enabled = true;
          };
          # ctrl + 6
          "123" = {
            enabled = true;
          };
          # ctrl + 7
          "124" = {
            enabled = true;
          };
          # ctrl + 8
          "125" = {
            enabled = true;
          };
          # ctrl + 9
          "126" = {
            enabled = true;
          };
          # ctrl + 0
          "127" = {
            enabled = true;
          };
          # ctrl + alt + 1
          "128" = {
            enabled = true;
          };
          # ctrl + alt + 2
          "129" = {
            enabled = true;
          };
          # ctrl + alt + 3
          "130" = {
            enabled = true;
          };
          # ctrl + alt + 4
          "131" = {
            enabled = true;
          };
          # ctrl + alt + 5
          "132" = {
            enabled = true;
          };
          # ctrl + alt + 6
          "133" = {
            enabled = true;
          };
        };
      };
    };

    dock = {
      autohide = true;
      largesize = 96;
      magnification = true;
      mru-spaces = false;
      orientation = "bottom";
      tilesize = 64;
      wvous-bl-corner = 1;
      wvous-br-corner = 1;
      wvous-tl-corner = 1;
      wvous-tr-corner = 1;
      persistent-apps = [
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
    WindowManager.StandardHideDesktopIcons = true;

    spaces = {
      spans-displays = false;
    };
  };
}
