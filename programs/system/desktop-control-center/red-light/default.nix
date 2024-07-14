{ pkgs
, config
, ...
}:

{
  environment.systemPackages = with pkgs; [ redshift ];
}


