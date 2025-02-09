{ lib, config, user, ... }:
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
      description = mkDoc ''
        Username for git
      '';
    };
    userEmail = mkOption {
      type = str;
      default = "john.doe@mail.com";
      description = mkDoc ''
        Email for git
      '';
    };
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      inherit (cfg) userName userEmail;
      lfs.enable = false;
      signing = {
        signByDefault = true;
        key = "6105AB13B9DCDD1B";
      };

      extraConfig = {
        diff.colorMoved = true;
        pull.rebase = false;
        push.autoSetupRemote = true;
        safe.directory = "/etc/nixos";
        init.defaultBranch = "master";
        core = {
          hooksPath = "/home/${user}/.git/hooks";
          editor = "nvim";
        };
      };
    };
  };

}
