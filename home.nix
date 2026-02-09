{
  config,
  lib,
  username,
  homeDirectory,
  flakeDir,
  ...
}:

let
  mkSymlink =
    path:
    config.lib.file.mkOutOfStoreSymlink (
      lib.path.append (/. + flakeDir) (lib.path.removePrefix ./. path)
    );
in
{
  _module.args = { inherit mkSymlink; };

  imports = [
    ./module-common.nix
    ./module-linux.nix
    ./module-darwin.nix
  ];

  xdg.enable = true;
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  programs.nh = {
    enable = true;
    flake = flakeDir;
  };

  home.activation = {
    myActivationAction = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if command -v skhd >/dev/null; then
        yabai --install-service
        yabai --start-service
      fi
    '';
  };

  home = {
    # Home Manager needs a bit of information about you and the paths it should manage.
    inherit username homeDirectory;

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "25.11"; # Please read the comment before changing.
    enableNixpkgsReleaseCheck = true;
  };
}
