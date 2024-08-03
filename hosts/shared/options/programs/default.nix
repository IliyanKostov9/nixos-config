{ ... }:
{
  programs = {
    zsh.enable = true;

    nix-ld.enable = true;
    gnupg.agent.enable = true;
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
    };
  };
}
