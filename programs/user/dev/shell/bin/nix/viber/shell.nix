# Nix store path /nix/store/yxxq3ifsb314qybh6vzkbkvwcj0qmnsg-Viber-fhs/opt/viber/Viber
{ pkgs ? import <nixpkgs> {
    config.allowUnfree = true;
    config.permittedInsecurePackages = [
      "openssl-1.1.1w"
    ];
  }
}:

(pkgs.buildFHSUserEnv {
  name = "Viber";
  targetPkgs = pkgs: (with pkgs; [
    viber
  ]);

})
