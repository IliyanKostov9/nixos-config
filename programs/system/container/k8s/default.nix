{ pkgs
, config
, ...
}:

{
  environment.systemPackages = with pkgs; [ kubectl helm ];
}
