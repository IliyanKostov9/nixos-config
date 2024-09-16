{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.fzf;
in
{
  options.modules.fzf = { enable = mkEnableOption "fzf"; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      fzf
      ripgrep
      fd
      tldr
    ];
  };

}

