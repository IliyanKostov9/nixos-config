{ pkgs, lib, ... }:

let
  main = import ./main.nix { inherit lib; };
in
rec {
  main.user-programs = {
    api.postman.enabled = true;
    browsers.librewolf.enabled = true;
    dbms.dbeaver-bin.enabled = true;
    file-compression.p7zip.enabled = true;
    iot.qFlipper.enabled = true;
    media = {
      gimp.enabled = true;
      obs-studio.enabled = true;
      vlc.enabled = true;
    };
    password-manager.keepass.enabled = true;
    translate.dialect.enabled = true;
    vpn.openvpn3.enabled = true;
  };

  all-programs = builtins.filter (x: x != null) (builtins.concatLists (builtins.attrValues
    (builtins.mapAttrs
      (package-name: package-attr:
        builtins.attrValues
          (builtins.mapAttrs
            (program-name: program-attr:
              if program-attr.enabled == true then pkgs."${program-name}" else null
            )
            package-attr)
      )
      main.user-programs)));

}
