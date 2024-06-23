{ pkgs
, config
, ...
}:

{
  environment.systemPackages = with pkgs; [ fzf ripgrep ];
}
