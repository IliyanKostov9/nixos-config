{pkgs-2511, ...}: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    # NOTE: It's not able to connect to Google Nest Hub 2 on 26.05
    package = pkgs-2511.bluez;
    settings = {
      Policy.AutoEnable = "true";
      General = {
        Name = "Computer";
        ControllerMode = "dual";
        FastConnectable = "true";
        Experimental = true;
      };
    };
  };
}
