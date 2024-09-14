{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.python;
in
{
  options.modules.python = { enable = mkEnableOption "python"; };

  config = mkIf cfg.enable {

    # TODO: Move zsh elesewhere
    environment.shells = with pkgs; [ zsh ];
    environment.systemPackages = with pkgs; [
      #pyenv  # broken: unable to install python
      python3
      python311Packages.pip
      python311Packages.pipx
    ];
  };

}

