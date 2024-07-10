{ pkgs
, config
, ...
}:

{
  # Should probabbly remove this part and move it to lib package
  environment.systemPackages = with pkgs; [
    glib
    gcc
    gnumake
    glibc
    libgccjit
  ];
}
