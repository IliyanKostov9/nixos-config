{ pkgs
, config
, ...
}:

{
  environment.systemPackages = with pkgs; [ connman cmst ];
}


