{ pkgs, ... }:
{
  # This is not working on non-Nixos system because of the GPU acceleration requirements. Use the system's package instead
  # Install kitty via home-manager module
  # programs.kitty = {
  #   enable = true;
  # };

  # Enable catppuccin theming for kitty.
  catppuccin.kitty.enable = true;
}
