{host_attr,...}:
with host_attr; {
  imports =
    [
      ../common
    ]
    ++ optional (gpu == "amd") ../common/gpu/amd ++ optional (gpu == "nvidia" (dgpu or null) == "nvidia") ../common/gpu/nvidia;
}
