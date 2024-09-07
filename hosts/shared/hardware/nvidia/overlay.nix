self: super: {
  nvidiaSettings = super.nvidiaSettings.overrideAttrs (oldAttrs: {
    buildInputs = oldAttrs.buildInputs ++ [ self.vulkan-headers ];
  });
}
