{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.dev.git.gh;
in {
  options.modules.dev.git.gh = {enable = mkEnableOption "gh";};

  config = mkIf cfg.enable {
    programs.gh = {
      enable = true;
      extensions = with pkgs; [
        gh-stack
      ];
      settings = {
        git_protocol = "ssh";
        prompt = "enabled";
      };
    };
  };
}
