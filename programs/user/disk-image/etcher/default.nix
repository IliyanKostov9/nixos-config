{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.etcher;
in
{
  options.modules.etcher = { enable = mkEnableOption "etcher"; };

  config = mkIf cfg.enable {
    programs.zsh.shellAliases = programs.zsh.shellAliases // { etcher = "/etc/nixos/programs/user/disk-image/etcher/result/bin/etcher"; };
  };

}
