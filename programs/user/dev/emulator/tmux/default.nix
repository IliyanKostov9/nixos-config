{ pkgs, lib, config, ... }:
with lib;
with lib.types;
let
  cfg = config.modules.dev.emulator.tmux;
  convert-list-to-lowercase = list: (builtins.map (name: lib.strings.toLower name) list);
in
{
  options.modules.dev.emulator.tmux = {

    enable = mkOption {
      type = bool;
      default = false;
      description = mkDoc ''
        Enable tmux terminal multiplexer
      '';
    };

    enable-dynamic-conf = mkOption {
      type = bool;
      default = false;
      description = mkDoc ''
        Should it dynamically replace string values in tmux.conf
      '';
    };

    static-vals = mkOption {
      type = listOf str;
      description = mkDoc ''
        The static values to be replaced in tmux.conf
      '';
    };

    dynamic-vals = mkOption {
      type = listOf str;
      description = mkDoc ''
        The dynamic values to be placed in tmux.conf
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.tmux
    ];

    programs.tmux =
      let
        tmux-conf =
          if cfg.enable-dynamic-conf then
            builtins.replaceStrings cfg.static-vals (convert-list-to-lowercase cfg.dynamic-vals) (lib.fileContents ./tmux.conf)
          else lib.fileContents ./tmux.conf
        ;
      in
      {
        enable = true;
        plugins = with pkgs.tmuxPlugins; [
          resurrect
          sensible
          yank
          open
        ];
        extraConfig = tmux-conf;
        clock24 = true;
        baseIndex = 1;
        mouse = true;
      };
  };

}

