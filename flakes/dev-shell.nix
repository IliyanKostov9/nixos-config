{ inputs, ... }:
{
  perSystem = { pkgs, lib, system, ... }:
    {
      devShells.${system}.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [ python3 ];
      };

      devShells.python = (pkgs.buildFHSUserEnv {
        name = "pipzone";
        targetPkgs = pkgs: (with pkgs; [
          python311
          opencv4
          mesa
          libGL
          libGLU
          glib
          glibc
          zlib
          stdenv.cc.cc.lib
        ]);
        runScript = "zsh";
      }).env;

      devShells.terraform = pkgs.mkShell {
        buildInputs = [
          pkgs.terragrunt
        ];
      };
    };
}
