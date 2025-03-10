{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with lib.types; let
  cfg = config.modules.dev.emulator.tmux;
  cfg-alacritty = config.modules.dev.emulator.alacritty;

  inherit (import ../../../../../utils/get-current-time.nix {inherit pkgs lib;}) hour;
  status-bar-color =
    if cfg-alacritty.scheduled
    then
      (
        if hour > cfg-alacritty.start-hour && hour < cfg-alacritty.end-hour
        then cfg-alacritty.light-theme-hex
        else cfg-alacritty.dark-theme-hex
      )
    else trace "> Scheduled is not enabled. Defaulting to dark theme status bar for tmux..." cfg-alacritty.dark-theme-hex;

  convert-list-to-lowercase = list: (builtins.map (name: lib.strings.toLower name) list);
in {
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

    programs.tmux = let
      dynamic-vals = cfg.dynamic-vals ++ [status-bar-color];
      static-vals = cfg.static-vals ++ ["$STATUS_BAR_BG_THEME*"];

      tmux-conf =
        if cfg.enable-dynamic-conf
        then builtins.replaceStrings static-vals (convert-list-to-lowercase dynamic-vals) (lib.fileContents ./tmux.conf)
        else lib.fileContents ./tmux.conf;
    in {
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
