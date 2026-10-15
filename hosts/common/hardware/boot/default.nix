{
  lib,
  pkgs,
  config,
  modulesPath,
  host_attr,
  ...
}:
with lib;
with lib.trivial; let
  is-secure-boot-enabled =
    if builtins.pathExists "/etc/secureboot" && !inPureEvalMode
    then trace "> Secure boot IS enabled!" true
    else if inPureEvalMode
    then warn "> Secure boot CANNOT be enabled. You are currently running in pure eval mode. Try using --impure to enable secure boot!" false
    else warn "> Secure boot is NOT enabled" false;
  cfg = config.modules.hardware.boot;
  gpu = host_attr.gpu or "";
in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  options.modules.hardware.boot = {
    kernel = mkOption {
      type = types.str;
      default = "latest";
      description = mkDoc ''
        Version of linux kernel
      '';
    };
  };

  config = {
    assertions = [
      {
        assertion = cfg.kernel == "latest" || builtins.match "[0-9]_[0-9]" cfg.kernel != null;
        message = "Linux kernel is incorrect! The available values are either latest or with kernel version X_X";
      }
    ];

    boot = mkMerge [
      host_attr.boot
      {
        kernelPackages = pkgs."linuxPackages_${cfg.kernel}";
        kernelModules =
          if host_attr.cpu == "amd"
          then [
            "kvm-amd"
            "k10temp"
          ]
          else if host_attr.cpu == "intel"
          then [
            "kvm-intel"
          ]
          else [];
        kernelParams =
          [
            "acpi_enforce_resources=lax"
            "transparent_hugepage=never"
            "rd.systemd.show_status=auto"
          ]
          ++ optional (host_attr.cpu == "amd") "amd_pstate=active"
          ++ optional (gpu == "intel") "i915.force_probe=3e9b"
          ++ optional (gpu
            == "nvidia"
            || (host_attr.dgpu or null) == "nvidia") "nvidia-drm.fbdev=1";
        tmp.useTmpfs = true;
        plymouth.enable = true;
        initrd = {
          availableKernelModules = ["xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sr_mod"];
          kernelModules =
            optional (gpu == "amd") "amdgpu"
            ++ optional (gpu == "intel") "i915"
            ++ optionals (gpu
              == "nvidia"
              || (host_attr.dgpu or null)
              == "nvidia") [
              "nvidia"
              "nvidia_modeset"
              "nvidia_drm"
            ];
        };
        loader = {
          # NOTE: is-secure-boot-enabled value is reverted, since system boot expects to be true when secure boot is disabled and vice versa
          systemd-boot.enable = !is-secure-boot-enabled;
          efi.canTouchEfiVariables = true;
          timeout = 10;
          grub.timeoutStyle = "countdown";
        };
      }
      (optionalAttrs is-secure-boot-enabled
        {
          lanzaboote = {
            enable = true;
            pkiBundle = "/etc/secureboot";
            configurationLimit = 5;
          };
        })
    ];
  };
}
