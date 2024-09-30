{
  description = "A bare bone python project template using only pip and nixpkgs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    python = pkgs.python3;
  in {
    devShells.${system} = {
      default = pkgs.mkShell {
        nativeBuildInputs = [
          python
          python.pkgs.pip
          pkgs.pkg-config
        ];

        buildInputs = []; # add your package here
      };
    };
  };
}

