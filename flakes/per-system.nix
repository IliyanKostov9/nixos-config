{ inputs, ... }:
{
  perSystem = { pkgs, lib, system, ... }:
    {
      devShells.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [ python3 ];
      };
    };
}
