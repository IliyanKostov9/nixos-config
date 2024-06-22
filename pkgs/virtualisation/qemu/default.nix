{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ qemu ];
}
