{ config, lib, pkgs, ... }:

{
  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = false;
  services.displayManager.autoLogin.user = "ikostov2";
}
