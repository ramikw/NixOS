{
  pkgs,
  lib,
  username,
  ...
}:
{
  imports = [
    ./clipse.nix
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./hyprpaper
    ./lazygit.nix
    ./rofi
    ./swaync.nix
    ./theme.nix
    ./tmux.nix
    ./vlc
    ./vsnip
    ./waybar.nix
    ./xdg.nix
    ./zsh.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;

    size = 24;
    gtk.enable = true;

    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
  };

  services.ollama = {
    enable = true;
  };

  programs.kitty = {
    enable = true;
    themeFile = "GruvboxMaterialDarkHard";
    settings = {
      font_family = "HackNerdFont";
      font_size = 12;
      confirm_os_window_close = 0;
    };
  };

  home.packages =
    with pkgs;
    lib.mkBefore [
      tmuxinator

      hunspell
      hunspellDicts.nb_NO
      hunspellDicts.en_US
      libreoffice

      anki
      discord
      drawio
      gimp3
      megasync
      mpv
      shotcut
      thunderbird
      vlc
      vscode

      baobab # Disk Usage Analyzer
      gnome-calculator
      gnome-characters
      gnome-clocks
      gnome-disk-utility
      gnome-font-viewer
      gnome-logs
      gnome-sound-recorder
      gnome-text-editor
      loupe
      mission-center
      nautilus
      papers
      simple-scan

      azure-cli
      azurite
      bicep
      cargo
      claude-code
      clippy
      csharpier
      delta
      docker-compose
      dotnet-sdk_10
      fswatch # Used for Neovim roslyn watch plugin
      fzf
      gcc
      grcov
      grpc
      jdk
      kubectl
      minikube
      nodejs
      postman
      protobuf_29
      protols
      rustc
      rustfmt
      sqlite
      tree-sitter
      vscode-extensions.vadimcn.vscode-lldb

      # Neovim lsps and treesitter
      bash-language-server
      bibtex-tidy
      clang-tools
      dockerfile-language-server
      emmet-ls
      eslint
      gdb
      hyprls
      jdt-language-server
      jupyter
      ltex-ls
      lua-language-server
      netcoredbg
      nil
      python313Packages.debugpy
      python313Packages.python-lsp-server
      roslyn-ls
      rust-analyzer
      texlab
      tree-sitter
      typescript-language-server
      vim-language-server
      vimPlugins.nvim-treesitter.withAllGrammars
      vscode-langservers-extracted

      # Hyprland
      avizo
      hypridle
      hyprpaper
      hyprpicker
      hyprpolkitagent
      hyprshutdown
      nwg-look
      pavucontrol
      playerctl

      # Screenshot
      grim
      slurp
    ];

  home.sessionVariables = {
    sqlite_clib_path = "${pkgs.sqlite.out}/lib/libsqlite3${pkgs.stdenv.hostPlatform.extensions.sharedLibrary}";
  };

  home.sessionPath = [
    "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter"
    "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/lldb/bin"
  ];

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
