{ pkgs, nixgl, nixGlNvidiaConfig, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;

  nixGLPkg = pkgs.callPackage "${nixgl}/nixGL.nix" {
    nvidiaVersion = nixGlNvidiaConfig.driverVersion;
    nvidiaHash = nixGlNvidiaConfig.driverHash;
  };

  google-chrome-wrapped = pkgs.writeShellScriptBin "google-chrome-stable" ''
    ${nixGLPkg.nixGLNvidia}/bin/nixGLNvidia-${nixGlNvidiaConfig.driverVersion} ${pkgs.google-chrome}/bin/google-chrome-stable "$@"
  '';
in
{
  # Ensure Google Chrome browser package installed
  home.packages = [ google-chrome-wrapped ];

  xdg.mimeApps.defaultApplicationPackages = [ google-chrome-wrapped ];
}
