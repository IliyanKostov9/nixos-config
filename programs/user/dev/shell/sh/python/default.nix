{
  pkgs,
  lib,
  ...
}:
with lib; let
  py-nix-sh =
    pkgs.writeShellApplication
    {
      name = "py-nix-sh";
      runtimeInputs = [pkgs.python3];

      text = ''
        nix-shell ${../bin/nix/python/shell.nix}
      '';
    };
in {
  home.packages = [
    py-nix-sh
  ];
}
