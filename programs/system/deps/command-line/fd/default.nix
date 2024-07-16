{ pkgs
, config
, ...
}:

{
  environment.systemPackages = with pkgs; [ fd ];
}
