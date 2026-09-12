{pkgs, ...}: {
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
    # NOTE: Remove once bluez gets fixed (e.g able to connect to Google Nest hub 2)
    package =
      (pkgs.bluez.override {
        bluez-headers = pkgs.bluez-headers.overrideAttrs (old: {
          version = "5.84";
          src = pkgs.fetchurl {
            url = "mirror://kernel/linux/bluetooth/bluez-5.84.tar.xz";
            hash = "sha256-W6c9Aw97AAh9Z4ALDjIWAa7A+JKCfHLlosg5DYyIaxE=";
          };
        });
      }).overrideAttrs
      {
        patches = [
          (pkgs.fetchurl {
            name = "static.patch";
            url = "https://lore.kernel.org/linux-bluetooth/20250703182908.2370130-1-hi@alyssa.is/raw";
            hash = "sha256-4Yz3ljsn2emJf+uTcJO4hG/YXvjERtitce71TZx5Hak=";
          })
        ];
      };
  };
}
