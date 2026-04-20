{ ... }:
{
  programs.lazygit = {
    enable = true;

    settings = {
      os = {
        editPreset = "nvim";
      };

      gui = {
        nerdFontsVersion = "3";

        theme = {
          optionsTextColor = [ "#a9b665" ];
          inactiveBorderColor = [ "#d4be98" ];
          defaultFgColor = [ "#d4be98" ];

          cherryPickedCommitFgColor = [ "#a9b665" ];
          cherryPickedCommitBgColor = [ "#7daea3" ];

          activeBorderColor = [ "bold" ];
          unstagedChangesColor = [ "#ea6962" ];
          searchingActiveBorderColor = [ "bold" ];

          selectedLineBgColor = [ "#282828" ];
        };
      };

      git = {
        pager = [
          {
            colorArg = "always";
            pager = "delta";
          }
        ];
      };
    };
  };
}
