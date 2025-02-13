{
  description = "Local go env for project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [];
        };

      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            go
          ];

          shellHook = ''
            export GOROOT="${pkgs.go}/share/go"
            export GOPATH="$PWD/.go"
            export PATH="$GOROOT/bin:$GOPATH/bin:$PATH"
          '';
        };
      }
    );
}
