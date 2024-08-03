{
  users = {
    ikostov2 = {
      isNormalUser = true;
      description = "ikostov2 profile";
      extraGroups = [ "libvirtd" "adbusers" "kvm" "docker" "users" "networkmanager" "wheel" ];
      shell = "zsh";
    };
  };

  hosts = [
    {
      personal-desktop = {

        swapDevices =
          [{ device = "/dev/disk/by-uuid/85b811ca-f0aa-452e-a679-549dcf80e1ba"; }];

        boot = {
          kernelModules = [ "kvm-amd" ];
          extraModulePackages = [ ];
          loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
          };
        };
        initrd = {
          luks.devices."luks-401c9fe6-6316-449a-8a50-2e46ac3a5401".device = "/dev/disk/by-uuid/401c9fe6-6316-449a-8a50-2e46ac3a5401";
          luks.devices."luks-2d79801c-f1b7-4300-b4db-b9eff4b0f110".device = "/dev/disk/by-uuid/2d79801c-f1b7-4300-b4db-b9eff4b0f110";
          availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];
          kernelModules = [ ];

        };
      };

      work-laptop = {

        swapDevices =
          [{ device = "/dev/disk/by-uuid/2ae616fa-be73-4075-be15-72f4fb245205"; }];

        boot = {
          kernelModules = [ "kvm-intel" ];
          extraModulePackages = [ ];
          # Intel Graphics
          kernelParams = [ "i915.force_probe=3e9b" ];
          loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
          };
        };
        initrd = {
          luks.devices."luks-98c6023d-534b-436b-b8c6-151500769ae9".device = "/dev/disk/by-uuid/98c6023d-534b-436b-b8c6-151500769ae9";
          luks.devices."luks-af43f1f4-e396-4104-af8d-ab8ee1721612".device = "/dev/disk/by-uuid/af43f1f4-e396-4104-af8d-ab8ee1721612";

          availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];
          kernelModules = [ ];

        };
      };
    }
  ];
}
