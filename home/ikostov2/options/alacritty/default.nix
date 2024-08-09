{ pkgs, lib, config, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      selection.save_to_clipboard = true;
      colors.draw_bold_text_with_bright_colors = true;
      working_directory = config.home.homeDirectory;

      window = {
        env = { TERM = "xterm-256color"; };
        dynamic_title = true;
        dynamic_padding = false;
        decorations = "buttonless";
        opacity = 0.3;
        startup_mode = "Maximized";
        option_as_alt = "OnlyLeft";

        mouse.bindings = [{
          mouse = "Middle";
          action = "PasteSelection";
        }];
        cursor = {
          style = "block";
          unfocused_hollow = true;
        };

        dimensions = {
          columns = 0;
          lines = 0;
        };
        padding = {
          x = 2;
          y = 2;
        };
      };
      scrolling = {
        history = 100000;
        multiplier = 3;
      };

      font = {
        size = 8;
        offset = {
          x = 0;
          y = 0;
        };
        glyph_offset = {
          x = 0;
          y = 0;
        };

        normal = {
          family = "0xProto Nerd Font";
          style = "Medium";
        };
        bold = {
          family = "0xProto Nerd Font Mono";
          style = "Bold";
        };
        italic = {
          family = "DejaVu Serif, Regular Italic";
          style = "Italic";
        };
        bold_italic = {
          family = "DejaVu Serif, Regular Italic";
          style = "Bold Italic";
        };
      };

      keyboard.bindings = [
        {
          key = "Space";
          mods = "Control";
          mode = "~Search";
          action = "ToggleViMode";
        }
        {
          key = "N";
          mods = "Control";
          action = "SpawnNewInstance";
        }
      ];
    };
  };

}
