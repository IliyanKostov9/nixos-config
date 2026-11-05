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
in {
  options.modules.dev.emulator.tmux = {
    enable = mkOption {
      type = bool;
      default = false;
      description = mkDoc ''
        Enable tmux terminal multiplexer
      '';
    };
  };

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      plugins = with pkgs.tmuxPlugins; [
        resurrect
        sensible
        yank
        open
      ];
      extraConfig = lib.fileContents ./tmux.conf;
      clock24 = true;
      baseIndex = 1;
      mouse = true;
    };
  };
}
