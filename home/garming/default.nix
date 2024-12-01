{ config, ... }:
{
  imports = [
    ../../secrets
    ../../programs/user
  ];

  config.modules = {
    browsers = {
      librewolf.enable = true;
    };

    dev = {
      command-line = {
        bat.enable = true;
      };

      editor = {
        neovim.enable = true;
      };

      emulator = {
        alacritty.enable = true;
        tmux.enable = true;
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

    file-compression = {
      p7zip.enable = true;
    };

    entertainment = {
      gaming.enable = true;
    };

    media = {
      vlc.enable = true;
    };

    office-suite = {
      libreoffice.enable = true;
      nomacs.enable = true;
    };

    vpn = {
      openvpn3.enable = false;
    };

    window-manager = {
      i3wm.enable = true;
    };

    utils = {
      copyq.enable = true;
      flameshot.enable = true;
      normcap.enable = true;
    };
  };
}
