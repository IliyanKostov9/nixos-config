let
  version = "1.19.21";
  buildNumber = "303";
in
{ pkgs ? import <nixpkgs> { } }:
pkgs.appimageTools.wrapType2 {
  name = "etcher";
  src = pkgs.fetchurl {
    url = "https://github.com/balena-io/etcher/releases/download/v${version}/balenaEtcher-${version}-x64.AppImage";
    sha256 = "sha256-dHhz7vcrrJZu4rWXRtwcIt2UvFThZrtKHz9H2qV2H60=";
  };
}

