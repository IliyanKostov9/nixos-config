{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.git;
in
{
  options.modules.git = { enable = mkEnableOption "git"; };

  config = mkIf cfg.enable {

    userName = mkOption {
      type = string;
      default = "john-doe";
    };
    userEmail = mkOption {
      type = string;
      default = "john.doe@mail.com";
    };


    programs.git = {
      enable = true;
      # userName = "iliyan-kostov";
      # userEmail = "iliyan.kostov@email.ikostov.org";
      inherit userName UserEmail;
      lfs.enable = false;

      extraConfig = {
        diff.colorMoved = "default";
        pull.rebase = false;
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
