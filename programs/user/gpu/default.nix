{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # $ nixGLIntel blender
    pkgs.nixgl.nixGLIntel
    pkgs.nixgl.nixGLNvidiaBumblebee
  ];
}
