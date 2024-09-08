{ nixos-hardware }:

{
  users = {

    ikostov2 = {
      isNormalUser = true;
      description = "ikostov2 profile";
      extraGroups = [ "libvirtd" "adbusers" "kvm" "docker" "users" "networkmanager" "wheel" ];
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
        # nixos-hardware.nixosModules.common-gpu-nvidia
      ];

      swapDevices =
        [{ device = "/dev/disk/by-uuid/85b811ca-f0aa-452e-a679-549dcf80e1ba"; }];

      boot = {
        kernelModules = [ "kvm-amd" ];
        kernelParams = [ "nvidia-drm.fbdev=1" ];
        extraModulePackages = [ ];
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

      fileSystems = {
        "/" =
          {
            device = "/dev/disk/by-uuid/71627bb4-1f3d-4b0c-9b74-aef3944e9eae";
            fsType = "ext4";
          };
        # Mount the hard disk
        "/mnt/external_hd" = {
          device = "/dev/sda1";
          fsType = "ntfs";
          options = [ "users" "nofail" "rw" ];
        };
        "/boot" =
          {
            device = "/dev/disk/by-uuid/BB8A-DF92";
            fsType = "vfat";
            options = [ "fmask=0022" "dmask=0022" ];
          };
      };
    };

    hosts-work-laptop = {
      host-name = "baks";
      auto-login-user = "ikostov2";
      modules = [
        ./hosts/work/laptop
        # nixos-hardware.nixosModules.lenovo-thinkpad-p53
      ];

      swapDevices =
        [{ device = "/dev/disk/by-uuid/2ae616fa-be73-4075-be15-72f4fb245205"; }];

      boot = {
        kernelModules = [ "kvm-intel" ];
        extraModulePackages = [ ];
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
          kernelModules = [ ];

        };
      };
      # fileSystems."/".device = mkDefault "/dev/disk/by-label/nixos";

      fileSystems = {
        "/" =
          {
            device = "/dev/disk/by-uuid/1389313b-f022-47fa-b319-86f679186c5c";
            fsType = "ext4";
          };
        "/boot" =
          {
            device = "/dev/disk/by-uuid/E602-D2C4";
            fsType = "vfat";
            options = [ "fmask=0022" "dmask=0022" ];
          };
      };
    };
  };
}
