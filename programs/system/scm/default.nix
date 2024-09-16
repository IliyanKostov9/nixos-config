{ pkgs, ... }:

{

  # TODO: Move zsh elesewhere
  environment.shells = with pkgs; [ zsh ];
  imports = [
    ./git
    ./subversion
  ];
}
