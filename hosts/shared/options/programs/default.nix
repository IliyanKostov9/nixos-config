{ ... }:
{
  programs = {
    nix-ld.enable = true;
    virt-manager.enable = true;
    dconf.enable = true;
    adb.enable = true;
    firefox.enable = true;
    gpaste.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      gnupg.agent.enable = true;
    };
  };
}
