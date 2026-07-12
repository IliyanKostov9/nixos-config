_: {
  imports = [
    ../../programs/user
  ];

  config.modules = {
    dev = {
      emulator = {
        default = "ghostty";
        ghostty.enable = true;
      };
      git = {
        git = {
          enable = true;
          userName = "garming";
          userEmail = "garming.@something.com";
        };
        git-extras.enable = true;
      };
      shell = {
        bash.enable = true;
        zsh.enable = true;
      };
    };

    window-manager.sway = {
      enable = true;
      enable-laptop-display = false;
    };
    preferences.fonts = {
      name = "0xProto";
      size = 17;
    };

    entertainment.gaming.enable = true;
    vpn.openvpn.enable = false;
    utils.flameshot.enable = true;
  };
}
