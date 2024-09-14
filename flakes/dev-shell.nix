{ inputs, ... }:
{
  perSystem = { pkgs, lib, system, ... }:
    {
      devShells.${system}.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [ python3 ];
      };

      devShells.terraform = pkgs.mkShell {
        buildInputs = [
          pkgs.terragrunt
        ];
      };
    };
}
