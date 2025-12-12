{
  pkgs,
  ...
}:
let
  vscode = pkgs.vscode;
in
{
  # Ensure Visual Studio Code package installed
  home.packages = [ vscode ];

  xdg.mimeApps.defaultApplicationPackages = [ vscode ];
}
