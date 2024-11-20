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

  config = mkIf cfg.enable (
    let
      # inherit (builtins) filter attrValues;
      # azure-cli = pkgs.azure-cli.withExtensions (filter lib.isDerivation (attrValues pkgs.azure-cli-extensions));
    in
    {
      home.packages = with pkgs; [ azure-cli ];
    }
  );
}
