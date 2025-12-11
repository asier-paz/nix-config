{ pkgs, ... }:
{
  # Install kitty via home-manager module
  programs.kitty = {
    enable = true;
  };

  # Enable catppuccin theming for kitty.
  catppuccin.kitty.enable = true;
}
