_: {
  programs = {
    zsh.enable = true;
    gnupg.agent.enable = true;
    # NOTE: GNOME only
    dconf.enable = true;
    adb.enable = false;
    firefox.enable = false;
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = false;
    };
  };
}
