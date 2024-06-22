{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ lazydocker ];
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}
