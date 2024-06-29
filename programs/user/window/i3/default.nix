{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [
    i3
    i3status-rust
  ];

  imports = [
    ./config
    ./themes
    ./utils
  ];
}
