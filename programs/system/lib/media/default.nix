{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.lib.media;
in
{
  options.modules.lib.media = { enable = mkEnableOption "media"; };

  config = mkIf cfg.enable {
    # NOTE: Should probabbly remove this part
    environment.systemPackages = with pkgs; [
      ffmpeg
    ];
  };
}
