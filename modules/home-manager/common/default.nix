{
  outputs,
  userConfig,
  pkgs,
  ...
}:
{
  imports = [
    ../programs/kitty
    ../programs/albert
    ../programs/atuin
    ../programs/bat
    ../programs/google-chrome
    ../programs/btop
    ../programs/fastfetch
    ../programs/fzf
    ../programs/git
    ../programs/gpg
    ../programs/k9s
    ../programs/krew
    ../programs/lazygit
    ../programs/neovim
    ../programs/obs-studio
    ../programs/starship
    ../programs/telegram
    ../programs/tmux
    ../programs/zsh
    ../programs/vscode
    ../programs/jetbrains_webstorm
    ../programs/jetbrains_idea
    ../programs/jetbrains_datagrip
    ../programs/audacity
    ../programs/deno
    ../scripts
    ../services/flatpak
    ../misc/xdg
  ];

  # Nixpkgs configuration
  nixpkgs = {
    overlays = [
      outputs.overlays.stable-packages
    ];

    config = {
      allowUnfree = true;
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Home-Manager configuration for the user's home environment
  home = {
    username = "${userConfig.name}";
    homeDirectory =
      if pkgs.stdenv.isDarwin then "/Users/${userConfig.name}" else "/home/${userConfig.name}";
  };

  # Ensure common packages are installed
  home.packages =
    with pkgs;
    [
      dig
      dust
      eza
      fd
      jq
      kubectl
      nh
      wireguard-tools
      pipenv
      python3
      ripgrep
      terraform
      yt-dlp
      ffmpeg
      nixfmt
    ]
    ++ lib.optionals stdenv.isDarwin [
      anki-bin
      colima
      hidden-bar
      mos
      raycast
    ]
    ++ lib.optionals (!stdenv.isDarwin) [
      anki
      tesseract
      unzip
      wl-clipboard
    ];

  # Catpuccin flavor and accent
  catppuccin = {
    flavor = "macchiato";
    accent = "lavender";
  };
}
