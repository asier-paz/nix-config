{
  pkgs,
  ...
}:
let
  google-chrome = pkgs.google-chrome;
in
{
  # Ensure Google Chrome browser package installed
  home.packages = [ google-chrome ];

  xdg.mimeApps.defaultApplicationPackages = [ google-chrome ];
}
