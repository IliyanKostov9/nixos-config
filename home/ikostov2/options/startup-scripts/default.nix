{ pkgs
, config
, lib
, ...
}:

{
  xsession.initExtra = ''
    # Disable touchpad for laptop
    xinput disable 14
  '';
}
