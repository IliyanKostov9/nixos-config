{ pkgs, lib, config, ... }:
with lib;
with lib.types;

let
  cfg = config.modules.dev.emulator.ghostty;
  font-size = if builtins.match "desktop" (builtins.getEnv "DEVICE") != null then 12 else 8;
  font-name = config.modules.preferences.fonts.name;
in
{
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
      default = "gruvbox_material_hard_dark";
      description = mkDoc ''
        color scheme for ghostty
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
        font-size = font-size;
        theme = cfg.theme;
        command = "zsh";
        mouse-hide-while-typing = true;
        window-save-state = "always";
        cursor-style-blink = false;
        font-thicken = false;
        shell-integration-features = "no-cursor";
        # font-feature = [ "-calt" "-liga" "-dlig" ];
        adjust-cursor-thickness = "1";
        window-decoration = false;
        cursor-style = "block";
        # font-feature = "+liga";
        # window-padding-x = 8;
        # window-padding-y = 8;
        font-family = "0xProto Nerd Font";
        confirm-close-surface = false;
        window-theme = "dark";
        window-padding-x = 2;
        window-padding-y = 2;
        window-padding-balance = true;
        window-padding-color = "extend";
      };
    };
  };
}

