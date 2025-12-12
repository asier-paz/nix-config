{
  pkgs,
  ...
}:
let
  # Fallback version: 2024.3.5
  fbPkgs = import (
    builtins.fetchGit {
    # Descriptive name to make the store path easier to identify
    name = "webstorm-fallback-version";
    url = "https://github.com/NixOS/nixpkgs/";
    ref = "refs/heads/nixpkgs-unstable";
    rev = "c5dd43934613ae0f8ff37c59f61c507c2e8f980d";
  }) {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };

  webstorm = fbPkgs.jetbrains.webstorm;
in
{
  # Ensure Webstorm package installed
  home.packages = [ webstorm ];

  xdg.mimeApps.defaultApplicationPackages = [ webstorm ];
}
