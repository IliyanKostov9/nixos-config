{ config, lib, pkgs, ... }:

{
  security.rtkit.enable = true;
  services.openssh.enable = true;
}
