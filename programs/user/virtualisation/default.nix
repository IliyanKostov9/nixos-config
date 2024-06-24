{ pkgs
, config
, ...
}:
{
  imports = [ ./lazydocker ./qemu ./virt-manager ];
}
