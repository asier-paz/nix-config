{
  pkgs,
  ...
}:
{
  xdg = {
    enable = true;

    systemDirs = {
      # This is very important when using unmanaged KDE Plasma (in a standalone home-manager install for example)
      data = [
        "/usr/share"
        "/usr/local/share"
      ];
    };

    mimeApps = {
      enable = true;
      defaultApplicationPackages = [
        pkgs.gnome-text-editor
        pkgs.loupe
        pkgs.totem
      ];
    };

    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
