{pkgs-2511, ...}: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
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
