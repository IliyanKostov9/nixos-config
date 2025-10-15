{nixos-hardware}: {
  users = {
    iliyan = {
      isNormalUser = true;
      createHome = true;
      description = "Iliyan's profile";
      extraGroups = ["libvirtd" "adbusers" "kvm" "docker" "users" "networkmanager" "wheel" "tss" "video"];
      initialHashedPassword = "$6$5GT0G5I0F1wAfwuu$Nt6BgjM45KYxrKJKzuMcgwgl/sE5eoem7q3tT386BVZMkUu/0iuqT.4vfj6o/TaTEOQEs.QbjEhSEgKyBNhYN0";
    };

    # garming = {
    #   createHome = true;
    #   isNormalUser = true;
    #   description = "Garming profile";
    #   extraGroups = ["libvirtd" "users" "networkmanager" "wheel" "tss"];
    #   initialHashedPassword = "$6$cXDCwAyOy2iqBKiW$ZtrH9HI7063o2DMLTc3jm8/Ecrv5wPWUszFUEBg15AtwBIQvuE.Eg5Vo/Qlrg7kwXaBLRIPPGX7EOV8raJWrV.";
    # };
  };

  hosts = {
    MSI-A320M-PRO = {
      variables = {
        DEVICE = "desktop";
        MODEL = "MSI-A320M-PRO";
      };
      modules = [
        ./hosts/msi-a320m-pro
        nixos-hardware.nixosModules.msi-b350-tomahawk
      ];

      boot = {
        kernelModules = ["kvm-amd" "k10temp"];
        kernelParams = ["acpi_enforce_resources=lax" "transparent_hugepage=never" "nvidia-drm.fbdev=1"];
        initrd = {
          # NOTE: For some reason it's unable to boot when moved to boot nix module as common attr set
          availableKernelModules = ["xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sr_mod"];
          luks = {
            devices."luks-401c9fe6-6316-449a-8a50-2e46ac3a5401".device = "/dev/disk/by-uuid/401c9fe6-6316-449a-8a50-2e46ac3a5401";
            devices."luks-2d79801c-f1b7-4300-b4db-b9eff4b0f110".device = "/dev/disk/by-uuid/2d79801c-f1b7-4300-b4db-b9eff4b0f110";
          };
        };
      };
    };

    Lenovo-Thinkpad-p53 = {
      variables = {
        DEVICE = "laptop";
        MODEL = "Lenovo-Thinkpad-p53";
      };
      modules = [
        ./hosts/lenovo-thinkpad-p53
        nixos-hardware.nixosModules.lenovo-thinkpad-p53
      ];

      boot = {
        kernelModules = ["kvm-intel"];
        kernelParams = ["i915.force_probe=3e9b" "nvidia-drm.fbdev=1"];
        initrd = {
          availableKernelModules = ["xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sr_mod"];
          luks = {
            devices."luks-98c6023d-534b-436b-b8c6-151500769ae9".device = "/dev/disk/by-uuid/98c6023d-534b-436b-b8c6-151500769ae9";
            devices."luks-af43f1f4-e396-4104-af8d-ab8ee1721612".device = "/dev/disk/by-uuid/af43f1f4-e396-4104-af8d-ab8ee1721612";
          };
        };
      };
    };

    Lenovo-IdeaPad-Pro5 = {
      variables = {
        DEVICE = "laptop";
        MODEL = "Lenovo-IdeaPad-Pro5";
      };
      modules = [
        ./hosts/lenovo-ideapad-pro5
        nixos-hardware.nixosModules.common-cpu-intel
        nixos-hardware.nixosModules.common-gpu-intel
        nixos-hardware.nixosModules.common-pc-laptop-ssd
        nixos-hardware.nixosModules.common-pc-laptop
      ];

      boot = {
        kernelModules = ["kvm-intel"];
        kernelParams = ["i915.force_probe=3e9b"];
        initrd = {
          availableKernelModules = ["xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sr_mod"];
          luks = {
            devices."luks-98c6023d-534b-436b-b8c6-151500769ae9".device = "/dev/disk/by-uuid/98c6023d-534b-436b-b8c6-151500769ae9";
            devices."luks-af43f1f4-e396-4104-af8d-ab8ee1721612".device = "/dev/disk/by-uuid/af43f1f4-e396-4104-af8d-ab8ee1721612";
          };
        };
      };
    };

    Lenovo-Legion-16ahp9 = {
      variables = {
        DEVICE = "laptop";
        MODEL = "Lenovo-Legion-16ahp9";
      };
      modules = [
        ./hosts/lenovo-legion-16ahp9
        nixos-hardware.nixosModules.lenovo-legion-16aph8
      ];

      boot = {
        kernelModules = [
          "kvm-amd"
          "k10temp"
        ];
        kernelParams = [
          "acpi_enforce_resources=lax"
          "transparent_hugepage=never"
          "nvidia-drm.fbdev=1"
          "nvidia-drm.modeset=1"
        ];
        initrd = {
          availableKernelModules = ["xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sr_mod"];
          systemd.enable = true;
          luks = {
            devices = {
              root = {
                device = "/dev/nvme0n1p2";
                bypassWorkqueues = true;
              };
            };
          };
        };
      };
    };
  };
}
