{ pkgs
, ...
}:

{
  environment.systemPackages = with pkgs; [ unzip bzip2 xz zlib ];
}
