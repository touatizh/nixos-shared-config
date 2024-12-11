{
  description = "Development environments for various use cases";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
      # Python Development Shell
      devShells.${system} = {
        python = pkgs.mkShell {
            buildInputs = with pkgs; [
              python313
              poetry
              black
              ruff
            ];
            shellHook = ''
            echo "Welcome to the Python Development Shell!"
            '';
        };

        # JavaScript/Node.js Development Shell
        js = pkgs.mkShell {
            buildInputs = with pkgs; [
              nodejs
              eslint
              typescript
            ];
            shellHook = ''
            echo "Welcome to the JS/TS Development Shell!"
            '';
        };

        # C# Development Shell
        csharp = pkgs.mkShell {
            buildInputs = with pkgs; [
              dotnet-sdk
            ];
           	shellHook = ''
            echo "Welcome to the C# Development Shell!"
            '';
        };

      # Database Development Shell
        db = pkgs.mkShell {
            buildInputs = with pkgs; [
              postgresql
              sqlite
              mysql
            ];
        shellHook = ''
          echo "Welcome to the Database Development Shell!"
        '';
      };
    };
  };
}
