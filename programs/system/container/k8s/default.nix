{ pkgs
, config
, ...
}:

{
  environment.systemPackages = with pkgs; [ kubectl kubernetes-helm ];
}
