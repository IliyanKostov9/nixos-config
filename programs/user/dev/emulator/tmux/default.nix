{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.dev.emulator.tmux;
  tmux-conf = builtins.replaceStrings [ "$Work*" "$Work_Project1*" ] [ config.globals.work_name config.globals.work_project1_name ] (lib.fileContents ./tmux.conf);
in
{
  options.modules.dev.emulator.tmux = { enable = mkEnableOption "tmux"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.tmux
    ];

    programs.tmux = {
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

