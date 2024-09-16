{ inputs, ... }:
{
  perSystem = { pkgs, ... }:
    {
      devShells = {
        default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [ python3 ];
        };
        terraform = pkgs.mkShell {
          buildInputs = [
            pkgs.terragrunt
          ];
        };
      };
    };
}
