{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.postman;
in
{
  options.modules.postman = { enable = mkEnableOption "postman"; };
  # options.modules.docker = {
  #   enable = mkOption {
  #     type = bool;
  #     default = false;
  #   };
  # };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.postman
    ];
  };

}
