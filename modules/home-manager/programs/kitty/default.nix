{ pkgs, mkNixGLWrapper, ... }:
let
  kitty-wrapped = (
    mkNixGLWrapper pkgs.kitty "kitty" []
  );
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
