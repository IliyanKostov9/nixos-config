{ pkgs, lib, ... }:

let
  main = import ./main.nix { inherit lib; };
in
rec {
  main.user-programs.api.postman.enabled = true;

  all-programs = builtins.filter (x: x != null) (builtins.attrValues
    (builtins.mapAttrs
      (program-name: program-attr:
        if program-attr.enabled == true then pkgs."${program-name}" else null
      )
      main.user-programs.api));
}
