{...}: {
  services.pipewire = {
    enable = true;
    # package = pkgs-2511.pipewire;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    jack.enable = true;
    audio.enable = true;
    pulse.enable = true;
    wireplumber = {
      enable = true;
      # package = pkgs-2511.wireplumber;
      extraConfig.bluetoothEnhancements = {
        "monitor.bluez.properties" = {
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.enable-hw-volume" = true;
          "bluez5.roles" = [
            "a2dp_sink"
            "a2dp_source"
            "bap_sink"
            "bap_source"
            "hsp_hs"
            "hsp_ag"
            "hfp_hf"
            "hfp_ag"
          ];
        };
      };
    };
  };
}
