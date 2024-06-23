{ pkgs
, config
, ...
}:
{
  imports = [ ./flameshot ./gpick ./gpaste ./normcap ./gnomeExtensions ];
}
