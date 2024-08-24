{ inputs, ... }:
{
  perSystem = { pkgs, lib, system, ... }:
    # perSystem = { config, self', inputs', pkgs, lib, system, nixgl, nixpkgs_unstable, nixgl, ... }:
    with inputs; {
      # _module.args.pkgs = import inputs.nixpkgs {
      #   inherit system;
      #   overlays = [ (import inputs.rust-overlay) ];
      # };
      #
      # packages = {
      #   rust-toolchain-stable = pkgs.rust-bin.stable.latest.minimal.override {
      #     extensions = [
      #       "rust-src"
      #       "clippy"
      #       "rust-analyzer"
      #     ];
      #   };
      # system = "x86_64-linux";
      # system = config.nixpkgs.hostPlatform.system;

      _module.args = {
        stateVersion = "24.05";
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ (nixgl.overlay) ];
          config = { allowUnfree = true; };
        };
        pkgs_unstable = import nixpkgs_unstable {
          inherit system;
        };
      };
      # lib = pkgs.lib;

      devShells.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [ terraform wget bat nixpkgs-fmt ];
      };

      devShells.another_env = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [ curl ];
      };
    };
}
