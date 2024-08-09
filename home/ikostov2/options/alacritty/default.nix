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

  # programs.terminator = {
  #   enable = true;
  # Not working
  # conf interprets the string values as strings, instead as literals
  #############
  # config = {
  #   global_config = {
  #     focus = lib.serde.toTOML "system";
  #     extra_styling = false;
  #     putty_paste_style_source_clipboard = true;
  #   };
  #
  #   keybindings = {
  #     new_tab = "<Shift><Alt>t";
  #     go_next = " <Shift><Alt>Page_Up";
  #     go_prev = " <Shift> <Alt> Page_Down";
  #     go_up = " <Shift><Alt>k";
  #     go_down = " <Shift><Alt>j";
  #     go_left = " <Shift><Alt>h";
  #     go_right = " <Shift><Alt>l";
  #     split_horiz = " <Shift><Alt>s";
  #     split_vert = " <Shift><Alt>v";
  #     close_term = " <Shift><Alt>w";
  #     copy = " <Primary>c";
  #     paste = " <Primary><Alt>v";
  #     toggle_scrollbar = "";
  #     close_window = " <Shift><Alt>q";
  #     resize_up = " <Primary><Shift>k";
  #     resize_down = " <Primary><Shift>j";
  #     resize_left = " <Primary><Shift>l";
  #     resize_right = " <Primary><Shift>h";
  #     toggle_zoom = "";
  #     hide_window = "";
  #     new_window = " <Primary><Alt>t";
  #     edit_window_title = " <Primary><Alt>bracketleft";
  #     edit_tab_title = "";
  #     edit_terminal_title = "";
  #     preferences_keybindings = "";
  #     help = "";
  #   };
  #
  #   profiles.default = {
  #     background_color = "#282828";
  #     background_darkness = 0.97;
  #     background_type = " transparent";
  #     cursor_fg_color = "#ffffff";
  #     cursor_bg_color = "#9a9996";
  #     cursor_color_default = false;
  #     font = " 0xProto Nerd Font 10";
  #     foreground_color = "#ebdbb2";
  #     show_titlebar = false;
  #     palette = "#000000:#cc0000:#4e9a06:#c4a000:#3465a4:#75507b:#06989a:#d3d7cf:#555753:#ef2929:#8ae234:#fce94f:#729fcf:#ad7fa8:#34e2e2:#eeeeec";
  #     login_shell = true;
  #     copy_on_selection = true;
  #   };
  #   layouts.default = {
  #     window0 = {
  #       type = "Window";
  #       parent = "";
  #     };
  #
  #     child1 = {
  #       type = "Terminal";
  #       parent = "window0";
  #       profile = "default";
  #     };
  #   };
  # };
  # };
}
