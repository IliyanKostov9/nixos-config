{ pkgs
, config
, ...
}:

{
  environment.systemPackages = with pkgs; [
    libstdcxx5
    gcc
    gnumake
    glibc
    libgccjit
  ];
}
