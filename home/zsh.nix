{ pkgs, hostName, config, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    history.size = 10000;
    dotDir = "${config.xdg.configHome}/zsh";
    plugins = [
      # Used to start nix-shell in zsh
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];

    shellAliases = {
      update = "sudo nixos-rebuild switch";
      upgrade = "sudo nix flake update && sudo nixos-rebuild --flake /etc/nixos#${hostName} switch";
      clean = "sudo nix-collect-garbage --delete-old; sudo /run/current-system/bin/switch-to-configuration boot";
      tx = "tmuxinator";
      restart-hyprlock = "hyprctl --instance 0 'dispatch exec hyprlock'";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "tmux"
        "git"
        "man"
        "colored-man-pages"
        "colorize"
        "command-not-found"
      ];
    };
    localVariables = {
      ZSH_TMUX_AUTOSTART = true;
    };
    autosuggestion = {
      enable = true;
      highlight = "fg=244";
    };
    initContent = ''
      source ~/.config/zsh/.p10k.zsh
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      bindkey '^ ' autosuggest-accept # ctrl + space
    '';
  };
}
