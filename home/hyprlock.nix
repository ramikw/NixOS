{ ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 2;
        hide_cursor = false;
      };

      background = [
        {
          path = "${./hyprpaper/imgs/background3.jpg}";
          blur_passes = 2;
          blur_size = 4;
        }
      ];

      label = [
        {
          text = "$TIME";
          color = "rgb(d4be98)";
          font_size = 78;
          font_family = "HackNerdFont";
          position = "0, 160";
          shadow_passes = 3;
        }
      ];

      input-field = [
        {
          size = "460, 45";
          font_family = "HackNerdFont";

          outline_thickness = 2;

          inner_color = "rgba(40, 40, 40, 1.0)";
          outer_color = "rgba(60, 56, 54, 1.0)";

          font_color = "rgba(221, 199, 161, 1.0)";
          caret_color = "rgba(168, 153, 132, 1.0)";

          fail_color = "rgba(234, 105, 98, 1.0)";

          placeholder_text = ''<span foreground="##a89984">Password...</span>'';

          fade_on_empty = false;
        }
      ];
    };
  };
}
