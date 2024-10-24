{ host_name, pkgs, ... }:
{
  environment.variables = {
    EDITOR = "nvim";
    JAVA_HOME = "${pkgs.jdk}/lib/openjdk";
    PATH = "${pkgs.jdk}/bin:" + builtins.getEnv "PATH";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    DEVICE = if builtins.match ".*desktop*." host_name != null then "desktop" else "laptop";
  };
}
