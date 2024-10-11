{ nixos-hardware }:

{
  users = {
    ikostov2 = {
      isNormalUser = true;
      description = "ikostov2 profile";
      extraGroups = [ "libvirtd" "adbusers" "kvm" "docker" "users" "networkmanager" "wheel" "ikostov2" ];
    };

    gm = {
      isNormalUser = true;
      description = "Garming profile";
      extraGroups = [ "libvirtd" "adbusers" "kvm" "docker" "users" "networkmanager" "wheel" "garming" ];
    };
  };

  hosts = {
    hosts-personal-desktop = {
      host-name = "baks";
      auto-login-user = "ikostov2";
      modules = [
        ./hosts/personal/desktop
        nixos-hardware.nixosModules.common-pc
        nixos-hardware.nixosModules.common-cpu-amd
      ];

      boot = {
        kernelModules = [ "kvm-amd" ];
        kernelParams = [ "nvidia-drm.fbdev=1" ];
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };
        initrd = {
          luks.devices."luks-401c9fe6-6316-449a-8a50-2e46ac3a5401".device = "/dev/disk/by-uuid/401c9fe6-6316-449a-8a50-2e46ac3a5401";
          luks.devices."luks-2d79801c-f1b7-4300-b4db-b9eff4b0f110".device = "/dev/disk/by-uuid/2d79801c-f1b7-4300-b4db-b9eff4b0f110";
          availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];
        };
      };
    };

    hosts-work-laptop = {
      host-name = "baks";
      auto-login-user = "ikostov2";
      modules = [
        ./hosts/work/laptop
        nixos-hardware.nixosModules.lenovo-thinkpad-p53
      ];

      boot = {
        kernelModules = [ "kvm-intel" ];
        # Intel Graphics
        kernelParams = [ "i915.force_probe=3e9b" "nvidia-drm.fbdev=1" ];
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };
        initrd = {
          luks.devices."luks-98c6023d-534b-436b-b8c6-151500769ae9".device = "/dev/disk/by-uuid/98c6023d-534b-436b-b8c6-151500769ae9";
          luks.devices."luks-af43f1f4-e396-4104-af8d-ab8ee1721612".device = "/dev/disk/by-uuid/af43f1f4-e396-4104-af8d-ab8ee1721612";
          availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];
        };
      };
    };
  };
}
