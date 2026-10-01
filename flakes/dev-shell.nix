_: {
  perSystem = {pkgs, ...}: {
    devenv.shells.default = {
      name = "NixOS devenv";
      cachix.pull = ["iliyankostov9-nixos-config"];

      git-hooks.hooks = {
        actionlint.enable = true;
        beautysh.enable = true;
        commitizen.enable = true;
        flake-checker.enable = false;
        lychee.enable = false;
      };

      packages = with pkgs; [
        sops
      ];
    };
  };
}
