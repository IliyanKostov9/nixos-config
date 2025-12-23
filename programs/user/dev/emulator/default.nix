{
  lib,
  ...
}: {
  options.modules.dev.emulator = {
    default = lib.mkOption {
      type = lib.types.str;
      default = "ghostty";
      description = lib.mkDoc ''
        Name of the terminal
      '';
    };
  };

  imports = [
    ./macos
    ./ghostty
    ./kitty
    ./alacritty
    ./terminator
    ./tmux
  ];
}
