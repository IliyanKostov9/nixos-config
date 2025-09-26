{lib, ...}: {
  # NOTE: Disabled because of external monitor flickering
  hardware.nvidia.prime.sync.enable = lib.mkForce false;
  imports = [
    ./modules
    ../common
    ../common/gpu/nvidia/laptop
    ../common/gpu/nvidia/laptop/prime/amd
    ../common/gpu/nvidia
    ../common/gpu/amd
  ];
}
