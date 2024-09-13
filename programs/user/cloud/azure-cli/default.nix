{ lib
, config
, ...
}:

with lib;
let cfg = config.modules.azure-cli;
in
{
  options.modules.azure-cli = { enable = mkEnableOption "azure-cli"; };

  config = mkIf cfg.enable (
    let
      inherit (lib) isDerivation;
      inherit (builtins) filter attrValues;
      azure-cli = pkgs.azure-cli.withExtensions (filter (item: isDerivation item) (attrValues pkgs.azure-cli-extensions));
    in
    {
      home.packages = [ azure-cli ];
    }
  );
}
