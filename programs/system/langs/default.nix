{ pkgs }:

{
  imports = [
    ./go
    ./jdk
    ./lua
    ./node
    ./dotnet
    ./python
    ./terraform
  ];
}
