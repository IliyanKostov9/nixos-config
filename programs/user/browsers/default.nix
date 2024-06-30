{ pkgs
, config
, ...
}:
{
  imports = [
    ./chromium
    ./librewolf
    # Problem 
    # Edge is automatically lowering volume on MS Teams meeting
    # ./microsoft-edge
  ];
}
