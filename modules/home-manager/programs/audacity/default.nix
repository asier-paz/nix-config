{
  pkgs,
  ...
}:
let
  audacity = pkgs.audacity;
in
{
  # Ensure package installed
  home.packages = [ audacity ];

  xdg.mimeApps.defaultApplicationPackages = [ audacity ];
}
