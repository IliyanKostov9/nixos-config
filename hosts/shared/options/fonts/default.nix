{ config, lib, pkgs, ... }:
{
  # Enable nerd fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "0xProto" ]; })
  ];
}
