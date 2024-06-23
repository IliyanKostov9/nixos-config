{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ virt-manager ];
}
