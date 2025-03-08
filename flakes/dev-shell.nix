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
    devenv.shells.default =
      if !(lib.trivial.inPureEvalMode)
      then {
        name = "NixOS devenv";
        git-hooks.hooks = {
          actionlint.enable = true;
          checkmake.enable = true;
          beautysh.enable = true;
          commitizen.enable = true;
          flake-checker.enable = true;
        };
      }
      else {};
  };
}
