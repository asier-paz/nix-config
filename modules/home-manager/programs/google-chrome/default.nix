{
  pkgs,
  mkNixGLWrapper,
  ...
}:
let
  google-chrome-wrapped = (
    mkNixGLWrapper pkgs.google-chrome "google-chrome-stable" [
      "--ignore-gpu-blocklist"
      "--enable-gpu-rasterization"
      "--enable-zero-copy"
    ]
  );
in
{
  # Ensure Google Chrome browser package installed
  home.packages = [ google-chrome-wrapped ];

  xdg.mimeApps.defaultApplicationPackages = [ google-chrome-wrapped ];
}
