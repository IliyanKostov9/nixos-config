{pkgs, ...}: {
  imports = [
    ../../programs/user
  ];

  config.modules = {
    preferences = {
      fonts.name = "0xProto";
    };

    api.postman.enable = true;

    browsers = {
      librewolf = {
        enable = true;
        profiles = import ./options/librewolf/profiles {inherit pkgs;};
      };
    };

    dev = {
      command-line = {
        bat.enable = true;
        ggshield.enable = true;
      };
      container = {
        docker.enable = true;
      };

      emulator = {
        alacritty = {
          enable = true;
          theme = "nordfox";
          scheduled = true;
          start-hour = 7;
          end-hour = 16;
          light-theme = "dayfox";
          dark-theme = "nordfox";
        };

        tmux = {
          enable = true;
        };
      };
      git = {
        git = {
          enable = true;
          userName = "dummy-user";
          userEmail = "dummy@dummy.dummy";
        };
      };
      langs = {
        go.enable = true;
        node.enable = true;
      };
      shell = {
        bash.enable = true;
      };
    };

    media = {
      vlc.enable = true;
    };

    vpn = {
      openvpn.enable = true;
    };

    window-manager = {
      i3wm = {
        enable = true;
      };
    };

    utils = {
      copyq.enable = true;
      flameshot.enable = true;
    };
  };
}
