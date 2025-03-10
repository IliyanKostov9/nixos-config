{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.cloud.azure-cli;
in {
  options.modules.cloud.azure-cli = {enable = mkEnableOption "azure-cli";};

  config =
    mkIf cfg.enable
    {
      home.packages = with pkgs; [azure-cli];
    };
}
