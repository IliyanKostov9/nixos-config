{ pkgs, config, ... }:

{
  imports = [ ./docker ./kubectl ];
}
