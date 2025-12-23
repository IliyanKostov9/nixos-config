{
  lib,
  ...
}:
with lib;
with lib.types; {
  options.modules.preferences.fonts = {
    name = mkOption {
      type = str;
      default = "0xProto";
      description = lib.mkDoc ''
        Nerd font for the terminal and apps
      '';
    };

    # NOTE: Don't set this option!
    # TODO: Make this option not configurable
    size = mkOption {
      type = int;
      default =
        if builtins.match "desktop" (builtins.getEnv "DEVICE") != null
        then 12
        else 12;
      description = lib.mkDoc ''
        Font size
      '';
    };

    family = mkOption {
      type = str;
      default = "0xProto Nerd Font";
      description = mkDoc ''
        Font family
      '';
    };

    family-bold = mkOption {
      type = str;
      default = "0xProto Nerd Font Mono";
      description = mkDoc ''
        Bold font family
      '';
    };

    family-italic = mkOption {
      type = str;
      default = "DejaVu Serif, Regular Italic";
      description = mkDoc ''
        Italic font
      '';
    };

    family-bold-italic = mkOption {
      type = str;
      default = "DejaVu Serif, Regular Italic";
      description = mkDoc ''
        Italic font bold
      '';
    };
  };

  config = {
    fonts.fontconfig.enable = true;
  };
}
