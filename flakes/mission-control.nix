{ ... }:

{
  flake.mission-control.scripts = {
    # wrapperName = "-";
    viber = {
      description = "Start viber";
      exec = ''
        nix shell  /etc/nixos/programs/user/dev/shell/bin/nix/viber/shell.nix
      '';
      category = "Dev Tools";
    };
  };
}
