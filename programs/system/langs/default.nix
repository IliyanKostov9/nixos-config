{ pkgs, config, ... }:

{
  imports = [
    ./go
    ./jdk
    ./lua
    ./node
    ./dotnet
    ./python
    ./terraform
    ./rust
  ];
}
