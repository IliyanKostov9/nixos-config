{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [
    azure-cli
    azure-cli-extensions.azure-devops
  ];
}
