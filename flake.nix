# This flake was initially generated by fh, the CLI for FlakeHub (version 0.1.22)
{

  # Flake inputs
  inputs = {
    flake-schemas.url = "https://flakehub.com/f/DeterminateSystems/flake-schemas/*";

    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/*";
  };

  # Flake outputs that other flakes can use
  outputs =
    {
      self,
      flake-schemas,
      nixpkgs,
    }:
    let
      # Helpers for producing system-specific outputs
      supportedSystems = [
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
        "aarch64-linux"
      ];
      forEachSupportedSystem =
        f:
        nixpkgs.lib.genAttrs supportedSystems (
          system:
          f {
            pkgs = import nixpkgs { inherit system; };
          }
        );
    in
    {
      # Schemas tell Nix about the structure of your flake's outputs
      schemas = flake-schemas.schemas;

      # Development environments
      devShells = forEachSupportedSystem (
        { pkgs }:
        {
          default = pkgs.mkShell {
            # Pinned packages available in the environment
            packages = with pkgs; [
              nil

              self.packages.${pkgs.system}.default
            ];
          };
        }
      );

      packages = forEachSupportedSystem (
        { pkgs }:
        {
          default = pkgs.stdenv.mkDerivation {
            name = "gtk-scss-language-server";
            version = "0.1.0";
            src = ./.;
            nativeBuildInputs = [
              pkgs.vala
              pkgs.meson
              pkgs.ninja
              pkgs.pkg-config
              pkgs.gtk4
              pkgs.jsonrpc-glib
              pkgs.json-glib

              pkgs.git
            ];
          };
        }
      );
    };
}
