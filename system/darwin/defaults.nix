{ ... }:

{
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
          "163" = {
            # Mission Control > Show Notification Center
            enabled = true;
            value = {
              parameters = [
                110 # N
                45 # N
                1310720 # Ctrl + Cmd
              ];
              type = "standard";
            };
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
