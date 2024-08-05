{ nix-colors
, ...
}:

{
  imports = [ ./gtk nix-colors.homeManagerModules.default ];
  colorScheme = nix-colors.colorSchemes.gruvbox-dark-medium;
}
