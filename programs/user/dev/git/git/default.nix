{
  lib,
  config,
  user,
  ...
}:
with lib;
with lib.types; let
  cfg = config.modules.dev.git.git;
in {
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

    shouldGPGSign = mkOption {
      type = bool;
      default = false;
      description = mkDoc ''
        Sign git commits via GPG
      '';
    };
    gpgKey = mkOption {
      type = str;
      default = "";
      description = mkDoc ''
        KEY ID of GPG key to sign
      '';
    };
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      inherit (cfg) userName userEmail;
      lfs.enable = false;
      ignores = [
        "*~"
        "*.swp"
      ];
      signing = {
        signByDefault = cfg.shouldGPGSign;
        key = cfg.gpgKey;
      };

      extraConfig = {
        lfs.allowincompletepush = true;
        filter.lfs.required = false;
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
