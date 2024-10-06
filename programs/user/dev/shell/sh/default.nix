{ pkgs, ... }:

pkgs.writeShellApplication {
  name = "hello";
  runtimeInputs = [ ];

  text = ''
    #!${pkgs.bash}/bin/bash
    echo "hello"
  '';
}
