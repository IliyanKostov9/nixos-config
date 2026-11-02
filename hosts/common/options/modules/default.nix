_: {
  config.modules = {
    hardware = {
      boot.kernel = "7_3";
      power-saver.enable = true;
      firmware.disableTouchpad = true;
      keyboard = {
        console = "dvorak";
        # NOTE: Props to: https://github.com/ivangeorgiew for providing the missing Dvorak for bg
        extraLayouts.bgd = {
          description = "Bulgarian Dvorak";
          languages = ["bul"];
          symbolsFile = ../../options/xkb/dvorak/bgd;
        };
      };
    };

    nvidia = {
      openSource = true;
      channel = "";
      version = "615.78.08";
      sha256_64bit = "sha256-Pj9t3cLudnoIGFMAr3vjyyhuznZpjS3eNSRZl4LQf/4=";
      sha256_aarch64 = "sha256-UHYBE1AYHoGgMfD9AS/jX+S+N8eCDWUft6qolK9Eejc=";
      openSha256 = "sha256-HBINiOjL0ZJLIAJeNIBYHBnwgUXtNwPPtnFpAI1YwF4=";
      settingsSha256 = "sha256-inDRpG02sdDgHmlqgu/DsgK8OFdOt1fZIYyXdhlGC/c=";
      persistencedSha256 = "sha256-RzeR6Ldct6MUxjnXRyThdh5Y3jjMehTVg85MtwuWNX4=";
      prime = {
        enableSync = false;
        enableOffload = true;
      };
    };

    options = {
      garbage-collect = {
        enable = true;
        schedule = "weekly";
      };
      locale = {
        timeZone = "Europe/Sofia";
        defaultLocale = "fr_FR.UTF-8";
      };
      networking.nameservers = [];
    };

    window-manager.sway.enable = true;
    vpn = {
      tailscale.enable = true;
      openvpn = {
        enable = true;
        autoStart = true;
      };
    };

    downloader = {
      curl.enable = true;
      home-manager.enable = true;
      wget.enable = true;
      nix.nix-output-monitor.enable = true;
    };

    lib.nix-ld.enable = true;
    gnome-disable-apps.enable = true;

    security = {
      cryptography.enable = true;
      firejail.enable = true;
      login.enable = true;
    };

    files.enable = true;
    monitor.enable = true;

    desktop-settings = {
      audio.pipewire.enable = true;
      file-manager.pcmanfm.enable = true;
      network.enable = true;
      display-manager.catppuccin-sddm.enable = false; # NOTE: Mouse is invisible when switching to another user
      magic-mouse.enable = true;
    };

    scm.git.enable = true;
    office-suite.enable = true;

    dev = {
      editor.vim.enable = true;
      make.enable = true;
      keyd = {
        enable = true;
        mappings = {
          "rightshift" = "down";
          #"rightcontrol" = "overload(right_control_layer, rightcontrol)";
          "rightcontrol" = "right";
          "rightalt" = "up";
        };
      };
    };
  };
}
