{ pkgs, ... }:

let
  catppuccin = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "delta";
    rev = "7b06b1f174c03f53ff68da1ae1666ca3ef7683ad";
    hash = "sha256-HHD0hszHIxf/tyQgS5KtdAN5m0EM9oI54cA2Ij1keOI=";
  };

  deltaWrapped = pkgs.symlinkJoin {
    name = "delta-wrapped-${pkgs.delta.version}";
    paths = [
      (pkgs.writeShellScriptBin "delta" ''
        if [ -z "''${DELTA_FEATURES:-}" ]; then
          case "$(uname -s)" in
            Darwin)
              if /usr/bin/defaults read -g AppleInterfaceStyle >/dev/null 2>&1; then
                export DELTA_FEATURES="catppuccin-macchiato"
              else
                export DELTA_FEATURES="catppuccin-latte"
              fi
              ;;
            Linux)
              if command -v gsettings >/dev/null 2>&1 && [ "$(gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null || true)" = "'prefer-dark'" ]; then
                export DELTA_FEATURES="catppuccin-macchiato"
              else
                export DELTA_FEATURES="catppuccin-latte"
              fi
              ;;
          esac
        fi
        exec ${pkgs.delta}/bin/delta "$@"
      '')
      pkgs.delta
    ];
  };
in
{
  home = {
    packages = [ deltaWrapped ];
    file = {
      "delta.catppuccin.gitconfig".source = catppuccin + "/catppuccin.gitconfig";
    };
  };
}
