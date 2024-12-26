{ pkgs_unstable, ... }:
pkgs_unstable.stdenv.mkDerivation {
  name = "neovim-config";
  phases = [ "buildPhase" ];
  buildPhase = ''
    mkdir -p ~/.config/nvim2
    cp -r ${self.githubRepo}/* ~/.config/nvim2/
  '';
}

