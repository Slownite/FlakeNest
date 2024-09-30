{
  description = "A Nix flake for a Python package fetched from PyPI";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
      python = pkgs.python3;
    in {
      # Package definition fetching from PyPI
      packages.default = python.mkDerivation {
        pname = "your-python-package";  # Name of your Python package
        version = "0.1.0";  # Version of the package

        # Fetch the package from PyPI
        src = pkgs.fetchPypi {
          pname = "your-python-package";  # The package name on PyPI
          version = "0.1.0";  # Version to fetch from PyPI
          sha256 = "<hash-of-the-package>";  # Hash of the package for integrity check
        };

        # Use pip and wheel for building the package
        buildInputs = [
          pkgs.python3Packages.pip
          pkgs.python3Packages.setuptools
          pkgs.python3Packages.wheel
        ];

        buildPhase = ''
          pip install --prefix=$out .
        '';

        meta = with pkgs.lib; {
          description = "Your Python Package fetched from PyPI for Nix Flakes";
          license = licenses.mit;  # Specify the correct license
          maintainers = [ maintainers.yourName ];
          platforms = platforms.all;
        };
      };

      # DevShell for development environment
      devShell = pkgs.mkShell {
        buildInputs = [
          python
          pkgs.python3Packages.pip
        ];

        shellHook = ''
          pip install --editable .
        '';
      };
    });
}

