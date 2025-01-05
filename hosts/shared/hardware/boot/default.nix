{ lib, pkgs_unstable, modulesPath, host_attr, ... }:

with host_attr;
with lib;
with lib.trivial;
let
  is-secure-boot-enabled =
    if builtins.pathExists "/etc/secureboot" && !inPureEvalMode then
      trace "> Secure boot IS enabled!" true else if inPureEvalMode then warn "> Secure boot CANNOT be enabled. You are currently running in pure eval mode. Try using --impure to enable secure boot!" false else warn "> Secure boot is NOT enabled" false;
in
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  boot = boot // {
    kernelPackages = pkgs_unstable.linuxPackages_6_12;
    loader = {
      # Note: is-secure-boot-enabled value is reverted, since system boot expects to be true when secure boot is disabled and vice versa
      systemd-boot.enable = !is-secure-boot-enabled;
      efi.canTouchEfiVariables = true;
    };
  } // (if is-secure-boot-enabled then {
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
  } else { });
}
