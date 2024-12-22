{ pkgs, lib, config, ... }:
with lib;
with lib.types;

let
  cfg = config.modules.dev.emulator.alacritty;
  opacity = 1.0;
  font-size = if builtins.match ".*desktop*." (builtins.getEnv "DEVICE") != null then 12 else 8;
  font-name = config.modules.preferences.fonts.name;

  scheduled-theme = { start-hour, end-hour, light-theme, dark-theme }:
    let
      hour = import (../../../../../utils/get-current-time.nix) { inherit pkgs; };
    in
    if (hour > start-hour && hour < end-hour)
    then light-theme
    else dark-theme;
in
{
  options.modules.dev.emulator.alacritty = {

    enable = mkOption {
      type = bool;
      default = false;
      description = mkDoc ''
        Enable alacritty terminal emulator
      '';
    };

    theme = mkOption {
      type = str;
      default = "gruvbox_material_hard_dark";
      description = mkDoc ''
        color scheme for alacritty
      '';
    };

    scheduled = mkOption {
      type = bool;
      default = false;
      description = mkDoc ''
        Enable schedule theme switching based on time ranges
      '';
    };

    start-hour = mkOption {
      type = int;
      default = 0;
      description = mkDoc ''
        start hour for scheduled
      '';
    };

    end-hour = mkOption {
      type = int;
      default = 0;
      description = mkDoc ''
        end hour for scheduled
      '';
    };

    light-theme = mkOption {
      type = str;
      default = "rose_pine_dawn";
      description = mkDoc ''
        scheduled color scheme for alacritty
      '';
    };

    dark-theme = mkOption {
      type = str;
      default = "gruvbox_material_hard_dark";
      description = mkDoc ''
        scheduled color scheme for alacritty
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.alacritty
    ];

    programs.alacritty = {
      enable = true;
      settings = {
        selection.save_to_clipboard = true;
        colors.draw_bold_text_with_bright_colors = true;
        general =
          let
            theme =
              if cfg.scheduled then
                scheduled-theme { inherit (cfg) start-hour end-hour light-theme dark-theme; }
              else cfg.theme;
          in
          {
            import = [ pkgs.alacritty-theme."${theme}" or (throw "Alacritty theme missing!") ];
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
          };
        env.TERM = "xterm-256color";
        terminal.shell.program = "zsh";

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
          size = font-size;
          offset = {
            x = 0;
            y = 0;
          };
          glyph_offset = {
            x = 0;
            y = 0;
          };

          normal = {
            family = "${font-name} Nerd Font";
            style = "Medium";
          };
          bold = {
            family = "${font-name} Nerd Font Mono";
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

