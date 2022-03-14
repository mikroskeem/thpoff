{
  description = "thpoff";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      supportedSystems = [
        "aarch64-linux"
        "x86_64-linux"
      ];
    in
    {
      nixosModules = {
        thpoff = import ./nix/module.nix;
      };
      nixosModule = self.nixosModules.thpoff;
    }
    // (flake-utils.lib.eachSystem supportedSystems (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      rec {
        packages.thpoff = pkgs.callPackage ./default.nix {
          rev = self.rev or "dirty";
        };

        defaultPackage = packages.thpoff;
      }));
}
