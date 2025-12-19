{ pkgs, nixgl, nixGlNvidiaConfig, ... }:
let
  nixGLPkg = pkgs.callPackage "${nixgl}/nixGL.nix" {
    nvidiaVersion = nixGlNvidiaConfig.driverVersion;
    nvidiaHash = nixGlNvidiaConfig.driverHash;
  };

  nixGLBin = "${nixGLPkg.nixGLNvidia}/bin/nixGLNvidia-${nixGlNvidiaConfig.driverVersion}";

  google-chrome-wrapped = pkgs.buildEnv {
    name = "google-chrome-wrapped";
    paths = [ pkgs.google-chrome ];
    # Explicitly link these directories into the new derivation
    pathsToLink = [ "/bin" "/share/applications" "/share/icons" ];
    
    nativeBuildInputs = [ pkgs.makeWrapper ];
    
    postBuild = ''
      # 1. Remove the symlinked binary so we can replace it with a wrapper
      rm $out/bin/google-chrome-stable

      # 2. Create the wrapper script that calls nixGL
      makeWrapper ${pkgs.google-chrome}/bin/google-chrome-stable $out/bin/google-chrome-stable \
        --run "${nixGLBin}"

      # 3. Handle the Desktop file: Remove the symlink and create a real file we can edit
      rm $out/share/applications/com.google.Chrome.desktop
      cp ${pkgs.google-chrome}/share/applications/google-chrome.desktop $out/share/applications/google-chrome.desktop
      chmod +w $out/share/applications/google-chrome.desktop

      # 4. Update the Exec line to point to our new wrapped binary
      # Note: We use $out/bin/google-chrome-stable to ensure it's absolute
      sed -iE "s|(Exec=)/nix/store/[^/]*-google-chrome[^/]*/bin/google-chrome-stable|\1/$out/bin/google-chrome-stable|g" $out/share/applications/google-chrome.desktop
    '';
  };
in
{
  # Ensure Google Chrome browser package installed
  home.packages = [ google-chrome-wrapped ];

  xdg.mimeApps.defaultApplicationPackages = [ google-chrome-wrapped ];
}

# let
#   system = pkgs.stdenv.hostPlatform.system;

#   nixGLPkg = pkgs.callPackage "${nixgl}/nixGL.nix" {
#     nvidiaVersion = nixGlNvidiaConfig.driverVersion;
#     nvidiaHash = nixGlNvidiaConfig.driverHash;
#   };

#   google-chrome-wrapped = pkgs.writeShellScriptBin "google-chrome-stable" ''
#     ${nixGLPkg.nixGLNvidia}/bin/nixGLNvidia-${nixGlNvidiaConfig.driverVersion} ${pkgs.google-chrome}/bin/google-chrome-stable "$@"
#   '';
# in