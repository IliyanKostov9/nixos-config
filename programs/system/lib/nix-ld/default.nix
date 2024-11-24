{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.lib.nix-ld;
in
{
  options.modules.lib.nix-ld = { enable = mkEnableOption "nix-ld"; };

  config = mkIf cfg.enable {
    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        steam-run # Needed for MarkdownPreview Neovim to run
      ];
    };
  };
}
