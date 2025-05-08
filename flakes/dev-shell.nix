{inputs, ...}: {
  perSystem = {
    config,
    self',
    inputs',
    pkgs,
    system,
    lib,
    ...
  }: {
    devenv.shells.default = {
      name = "NixOS devenv";
      git-hooks.hooks = {
        actionlint.enable = true;
        beautysh.enable = true;
        commitizen.enable = true;
        black.enable = true;

        flake-checker.enable = true;
        # lychee.enable = true;
      };

      packages = with pkgs; [
        sops
      ];
    };
  };
}
