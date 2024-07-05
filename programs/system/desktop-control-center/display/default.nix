{ pkgs
, config
, ...
}:

{
  environment.systemPackages = with pkgs; [ arandr ];
}


