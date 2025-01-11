_: {
  programs = {
    zsh.enable = true;
    gnupg.agent.enable = true;
    virt-manager.enable = true;
    dconf.enable = true;
    adb.enable = true;
    firefox.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = false;
    };
  };
}
