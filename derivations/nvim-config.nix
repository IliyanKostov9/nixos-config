{ pkgs ? import <nixpkgs> { }, lib ? import <nixpkgs> { } }:
with lib;

let
  owner = "IliyanKostov9";
  repo = "nvim-config";
  rev = "master";
  hash = "sha256-uQty9Zz69jU7GXi46fW5g/1gyZ3N+a3OG4FSYypXAN4=";

  github =
    pkgs.fetchFromGitHub
      {
        inherit owner repo rev hash;
        leaveDotGit = true;
      };
  # github = fetchgit {
  #   url = "https://github.com/IliyanKostov9/nvim-config.git";
  #   hash = "sha256-p18vpppEgi2ds7P4DQDsrN9Y12vLiLDJeSb9mOe0xl0=";
  #   # branch-name = "master";
  #   leaveDotGit = true;
  # };
in
pkgs.stdenv.mkDerivation {
  name = "neovim-config";
  pname = "nvim-config";
  version = "1.0";
  description = "My personal nvim config";
  # license = stdenv.lib.licenses.bsd3;

  phases = [ "buildPhase" ];
  buildPhase = ''
    mkdir -p $out/nvim
    cp -r ${github}/* $out/nvim
    cp -r ${github}/.* $out/nvim
    echo "path is $out"
  '';
}

