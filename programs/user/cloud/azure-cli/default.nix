{ lib
, pkgs
, ...
}:

let
  inherit (lib) isDerivation;
  inherit (builtins) filter attrValues;
  azure-cli = pkgs.azure-cli.withExtensions (filter (item: isDerivation item) (attrValues pkgs.azure-cli-extensions));
in
{
  home.packages = [ azure-cli ];
}
