{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with lib.types; let
  cfg = config.modules.dev.emulator.ghostty;
  font-name = config.modules.preferences.fonts.name;
  font-size =
    if builtins.match "desktop" (builtins.getEnv "DEVICE") != null
    then 12
    else 12;
in {
  options.modules.dev.emulator.ghostty = {
    enable = mkOption {
      type = bool;
      default = false;
      description = mkDoc ''
        Enable ghostty terminal emulator
      '';
    };

    theme = mkOption {
      type = str;
      default = "Kanagawa Dragon";
      description = mkDoc ''
        Color scheme for ghostty
      '';
    };

    font-family = mkOption {
      type = str;
      default = "0xProto Nerd Font";
      description = mkDoc ''
        Font family
      '';
    };

    font-family-bold = mkOption {
      type = str;
      default = "0xProto Nerd Font Mono";
      description = mkDoc ''
        Bold font family
      '';
    };

    font-family-italic = mkOption {
      type = str;
      default = "DejaVu Serif, Regular Italic";
      description = mkDoc ''
        Italic font
      '';
    };

    font-family-bold-italic = mkOption {
      type = str;
      default = "DejaVu Serif, Regular Italic";
      description = mkDoc ''
        Italic font bold
      '';
    };
  };

  config = mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      installBatSyntax = true;
      installVimSyntax = true;

      settings = {
        gtk-titlebar = false;
        inherit font-size;
        inherit (cfg) theme font-family font-family-bold font-family-italic font-family-bold-italic;
        shell-integration = "zsh";
        mouse-hide-while-typing = true;
        window-save-state = "always";
        cursor-style-blink = false;
        font-thicken = false;
        shell-integration-features = "no-cursor";
        adjust-cursor-thickness = "1";
        window-decoration = false;
        cursor-style = "block";
        confirm-close-surface = false;
        window-theme = "dark";
        window-padding-x = 2;
        window-padding-y = 2;
        window-padding-balance = true;
        window-padding-color = "extend";
        resize-overlay = "never";
        # background-opacity = 0.9;
        # background-blur = true;

        app-notifications = [
          ''
            no-clipboard-copy
          ''
        ];
        keybind = [
          ''
            ctrl+alt+v=paste_from_clipboard
          ''
        ];
      };
    };
  };
}
