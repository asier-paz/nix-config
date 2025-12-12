{
  pkgs,
  ...
}:
let
  # Fallback version: 2024.3.5
  fbPkgs = import (
    builtins.fetchGit {
    # Descriptive name to make the store path easier to identify
    name = "idea-fallback-version";
    url = "https://github.com/NixOS/nixpkgs/";
    ref = "refs/heads/nixpkgs-unstable";
    rev = "c5dd43934613ae0f8ff37c59f61c507c2e8f980d";
  }) {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };

  idea = fbPkgs.jetbrains.idea-ultimate;
in
{
  # Ensure package installed
  home.packages = [ idea ];

  xdg.mimeApps.defaultApplicationPackages = [ idea ];
}
