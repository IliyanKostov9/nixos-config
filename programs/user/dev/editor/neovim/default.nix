{ pkgs_unstable
, lib
, ...
}:
{
 home.packages = with pkgs_unstable; [ neovim ];
}
