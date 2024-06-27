{ pkgs
, config
, ...
}:
{
  programs.gnupg.agent.enable = true;
}
