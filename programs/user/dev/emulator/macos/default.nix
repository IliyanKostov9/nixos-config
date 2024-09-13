{ pkgs, ... }:
{
  home.packages = with pkgs; [
    darling
  ];
}
