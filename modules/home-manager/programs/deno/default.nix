{
  pkgs,
  ...
}:
let
  deno = pkgs.deno;
in
{
  # Ensure package installed
  home.packages = [ deno ];

  xdg.mimeApps.defaultApplicationPackages = [ deno ];
}
