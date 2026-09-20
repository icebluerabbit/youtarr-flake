{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  nix-update-script,
}:

buildNpmPackage rec {
  pname = "youtarr-client";
  version = "1.84.1";

  src = fetchFromGitHub {
    owner = "DialmasterOrg";
    repo = "Youtarr";
    rev = "v${version}";
    hash = "sha256-z2BFTUZmYyRCruoDXrn6EwlUIU6gli4SnJ2RH4OGgPo=";
  };

  sourceRoot = "source/client";

  # Nix needs the hash of the npm dependencies.
  # We set this to fakeHash initially so Nix can calculate and print the correct one.
  npmDepsHash = "sha256-uAAI/RctjyutBYFDA9BGuvwCq+XqwNDEfoWbuIkiDyI=";

  # Disable running checkPhase (tests) since we only want to build the production bundle
  doCheck = false;

  # Vite build puts compiled production assets in the 'build' directory.
  # We copy this built static folder to the output directory.
  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp -r build/* $out/
    runHook postInstall
  '';

  passthru.updateScript = nix-update-script;
}
