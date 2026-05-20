{
  description = "Local ZMK firmware build environment for Cygnus";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-darwin"
        "x86_64-darwin"
        "x86_64-linux"
        "aarch64-linux"
      ];
    in {
      devShells = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
          python = pkgs.python313.withPackages (ps: with ps; [
            anytree
            colorama
            grpcio-tools
            intelhex
            jsonschema
            packaging
            patool
            progress
            protobuf
            psutil
            pyelftools
            pykwalify
            pylink-square
            pyserial
            pyyaml
            remarshal
            requests
            semver
            tabulate
            tqdm
            west
          ]);
        in {
          default = pkgs.mkShell {
            packages = [
              python
              pkgs.cmake
              pkgs.dtc
              pkgs.gcc-arm-embedded
              pkgs.git
              pkgs.gnumake
              pkgs.ninja
              pkgs.protobuf
            ];

            shellHook = ''
              export PATH="${python}/bin:${pkgs.protobuf}/bin:${pkgs.cmake}/bin:${pkgs.ninja}/bin:${pkgs.dtc}/bin:${pkgs.gcc-arm-embedded}/bin:${pkgs.git}/bin:${pkgs.gnumake}/bin:$PATH"
              export ZEPHYR_TOOLCHAIN_VARIANT=gnuarmemb
              export GNUARMEMB_TOOLCHAIN_PATH="${pkgs.gcc-arm-embedded}"
              export ZEPHYR_BASE="$PWD/zephyr"
              export Zephyr_DIR="$PWD/zephyr/share/zephyr-package/cmake"
            '';
          };
        });
    };
}
