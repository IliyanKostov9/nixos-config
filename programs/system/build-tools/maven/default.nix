{ pkgs
, config
, ...
}:

{
  environment.systemPackages = with pkgs; [ maven ];
}
