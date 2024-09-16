{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.lib;
in
{
  options.modules.lib = { enable = mkEnableOption "lib"; };

  config = mkIf cfg.enable {
    programs.nix-ld.libraries = with pkgs; [
      steam-run # Needed for MarkdownPreview Neovim to run
    ];
  };

}

