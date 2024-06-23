{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [
    gh
    git-extras
    gitmoji-cli
  ];
}
