{ home-manager
, shared
, pkgs
}:

let
  stateVersion = "24.11";
in
pkgs.nixosTest {
  name = "User tests";
  # extraPythonPackages = p: [ p.numpy ];
  nodes.machine = { config, pkgs, ... }: {
    imports = [
      (import "${home-manager}/nixos")
    ];
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    services.xserver.windowManager.i3.enable = true;
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

      garming = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
      };
    };
    home-manager = builtins.listToAttrs
      (lib.attrsets.mapAttrsToList
        builtins.mapAttrs
        (user: _user-attr: {
          extraSpecialArgs =
            {
              inherit self user;
              inherit (shared) system stateVersion pkgs_unstable;
            };
          modules = [
            ../../home
          ];
        })
        shared.users);

    home-manager.users = {
      ikostov2 = {
        home = {
          packages = with pkgs; [
            librewolf
          ];
          inherit stateVersion;
        };
      };

      garming = {
        home = {
          packages = with pkgs; [
            librewolf
          ];
          inherit stateVersion;
        };
      };
    };
  };

  testScript = ''
    machine.wait_for_unit("default.target")
    machine.succeed("su -- ikostov2 -c 'which librewolf'")
    machine.fail("su -- root -c 'which librewolf'")
  '';
}
