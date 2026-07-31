{
  description = "OpenJournal - PsychonautWiki Journal";

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
          ];

          shellHook = ''
            export JAVA_HOME="${pkgs.temurin-bin-21}"
            export ANDROID_HOME="${androidSdk}"
            export ANDROID_SDK_ROOT="${androidSdk}"
            export ANDROID_AVD_HOME="$HOME/.android/avd"
            echo "OpenJournal dev shell (Flutter Migration)"
            echo "  JDK:     $JAVA_HOME"
            echo "  SDK:     $ANDROID_HOME"
            echo "  Flutter: $(flutter --version 2>/dev/null | head -1 || echo 'not found in path yet')"
            echo "  Gradle:  $(./gradlew --version 2>/dev/null | grep 'Gradle ' | head -1 || echo 'use wrapper')"
          '';
        };
      });
}
