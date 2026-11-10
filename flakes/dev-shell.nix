{lib, ...}: {
  perSystem = {pkgs, ...}: {
    devenv.shells.default = {
      name = "NixOS devenv";
      devenv.root = "/etc/nixos";
      containers = lib.mkForce {};

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
