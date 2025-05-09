{lib, ...}: {
  imports = [
    ../default.nix
  ];

  hardware.nvidia.prime = {
    sync.enable = true;
    nvidiaBusId = "PCI:1:0:0";
  };
  specialisation = {
    on-the-go.configuration = {
      system.nixos.tags = ["on-the-go"];
      hardware.nvidia = {
        prime = {
          sync.enable = lib.mkForce false;
          offload = {
            enable = lib.mkForce true;
            enableOffloadCmd = lib.mkForce true;
          };
        };
      };
    };
  };
}
