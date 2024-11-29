{ config, ... }:
{
  imports = [
    # ./overlays.nix
    ../../secrets
    ../../programs/user
  ];

  config.modules = {
    preferences = {
      fonts.name = "0xProto";
      red-light.enable = true;
    };

    api.postman.enable = true;

    browsers = {
      librewolf.enable = true;
      chromium.enable = true;
    };

    cloud = {
      awscli2.enable = true;
      azure-cli.enable = true;
      rclone.enable = false;
    };

    dev = {
      build-tools = {
        maven.enable = true;
        gradle.enable = false;
      };
      command-line = {
        sops.enable = true;
        bat.enable = true;
        ggshield.enable = true;
      };
      container = {
        docker.enable = true;
        k8s.enable = true;
      };
      dbms = {
        dbeaver.enable = true;
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
          userName = "iliyan-kostov";
          userEmail = "iliyan.kostov@email.ikostov.org";
        };
        gh.enable = true;
        git-extras.enable = true;
        gitmoji-cli.enable = false;
      };
      langs = {
        go.enable = true;
        jdk.enable = true;
        lua.enable = true; # REQUIRED: By nvim jdtls
        node.enable = true;
        python.enable = true;
        rust.enable = true;
      };
      linters = {
        # INFO: Required for yammlint in nvim
        yamllint.enable = true;
      };
      shell = {
        bash.enable = true;
        zsh.enable = true;
      };
    };

    file-compression = {
      p7zip.enable = true;
    };
    iot = {
      qFlipper.enable = true;
    };

    media = {
      gimp.enable = true;
      obs-studio.enable = true;
      vlc.enable = true;
      viber.enable = true;
    };

    office-suite = {
      nomacs.enable = true;
      okular.enable = true;
      drawio.enable = true;
      libreoffice.enable = true;
      mail.enable = true;
    };

    password-manager = {
      keepass.enable = true;
    };

    virtualisation = {
      qemu.enable = true;
      virt-manager.enable = true;
      lazydocker.enable = true;

    };

    vpn = {
      openvpn3.enable = true;
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
