{ pkgs
, config
, ...
}:

{
  environment.systemPackages = with pkgs; [
    pavucontrol
    pamixer
  ];
}


