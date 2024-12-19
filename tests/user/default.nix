let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.11";
  pkgs = import nixpkgs { config = { }; overlays = [ ]; };
in

pkgs.testers.runNixOSTest {
  name = "User tests";

  nodes.machine = { config, pkgs, ... }: {

    users.users.ikostov2 = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      packages = with pkgs; [
        librewolf
      ];
    };

    system.stateVersion = "24.11";
  };

  testScript = ''
    machine.wait_for_unit("default.target")
    machine.succeed("su -- ikostov2 -c 'which librewolf'")
    machine.fail("su -- root -c 'which librewolf'")
  '';
}
