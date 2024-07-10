{ pkgs, config, ... }:

{
  imports = [
    # ./dotnet
    ./go
    ./jdk
    # ./kotlin
    ./lua
    ./node
    ./python
    ./rust
    ./terraform
  ];
}
