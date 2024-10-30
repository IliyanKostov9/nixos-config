{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.alacritty;
  opacity = 1.0;
in
{
  options.modules.alacritty = { enable = mkEnableOption "alacritty"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.alacritty
    ];

    programs.alacritty = {
      enable = true;
      settings = {
        selection.save_to_clipboard = true;
        colors.draw_bold_text_with_bright_colors = true;
        import = [ pkgs.alacritty-theme.gruvbox_material_hard_dark or (throw "Alacritty theme missing!") ];
        # Favorite themes
        ##################
        # Dark blue
        # > deep_space
        # Pink
        # > dracula
        # > hardhacker
        # Purple
        # > iris
        # Dark green
        # > alacritty_0_12
        # > everforest_dark
        # > gruvbox_material_hard_dark
        # > gruvbox_dark
        # > kanagawa_wave
        # > kanagawa_dragon
        # Dark
        # > github_dark_colorblind
        working_directory = config.home.homeDirectory;
        env.TERM = "xterm-256color";
        shell.program = "zsh";

        mouse = {
          hide_when_typing = true;
          bindings = [
            {
              mouse = "Middle";
              action = "ExpandSelection";
            }
            {
              mouse = "Right";
              action = "PasteSelection";
            }
          ];
        };

        cursor = {
          style = "Block";
          unfocused_hollow = true;
        };

        window = {
          dynamic_title = true;
          decorations_theme_variant = "Dark";
          dynamic_padding = false;
          decorations = "full";
          inherit opacity;
          startup_mode = "Maximized";
          option_as_alt = "OnlyLeft";

          dimensions = {
            columns = 120;
            lines = 40;
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
          size = if builtins.getEnv "DEVICE" == "desktop" then 12 else 8;
          offset = {
            x = 0;
            y = 0;
          };
          glyph_offset = {
            x = 0;
            y = 0;
          };

          normal = {
            family = "${config.modules.fonts.name} Nerd Font";
            style = "Medium";
          };
          bold = {
            family = "${config.modules.fonts.name} Nerd Font Mono";
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
          {
            key = "Space";
            mode = "Vi";
            action = "ToggleNormalSelection";
          }
          {
            key = "V";
            mods = "Control|Alt";
            action = "Paste";
          }
        ];
      };
    };
  };
}

