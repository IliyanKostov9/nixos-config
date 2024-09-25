# Nix store path /nix/store/yxxq3ifsb314qybh6vzkbkvwcj0qmnsg-Viber-fhs/opt/viber/Viber
{ pkgs ? import <nixpkgs> {
    config.allowUnfree = true;
    config.permittedInsecurePackages = [
      "openssl-1.1.1w"
    ];
  }
}:

(pkgs.mkShell {
  buildInputs = with pkgs; [
    viber
  ];
  runScript = "bash";

  shellHook = ''
     echo "Entering hook..."
     # path=$(fd "Viber-fhs" /nix/store/ -t d -1)
     # "$path"opt/viber/Viber
    # "$(find /nix/store -type f -path "*/opt/viber/Viber" -print -quit)"
  '';

})
