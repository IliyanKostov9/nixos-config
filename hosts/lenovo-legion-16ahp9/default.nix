_: {
  imports = [
    ./modules
    ./displayManager
    ../common
    ../common/gpu/nvidia/laptop
    # NOTE: already provided by nixos modules
    #    ../common/gpu/nvidia/laptop/prime/amd
    ../common/gpu/nvidia
  ];
}
