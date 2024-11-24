{ pkgs, lib, config, user, ... }:
with lib;
with lib.types;

let cfg = config.modules.dev.git.git;
in
{
  options.modules.dev.git.git = {
    enable = mkEnableOption "git";

    userName = mkOption {
      type = str;
      default = "john-doe";
      description = lib.mkDoc ''
        Username for git
      '';
    };
    userEmail = mkOption {
      type = str;
      default = "john.doe@mail.com";
      description = lib.mkDoc ''
        Email for git
      '';
    };
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      inherit (cfg) userName userEmail;
      lfs.enable = false;

      extraConfig = {
        diff.colorMoved = true;
        pull.rebase = false;
        push.autoSetupRemote = true;
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
