{inputs, ...}: {
  perSystem = {
    config,
    self',
    inputs',
    pkgs,
    system,
    ...
  }: {
    devenv.shells.default = {
      name = "NixOS devenv";
      git-hooks.hooks = {
        actionlint.enable = true;
        checkmake.enable = true;
        beautysh.enable = true;
        commitizen.enable = true;
        flake-checker.enable = true;
      };

      devenv.root = let
        devenvRootFileContent = builtins.readFile inputs.devenv-root.outPath;
      in
        pkgs.lib.mkIf (devenvRootFileContent != "") devenvRootFileContent;
    };
  };
}
