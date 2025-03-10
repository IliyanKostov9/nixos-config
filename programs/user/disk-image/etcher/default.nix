{lib, ...}:
with lib; {
  options.modules.disk-image.etcher = {enable = mkEnableOption "etcher";};

  # INFO: This should be the desired result if the user has enabled etcher. The logic should be defined here, but due to a syntax issue that's not possible.
  # config = mkIf cfg.enable {
  #   programs.zsh.shellAliases = programs.zsh.shellAliases // { etcher = "/etc/nixos/programs/user/disk-image/etcher/result/bin/etcher"; };
  # };
}
