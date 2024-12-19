{ home-manager
, shared
, lib
}:
with shared;

pkgs.nixosTest {
  name = "User tests";
  # extraPythonPackages = p: [ p.numpy ];
  nodes.user1 = { config, pkgs, ... }: {
    imports = [
      (import "${home-manager}/nixos")
    ];

    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    services = {
      displayManager.sddm.enable = true;
      xserver = {
        enable = true;
        desktopManager.gnome.enable = true;
        windowManager.i3.enable = true;
      };
    };

    system = {
      inherit stateVersion;
    };

    users.users = {
      ikostov2 = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        # packages = with pkgs; [
        # ];
      };
    };

    home-manager =
      {
        users = {
          ikostov2 = import ../../home;
        };
        extraSpecialArgs =
          {
            user = "ikostov2";
            inherit system stateVersion pkgs pkgs_unstable;
          };
      };
  };

  nodes.user2 = { config, pkgs, ... }: {
    imports = [
      (import "${home-manager}/nixos")
    ];
    services.xserver.desktopManager.gnome.enable = true;
    system = {
      inherit stateVersion;
    };

    users.users = {
      dummy = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
      };
    };

    home-manager =
      {
        users = {
          dummy = import ../../home;
        };
        extraSpecialArgs =
          {
            user = "dummy";
            inherit system stateVersion pkgs pkgs_unstable;
          };
      };
  };

  testScript = ''
    user1.wait_for_unit("default.target")
    user1.succeed("su -- ikostov2 -c 'which librewolf'")

    user2.wait_for_unit("default.target")
    user2.fail("su -- dummy -c 'which vim'")
    user2.fail("su -- root -c 'which emacs'")
  '';
}
