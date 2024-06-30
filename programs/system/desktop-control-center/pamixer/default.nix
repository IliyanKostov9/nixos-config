{ pkgs
, config
, ...
}:

{
  environment.systemPackages = with pkgs; [ pamixer ];
}


