{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.vulkan-headers
    pkgs.vulkan-loader
    pkgs.vulkan-tools
    pkgs.vulkan-validation-layers
    pkgs.shaderc
    pkgs.shaderc.bin
    pkgs.shaderc.static
    pkgs.shaderc.dev
    pkgs.shaderc.lib
  ];
}
