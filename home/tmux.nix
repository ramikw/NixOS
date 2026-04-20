{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    terminal = "screen-256color";
    keyMode = "vi";

    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.sensible
      tmuxPlugins.prefix-highlight
    ];

    extraConfig = ''
      # Splitting panes with v and s
      unbind s
      bind v split-window -h
      bind s split-window -v

      # Moving between panes with Prefix h,j,k,l
      unbind l

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Pane resizing panes with Prefix H,J,K,L
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      # Set the default terminal mode to 256color mode
      set-option -ga terminal-overrides ",xterm-256color:Tc"

      # Enable activity alerts
      setw -g monitor-activity on
      set -g visual-activity on

      # Renumber on closing a window
      set-option -g renumber-windows on

      # Keep title in sync with window title
      set-option -g set-titles on
      set-option -g set-titles-string "tmux - #{pane_title}"

      # Remap copying keys
      bind Escape copy-mode
      bind-key -T copy-mode-vi v send -X begin-selection
      bind-key -T copy-mode-vi 'C-q' send -X begin-selection \; send -X rectangle-toggle
      bind-key -T copy-mode-vi y send -X copy-selection-and-cancel
      unbind p
      bind p paste-buffer	

      # Moving to last window
      bind N last-window

      # Pane movement
      bind-key @ command-prompt -p "join pane from:"  "join-pane -h -s '%%'"

      # Toggle status line
      bind-key g set-option -g status

      # Theme
      set -g status-justify "left"
      set -g status-left-style "none"
      set -g message-command-style "fg=#ddc7a1,bg=#45403d"
      set -g status-right-style "none"
      set -g pane-active-border-style "fg=#7daea3"
      set -g status-style "none,bg=#282828"
      set -g message-style "fg=#ddc7a1,bg=#45403d"
      set -g pane-border-style "fg=#45403d"
      set -g status-right-length "100"
      set -g status-left-length "100"
      setw -g window-status-activity-style "none"
      setw -g window-status-separator ""
      setw -g window-status-style "none,fg=#7c6f64,bg=#282828"
      set -g status-left "#[fg=#1d2021,bg=#a9b665] #S #[fg=#a9b665,bg=#282828,nobold,nounderscore,noitalics]"
      set -g status-right "#{prefix_highlight} #[fg=#45403d]#[fg=#ddc7a1,bg=#45403d] %H:%M "
      setw -g window-status-format "#[fg=#282828,bg=#32302f]#[fg=#ddc7a1,bg=#32302f] #I | #W #[fg=#32302f,bg=#282828]"
      setw -g window-status-current-format "#[fg=#282828,bg=#7daea3]#[fg=#1d2021,bg=#7daea3] #I | #W #[fg=#7daea3,bg=#282828]"
      '';
  };
}
