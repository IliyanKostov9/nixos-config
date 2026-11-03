{
  home-manager,
  shared,
}:
with shared;
  pkgs.testers.nixosTest {
    name = "User tests";
    # extraPythonPackages = p: [ p.numpy ];
    nodes.user1 = {pkgs, ...}: {
      imports = [
        (import "${home-manager}/nixos")
      ];
      system.stateVersion = stateVersion;

      boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      services = {
        displayManager.sddm.enable = true;
        desktopManager.gnome.enable = true;
        xserver = {
          enable = true;
          windowManager.i3.enable = true;
        };
      };

      nix.settings.system-features = ["kvm"];
      users.users = {
        dummy = {
          isNormalUser = true;
          extraGroups = ["wheel" "kvm"];
          # packages = with pkgs; [
          # ];
        };
      };

      home-manager = {
        users = {
          dummy = import ../../home;
        };
        extraSpecialArgs = {
          user = "dummy";
          inherit stateVersion pkgs pkgs-unstable;
        };
      };
    };

    nodes.user2 = {pkgs, ...}: {
      imports = [
        (import "${home-manager}/nixos")
      ];
      system.stateVersion = stateVersion;

      services.desktopManager.gnome.enable = true;
      nix.settings.system-features = ["kvm"];
      users.users = {
        fakeuser = {
          isNormalUser = true;
          extraGroups = ["wheel" "kvm"];
        };
      };

      home-manager = {
        users = {
          fakeuser = import ../../home;
        };
        extraSpecialArgs = {
          user = "fakeuser";
          inherit stateVersion pkgs pkgs-unstable;
        };
      };
    };

    testScript = ''
      user1.wait_for_unit("default.target")
      user1.succeed("su -- dummy -c 'which librewolf'")

      user2.wait_for_unit("default.target")
      user2.fail("su -- fakeuser -c 'which vim'")
      user2.fail("su -- root -c 'which emacs'")
    '';
  }
