{ ... }:

{

  programs.kitty = {
    enable = true;
    theme = "Kanagawa";
    # Themes used
    # Kanagawa
    # Atom One Light

    font = {
      size = 10;
      name = "0xProto Nerd Font";
    };
    shellIntegration = {
      enableZshIntegration = true;
    };
    keybindings = {
      "ctrl+x" = "copy_to_clipboard";
      "ctrl+alt+v" = "paste_from_clipboard";
      "ctrl+alt+t" = "new_tab";
      "ctrl+alt+w" = "close_tab";
      # "ctrl+l" = "next_tab";
      # "ctrl+h" = "previous_tab";
      "ctrl+shift+t" = "set_tab_title";
      "ctrl+alt+." = "move_tab_forward";
      "ctrl+alt+," = "move_tab_backward";


      # Layouts
      "ctrl+space" = "next_layout";
      "ctrl+shift+v" = "goto_layout tall"; # vertical
      "ctrl+shift+s" = "goto_layout stack";
      "ctrl+shift+z" = "toggle_layout stack";

      # Windows
      "ctrl+alt+l" = "next_window";
      "ctrl+alt+h" = "previous_window";
      "ctrl+shift+r" = "start_resizing_window";
      "ctrl+shift+space" = "swap_with_window";

      # Tabs
      "ctrl+1" = "goto_tab 1";
      "ctrl+2" = "goto_tab 2";
      "ctrl+3" = "goto_tab 3";
      "ctrl+4" = "goto_tab 4";
      "ctrl+5" = "goto_tab 5";
      "ctrl+6" = "goto_tab 6";
    };
    settings = {
      background_opacity = "0.5";
      tab_bar_edge = "bottom";
      tab_powerline_style = "angled";
      tab_bar_style = "powerline";
      mouse_hide_wait = 0;
      scrollback_lines = 100000;
      strip_trailing_spaces = "always";
      hide_window_decorations = true;
      enable_audio_bell = false;
      cursor_shape = "block";
      cursor_blink_interval = "1";
      enabled_layouts = "all";
      allow_hyperlinks = "yes";
      url_color = "#0087bd";
      url_style = "curly";
    };
  };
}
