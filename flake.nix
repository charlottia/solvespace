{
  description = "SolveSpace macOS build flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

  outputs = {
    self,
    nixpkgs,
  }: let
    pkgs = nixpkgs.legacyPackages.aarch64-darwin;
  in {
    formatter.aarch64-darwin = pkgs.alejandra;

    devShells.aarch64-darwin.default = pkgs.mkShell {
      buildInputs = [
        pkgs.cmake
        pkgs.llvmPackages.openmp
      ];

      LIBOMP_LIB_PATH = "${pkgs.llvmPackages.openmp}/lib/libomp.dylib";

      # cp $LIBOMP_LIB_PATH .; cmake .. -DCMAKE_BUILD_TYPE=Release -DENABLE_OPENMP=ON
    };
  };
}
