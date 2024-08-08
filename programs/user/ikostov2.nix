{ lib
, config
, ...
}:
let
  user-programs = import ./main.nix;
in
{
  imports = [
    # ./api
    ./file-compression
    ./browsers
    ./cloud
    ./dbms
    ./dev
    ./iot
    ./media
    ./office-suite
    ./password-manager
    ./translate
    ./virtualisation
    ./vpn
    ./window-manager
    ./x11-utils
    ./win-api
  ];

  user-programs.api.enabled = lib.mkForce true;

  all-programs = builtins.attrValues
    (builtins.mapAttrs
      (
        program-name: program-attr:
          if program-attr.enabled == true then program-name else null
      )
      user-programs);
}
