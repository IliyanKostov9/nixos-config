{ pkgs
, config
, ...
}:
{
  imports = [
    ./terminal-ui
    ./qemu
    ./virt-manager
  ];
}
