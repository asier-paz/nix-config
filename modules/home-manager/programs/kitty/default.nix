{ pkgs, nixgl, nixGlNvidiaConfig, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;

  nixGLPkg = pkgs.callPackage "${nixgl}/nixGL.nix" {
    nvidiaVersion = nixGlNvidiaConfig.driverVersion;
    nvidiaHash = nixGlNvidiaConfig.driverHash;
  };

  kitty-wrapped = pkgs.writeShellScriptBin "kitty" ''
    ${nixGLPkg.nixGLNvidia}/bin/nixGLNvidia-${nixGlNvidiaConfig.driverVersion} ${pkgs.kitty}/bin/kitty "$@"
  '';
in
{
  home.packages = [
    kitty-wrapped
  ];

  programs.kitty = {
    enable = true;
    package = kitty-wrapped; # Tell HM to use our wrapped version
    extraConfig = ''
      background_opacity 0.8
      confirm_os_window_close -1
    '';
  };

  # Enable catppuccin theming for kitty.
  catppuccin.kitty.enable = true;
}
