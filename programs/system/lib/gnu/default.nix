{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.lib.gnu;
in
{
  options.modules.lib.gnu = { enable = mkEnableOption "gnu"; };

  config = mkIf cfg.enable {
    # NOTE: Should probabbly remove this part
    environment.systemPackages = with pkgs; [
      groff
      # gnutar
      # gcc
      glibc
      gdb
      libgccjit
      gnupatch
      binutils
    ];
  };
}
