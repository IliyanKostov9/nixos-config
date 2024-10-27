{ ... }:
{
  programs = {
    zsh.enable = true;
    gnupg.agent.enable = true;
    virt-manager.enable = true;
    dconf.enable = true;
    adb.enable = true;
    firefox.enable = false;
    # gpaste.enable = true;

    neovim = {
      enable = true;
      defaultEditor = true;
      # BUG: Set to false, because it downloads a nvim pkg copy, and doesn't use the user 'unstable' version
      vimAlias = false;
    };
  };
}
