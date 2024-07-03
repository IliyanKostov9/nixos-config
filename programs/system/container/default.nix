{ pkgs, config, ... }:

{
  imports = [ ./docker ./k8s ];
}
