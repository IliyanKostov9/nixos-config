_: {
  flake.perSystem = { inputs', pkgs, ... }: {
    flake.devenv.shells.default = {
      name = "Nix devenv";
      languages.ansible.enable = true;
      git-hooks.hooks = {
        # Common
        markdownlint.enable = true;
        actionlint.enable = true;
        checkmake.enable = true;
        prettier.enable = true;

        # Nix
        statix.enable = true;
      };
      flake.devenv.root =
        let
          devenvRootFileContent = builtins.readFile inputs'.devenv-root.outPath;
        in
        pkgs.lib.mkIf (devenvRootFileContent != "") devenvRootFileContent;
    };
  };
}
