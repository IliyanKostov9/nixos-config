{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ postman ];
}
