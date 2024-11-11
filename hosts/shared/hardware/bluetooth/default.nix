_: {
  # Enable bloothooth support
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings.Policy.AutoEnable = "true";
    settings = {
      General = {
        Name = "Computer";
        ControllerMode = "dual";
        FastConnectable = "true";
        Experimental = true;
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };
}
