{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.lib;
in
{
  options.modules.lib = { enable = mkEnableOption "lib"; };

  config = mkIf cfg.enable {
    programs.nix-ld = {
      dev.enable = true;
      libraries = with pkgs; [
        steam-run # Needed for MarkdownPreview Neovim to run
        fuse
        desktop-file-utils
        xorg.libXcomposite
        xorg.libXtst
        xorg.libXrandr
        xorg.libXext
        xorg.libX11
        xorg.libXfixes
        libGL

        gst_all_1.gstreamer
        gst_all_1.gst-plugins-ugly
        gst_all_1.gst-plugins-base
        libdrm
        xorg.xkeyboardconfig
        xorg.libpciaccess

        glib
        gtk2
        bzip2
        zlib
        gdk-pixbuf

        xorg.libXinerama
        xorg.libXdamage
        xorg.libXcursor
        xorg.libXrender
        xorg.libXScrnSaver
        xorg.libXxf86vm
        xorg.libXi
        xorg.libSM
        xorg.libICE
        freetype
        curlWithGnuTls
        nspr
        nss
        fontconfig
        cairo
        pango
        expat
        dbus
        cups
        libcap
        SDL2
        libusb1
        udev
        dbus-glib
        atk
        at-spi2-atk
        libudev0-shim

        xorg.libXt
        xorg.libXmu
        xorg.libxcb
        xorg.xcbutil
        xorg.xcbutilwm
        xorg.xcbutilimage
        xorg.xcbutilkeysyms
        xorg.xcbutilrenderutil
        libGLU
        libuuid
        libogg
        libvorbis
        SDL
        SDL2_image
        glew110
        openssl
        libidn
        tbb
        wayland
        mesa
        libxkbcommon
        vulkan-loader

        flac
        freeglut
        libjpeg
        libpng12
        libpulseaudio
        libsamplerate
        libmikmod
        libtheora
        libtiff
        pixman
        speex
        SDL_image
        SDL_ttf
        SDL_mixer
        SDL2_ttf
        SDL2_mixer
        libappindicator-gtk2
        libcaca
        libcanberra
        libgcrypt
        libvpx
        librsvg
        xorg.libXft
        libvdpau
        alsa-lib

        harfbuzz
        e2fsprogs
        libgpg-error
        keyutils.lib
        libjack2
        fribidi
        p11-kit

        gmp

        libtool.lib
        xorg.libxshmfence
        at-spi2-core
        gtk3
        stdenv.cc.cc.lib
      ];
    };
    system.activationScripts.binbash = ''
      mkdir -m 0755 -p /bin
      ln -sfn "${pkgs.bash.out}/bin/bash" "/bin/.bash.tmp"
      mv "/bin/.bash.tmp" "/bin/bash"
    '';
  };
}

