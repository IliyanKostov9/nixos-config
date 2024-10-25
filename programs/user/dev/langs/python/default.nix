{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.python;
in
{
  options.modules.python = { enable = mkEnableOption "python"; };

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      #pyenv  # broken: unable to install python
      python3
      uv
    ];
  };

}

