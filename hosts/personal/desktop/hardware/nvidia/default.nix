{ lib, ... }:

{
  hardware.nvidia.prime = {
    sync.enable = true;
    nvidiaBusId = "PCI:29:0:0";
  };
}
