{
  description = "OpenJournal - Multiplatform PsychonautWiki Journal";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        androidSdk = "/home/lucy/Android/Sdk";
      in
      {
        devShells.default = pkgs.mkShell {
          name = "openjournal-dev";

          buildInputs = with pkgs; [
            temurin-bin-21
            flutter
            # Linux desktop build dependencies (GTK4 + Adwaita)
            at-spi2-core
            clang
            cmake
            dbus
            gtk4
            libadwaita
            libdatrie
            libepoxy
            libselinux
            libsepol
            libthai
            libxkbcommon
            ninja
            pcre
            pkg-config
            libxdmcp
            libxtst
            util-linux
          ];

          shellHook = ''
            export JAVA_HOME="${pkgs.temurin-bin-21}"
            export ANDROID_HOME="${androidSdk}"
            export ANDROID_SDK_ROOT="${androidSdk}"
            export ANDROID_AVD_HOME="$HOME/.android/avd"
            echo "OpenJournal Flutter Dev Shell (GTK4)"
            echo "  JDK:     $JAVA_HOME"
            echo "  Flutter: $(flutter --version 2>/dev/null | head -1 || echo 'not found')"
          '';
        };
      });
}
