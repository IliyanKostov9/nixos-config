{ lib
, config
, pkgs
, ...
}:

with lib;
let cfg = config.modules.azure-cli;
in
{
  options.modules.azure-cli = { enable = mkEnableOption "azure-cli"; };

  config = mkIf cfg.enable
    {
      home.packages = with pkgs; [ azure-cli ];
    };
}
