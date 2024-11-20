_: {

  # systemd.user.services.alacritty-theme-switcher = {
  #   description = "Switch Alacritty theme based on time";
  #   script = ''
  #     HOUR=$(date +%H)
  #     CONFIG_PATH="$HOME/.config/alacritty/alacritty.yml"
  #
  #     if (( 8 <= HOUR && HOUR < 16 )); then
  #       THEME="rose_pine_dawn"
  #     else
  #     THEME="gruvbox_material_hard_dark"
  #     fi
  #     nix-shell -p alacritty-theme --run "alacritty-colorscheme apply $THEME"
  #   '';
  #   wantedBy = [ "default.target" ];
  # };
  #
  # systemd.user.timers.alacritty-theme-switcher-timer = {
  #   description = "Timer to switch Alacritty theme based on time";
  #   timerConfig.onCalendar = "*:0/1";
  #   wantedBy = [ "timers.target" ];
  # };

  programs = {
    zsh.enable = true;
    gnupg.agent.enable = true;
    virt-manager.enable = true;
    dconf.enable = true;
    adb.enable = true;
    firefox.enable = true;
    # gpaste.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
      # BUG: Set to false, because it downloads a nvim pkg copy, and doesn't use the user 'unstable' version
      vimAlias = false;
    };
  };
}
