{
  host_attr,
  lib,
  ...
}:
with lib; {
  imports =
    [
      ./common
      ./common/gpu/nvidia
    ]
    ++ (
      if elem host_attr.gpu ["amd" "intel"]
      then [./common/gpu/${host_attr.gpu}]
      else if host_attr.gpu == "nvidia"
      then [] # NOTE: return nothing because nvidia module is already imported and is mandatory to be imported on every host!
      else throw "> GPU is unknown ${host_attr.gpu}"
    );
}
