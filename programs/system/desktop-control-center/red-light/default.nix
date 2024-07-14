{ pkgs
, config
, ...
}:

{
  environment.systemPackages = with pkgs; [ redshit ];
}


