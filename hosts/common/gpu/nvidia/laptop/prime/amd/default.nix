{host_attr, ...}: {
  hardware.nvidia.prime.amdgpuBusId = host_attr.busIds.amd;
}
