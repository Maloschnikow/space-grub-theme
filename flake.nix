{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
  flake-utils.lib.eachSystem [flake-utils.lib.system.x86_64-linux] (
    system: let
      overlays = [];
      pkgs = import nixpkgs {
        inherit system overlays;
      };

    in {
      devShells.default = pkgs.mkShell {
        packages = with pkgs;
          [
            grub2_efi
            qemu
            xorriso
            OVMF
            uv
          ];
        shellHook = ''
          export G2TP_GRUB_LIB="${pkgs.grub2_efi}/lib/grub"
          export G2TP_OVMF_IMAGE="${pkgs.OVMF.firmware}"
        '';
      };

      packages.default = pkgs.stdenv.mkDerivation {
        pname = "space-grub-theme";
        version = "0.0.1";
        src = ./.;

        installPhase = ''
          mkdir -p $out
          cp -r * $out
        '';
      };
    }
  );
}