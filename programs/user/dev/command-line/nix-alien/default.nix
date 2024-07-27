({ self, system, ... }: {
  home.packages = with self.inputs.nix-alien.packages.${system}; [
    nix-alien
  ];
})
