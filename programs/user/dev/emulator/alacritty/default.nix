{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with lib.types; let
  cfg = config.modules.dev.emulator.alacritty;
  inherit (config.modules.preferences) fonts;
  opacity = 1.0;

  scheduled-theme = {
    start-hour,
    end-hour,
    light-theme,
    dark-theme,
  }: let
    inherit (import ../../../../../utils/get-current-time.nix {inherit pkgs lib;}) hour;
  in
    if (hour > start-hour && hour < end-hour)
    then light-theme
    else dark-theme;
in {
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
        scheduled light color scheme for alacritty
      '';
    };
    light-theme-hex =
      mkOption
      {
        type = str;
        default = "#f6f2ee";
        description = mkDoc ''
          hex representation for light color scheme for alacritty
        '';
      };

    dark-theme = mkOption {
      type = str;
      default = "gruvbox_material_hard_dark";
      description = mkDoc ''
        scheduled dark color scheme for alacritty
      '';
    };
    dark-theme-hex =
      mkOption
      {
        type = str;
        default = "#333333";
        description = mkDoc ''
          hex representation for dark color scheme for alacritty
        '';
      };
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        selection.save_to_clipboard = true;
        colors.draw_bold_text_with_bright_colors = true;
        general = let
          theme =
            if cfg.scheduled
            then scheduled-theme {inherit (cfg) start-hour end-hour light-theme dark-theme;}
            else cfg.theme;
        in {
          import = [pkgs.alacritty-theme."${theme}" or (throw "Alacritty theme missing!")];
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
          inherit (fonts) size;
          offset = {
            x = 0;
            y = 0;
          };
          glyph_offset = {
            x = 0;
            y = 0;
          };

          normal = {
            inherit (fonts) family;
            style = "Medium";
          };
          bold = {
            family = fonts.family-bold;
            style = "Bold";
          };
          italic = {
            family = fonts.family-italic;
            style = "Italic";
          };
          bold_italic = {
            family = fonts.family-bold-italic;
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
