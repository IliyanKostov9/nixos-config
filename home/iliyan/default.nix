{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (config.sops) secrets;
  get-secret = {
    secret-name,
    fallback-secret-name,
  }:
    if (!lib.trivial.inPureEvalMode)
    then let
      does-secret-exist =
        builtins.hasAttr secret-name secrets && builtins.pathExists secrets."${secret-name}".path;
    in
      if does-secret-exist
      then builtins.readFile secrets."${secret-name}".path
      else lib.warn "> Cannot set Work_Name_New as env varibale, because it's not found in the secret keystore! Falling back to ${fallback-secret-name}" fallback-secret-name
    else lib.warn "> Cannot assign secret in pure eval mode! Falling back to ${fallback-secret-name}" fallback-secret-name;

  work_name = get-secret {
    secret-name = "work_name";
    fallback-secret-name = "Work";
  };
  work_project1_name = get-secret {
    secret-name = "work_project1_name";
    fallback-secret-name = "Work_Project1";
  };
  work_name_new = get-secret {
    secret-name = "work_name_new";
    fallback-secret-name = "Work_Name_New";
  };

  env-vars =
    if (!lib.trivial.inPureEvalMode)
    then {
      AZURE_DEVOPS_EXT_PAT = "$(command cat ${secrets.azure_devops_ext_pat.path})";
      GITGUARDIAN_API_KEY = "$(command cat ${secrets.gitguardian_api_key.path})";
      GH_TOKEN = "$(command cat ${secrets.gh_token.path})";

      TF_TOKEN_app_terraform_io = "$(command cat ${secrets.tf_token_app_terraform_io.path})";
      TF_ORG = "$(command cat ${secrets.tf_org.path})";

      ZVM_CURSOR_STYLE_ENABLED = "false";
      ZVM_INIT_MODE = "sourcing";
      AUTOPAIR_INIT_INHIBIT = "1";
    }
    else lib.warn "> Cannot set user env variables, because the build is in pure eval mode!" {};
in {
  imports = [
    # ./options/overlays
    ./options/blueman-applet
    ../../programs/user
  ];

  config.modules = {
    window-manager.sway = {
      enable = true;
      librewolf-mappings = {
        "m" = "Main";
        "t" = "Test";
      };
    };

    preferences = {
      fonts.name = "0xProto";
      fonts.size = 14;
      red-light.enable = true;
    };
    api.postman.enable = true;
    #rdp.citrix.enable = true;

    browsers.librewolf = {
      package = null; # NOTE: For firejail
      enable = true;
      profiles = import ./options/librewolf/profiles {inherit pkgs;};
    };

    dev = {
      command-line = {
        bat.enable = true;
        eza.enable = true;
        ggshield.enable = true;
      };
      container.docker.enable = true;
      dbms.dbeaver.enable = true;
      editor.neovim.enable = true;

      emulator = {
        default = "ghostty";
        ghostty.enable = true;
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
          static-vals = ["$Work*" "$Work_Project1*" "$Work_New*"];
          dynamic-vals = [work_name work_project1_name work_name_new];
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
      syncthing.enable = true;
      drawio.enable = true;
      libreoffice.enable = true;
      master-pdf.enable = true;
      okular.enable = true;
    };
    password-manager.keepass.enable = true;

    virtualisation.lazydocker.enable = true;
    vpn.openvpn.enable = true;

    utils = {
      copyq.enable = true;
      flameshot.enable = true;
      normcap.enable = true;
    };
  };
}
