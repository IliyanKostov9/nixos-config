{pkgs, ...}: {
  imports = [
    ../../programs/user
  ];

  config.modules = {
    preferences.fonts.name = "0xProto";
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
      container.docker.enable = true;

      emulator = {
        tmux.enable = true;
        ghostty.enable = true;
      };
      git.git = {
        enable = true;
        userName = "dummy-user";
        userEmail = "dummy@dummy.dummy";
      };
      langs = {
        go.enable = true;
        node.enable = true;
      };
      shell.bash.enable = true;
    };

    vpn.openvpn.enable = true;
    window-manager.i3wm.enable = true;
    office-suite.flameshot.enable = true;
  };
}
