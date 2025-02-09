{ lib, config, pkgs, ... }:

let
  inherit (config.sops) secrets;
  work_project1_name = if (!lib.trivial.inPureEvalMode) then builtins.readFile secrets.work_project1_name.path else "Work_Project1";
  work_name = if (!lib.trivial.inPureEvalMode) then builtins.readFile secrets.work_name.path else "Work";
  env-vars =
    if (!lib.trivial.inPureEvalMode) then {
      AZURE_DEVOPS_EXT_PAT = "$(command cat ${secrets.azure_devops_ext_pat.path})";
      GITGUARDIAN_API_KEY = "$(command cat ${secrets.gitguardian_api_key.path})";

      GH_TOKEN = "$(command cat ${secrets.gh_token.path})";
      GIT_SOURCE_OWNER = "$(command cat ${secrets.git_source_owner.path})";
      GIT_SOURCE_ORG = "$(command cat ${secrets.git_source_org.path})";
      GIT_DEST_OWNER = "$(command cat ${secrets.git_dest_owner.path})";
      GIT_DEST_PROJECT = "$(command cat ${secrets.git_dest_project.path})";
      GIT_DEST_SSH_DOMAIN = "$(command cat ${secrets.git_dest_ssh_domain.path})";

      TF_TOKEN_app_terraform_io = "$(command cat ${secrets.tf_token_app_terraform_io.path})";
      TF_ORG = "$(command cat ${secrets.tf_org.path})";
    } else { };
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

    browsers.librewolf = {
      enable = true;
      profiles = import ./options/librewolf/profiles { inherit pkgs work_name; };
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
      dbms.dbeaver.enable = true;
      editor.neovim.enable = true;

      emulator = {
        alacritty = {
          enable = true;
          theme = "kanagawa_dragon";
          scheduled = false;
          start-hour = 7;
          end-hour = 16;
          light-theme = "rose_pine_dawn";
          dark-theme = "kanagawa_dragon";
          light-theme-hex = "#faf4ed";
          dark-theme-hex = "#181616";
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
          shouldGPGSign = true;
          gpgKey = "6105AB13B9DCDD1B";
        };
        git-extras.enable = true;
      };

      shell = {
        bash = {
          enable = true;
          inherit env-vars;
        };
        zsh = {
          enable = true;
          inherit env-vars;
        };
      };
    };

    file-compression.p7zip.enable = true;
    iot.qFlipper.enable = true;

    media = {
      gimp.enable = true;
      obs-studio.enable = true;
      vlc.enable = true;
    };

    office-suite = {
      nomacs.enable = true;
      drawio.enable = true;
      libreoffice.enable = true;
      calibre.enable = true;
    };
    password-manager.keepass.enable = true;

    virtualisation = {
      qemu.enable = true;
      virt-manager.enable = true;
      lazydocker.enable = true;
    };
    vpn.openvpn3.enable = true;

    window-manager.i3wm = {
      enable = true;
      librewolf-mappings = {
        "m" = "Main";
        "l" = "Social";
        "y" = "Youtube";
        "d" = work_name;
        "o" = work_project1_name;
      };

      firejail-mappings = {
        "y" = "grayjay";
      };
    };

    utils = {
      copyq.enable = true;
      flameshot.enable = true;
      normcap.enable = true;
    };

  };
}
