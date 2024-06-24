{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ librewolf ];
  programs.librewolf.enable = true;
}
