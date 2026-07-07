{
  description = "LaTeX development environment utilizing Tectonic";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            tectonic
            texlab
            noto-fonts
            noto-fonts-cjk-sans
          ];

          shellHook = ''
            unset SOURCE_DATE_EPOCH
            echo "Tectonic environment ready"
            echo "  nix run .#build : build document"
            echo "  nix run .#watch : watch files and build automatically"
          '';
        };
      }
    );
}
