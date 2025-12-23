{
  lib,
  config,
  ...
}:
with lib;
with lib.types; let
  cfg = config.modules.dev.emulator.ghostty;
  inherit (config.modules.preferences) fonts;
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
        font-size = fonts.size;
        inherit (cfg) theme;
        font-family = fonts.family;
        font-family-bold = fonts.family-bold;
        font-family-italic = fonts.family-italic;
        font-family-bold-italic = fonts.family-bold-italic;

        shell-integration = "zsh";
        mouse-hide-while-typing = true;
        shell-integration-features = "no-cursor";
        adjust-cursor-thickness = "1";
        cursor-style = "block";
        cursor-style-blink = false;
        window-save-state = "always";
        font-thicken = false;
        window-decoration = false;
        confirm-close-surface = false;
        window-theme = "dark";
        window-padding-balance = true;
        window-padding-color = "extend";
        resize-overlay = "never";
        resize-overlay-position = "center";
        resize-overlay-duration = "0s";
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
