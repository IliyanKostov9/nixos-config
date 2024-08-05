{ config, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      foreground = "#${config.colorScheme.palette.base05}";
      background = "#${config.colorScheme.palette.base00}";
    };
  };
}
