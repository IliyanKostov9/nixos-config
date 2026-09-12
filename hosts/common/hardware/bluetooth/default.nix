_: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
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
