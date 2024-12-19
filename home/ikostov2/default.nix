{ lib, config, pkgs, ... }:
let
  inherit (config.sops) secrets;
  work_project1_name = if (!lib.trivial.inPureEvalMode) then builtins.readFile secrets.work_project1_name.path else "Work_Project1";
  work_name = if (!lib.trivial.inPureEvalMode) then builtins.readFile secrets.work_name.path else "Work";
in
{
  imports = [
    # ./options/overlays
    ../../programs/user
  ];

  config.modules = {
    preferences = {
      fonts.name = "0xProto";
      red-light.enable = true;
    };

    api.postman.enable = true;

    browsers = {
      librewolf = {
        enable = true;
        profiles = import ./options/librewolf/profiles { inherit lib config pkgs work_name work_project1_name; };
      };
    };

    dev = {
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
          enable-dynamic-conf = true;
          static-vals = [ "$Work*" "$Work_Project1*" ];
          dynamic-vals = [ work_name work_project1_name ];
        };

      };
      git = {
        git = {
          enable = true;
          userName = "iliyan-kostov";
          userEmail = "iliyan.kostov@email.ikostov.org";
        };
        git-extras.enable = true;
      };
      langs = {
        go.enable = true;
        node.enable = true;
      };
      linters = {
        # INFO: Required for yamllint in nvim
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
    };

    office-suite = {
      nomacs.enable = true;
      okular.enable = true;
      drawio.enable = true;
      libreoffice.enable = true;
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
      i3wm = {
        enable = true;
        librewolf-mappings = {
          "m" = "Main";
          "y" = "Youtube";
          "l" = "Linked-In";
          "d" = work_name;
          "o" = work_project1_name;
        };
      };
    };

    utils = {
      copyq.enable = true;
      flameshot.enable = true;
      normcap.enable = true;
    };
  };
}
