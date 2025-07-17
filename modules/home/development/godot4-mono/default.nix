{ pkgs ? import <nixpkgs> {} }:

# Call the package (aka build it into a package)
pkgs.callPackage (rec {
  pname = "godot4-mono";
  version = "4.2.2-stable";

  src = pkgs.fetchFromGitHub {
    owner = "godotengine";
    repo = "godot";
    rev = version;
    hash = "sha256-anJgPEeHIW2qIALMfPduBVgbYYyz1PWCmPsZZxS9oHI=";
  };

  buildInputs = [ pkgs.dotnet-sdk ];
}) {}

