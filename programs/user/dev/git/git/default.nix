{ pkgs, lib, config, user, ... }:
with lib;
with lib.types;

let cfg = config.modules.git;
in
{
  options.modules.git = {
    enable = mkEnableOption "git";

    userName = mkOption {
      type = str;
      default = "john-doe";
    };
    userEmail = mkOption {
      type = str;
      default = "john.doe@mail.com";
    };
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      inherit (cfg) userName userEmail;
      lfs.enable = false;

      extraConfig = {
        diff.colorMoved = "default";
        pull.rebase = false;
        core.hooksPath = "/home/${user}/.git/hooks";
        init = {
          defaultBranch = "master";
        };
        core = {
          editor = "nvim";
        };
      };
    };
  };

}
