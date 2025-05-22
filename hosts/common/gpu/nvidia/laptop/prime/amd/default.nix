{lib, ...}: {
  hardware.nvidia.prime.amdgpuBusId = lib.mkDefault "PCI:54:0:0";
}
