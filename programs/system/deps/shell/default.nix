{ pkgs
, config
, ...
}:

{
  environment.shells = with pkgs; [ zsh ];
}
