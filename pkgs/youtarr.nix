{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  makeWrapper,
  nodejs,
  ffmpeg,
  yt-dlp,
  atomicparsley,
  apprise,
  youtarr-client,
  nix-update-script,
}:

let
  pname = "youtarr";
  version = "1.78.0";
in
buildNpmPackage {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "DialmasterOrg";
    repo = "Youtarr";
    rev = "v${version}";
    hash = "sha256-RsFxUNQNAUMumYpPuFxqL6R345+sdmfx6KiOmFZMi10=";
  };

  # Use NodeJS required by Youtarr's package.json (engines: >=20.19.0)
  inherit nodejs;

  # Nix needs the hash of the npm dependencies.
  # We set this to fakeHash initially so Nix can calculate and print the correct one.
  npmDepsHash = "sha256-leMkR29Vuup9vaoVYL7yD90QFsfk2XB6YzusTAoYxLQ=";

  # The backend is a standard Express app without a build compilation step.
  dontNpmBuild = true;

  # Disable tests during build phase
  doCheck = false;

  # Patch relative config, images, jobs, setupToken, and archive paths to utilize
  # YOUTARR_CONFIG_PATH / runtime directories rather than the read-only Nix store.
  postPatch = ''
    substituteInPlace server/modules/configModule.js \
      --replace "path.join(__dirname, '../../config/config.json')" "process.env.YOUTARR_CONFIG_PATH || path.join(__dirname, '../../config/config.json')" \
      --replace "path.join(__dirname, '../../config/images')" "path.join(path.dirname(this.configPath), 'images')" \
      --replace "path.join(__dirname, '../../config/jobs')" "path.join(path.dirname(this.configPath), 'jobs')" \
      --replace "'/usr/bin/ffmpeg'" "'${lib.getExe ffmpeg}'" \
      --replace "'/usr/bin/AtomicParsley'" "'${lib.getExe atomicparsley}'"

    substituteInPlace server/modules/archiveModule.js \
      --replace "path.join(__dirname, '../../config', 'complete.list')" "process.env.YOUTARR_CONFIG_PATH ? path.join(path.dirname(process.env.YOUTARR_CONFIG_PATH), 'complete.list') : path.join(__dirname, '../../config', 'complete.list')"

    substituteInPlace server/modules/jobModule.js \
      --replace "path.join(__dirname, '../../config', 'complete.list')" "process.env.YOUTARR_CONFIG_PATH ? path.join(path.dirname(process.env.YOUTARR_CONFIG_PATH), 'complete.list') : path.join(__dirname, '../../config', 'complete.list')"

    substituteInPlace server/modules/setupTokenModule.js \
      --replace "path.join(__dirname, '../../config/setup-token')" "process.env.YOUTARR_CONFIG_PATH ? path.join(path.dirname(process.env.YOUTARR_CONFIG_PATH), 'setup-token') : path.join(__dirname, '../../config/setup-token')"
  '';

  nativeBuildInputs = [ makeWrapper ];

  # Copy server, migrations, and package config to the output libexec folder,
  # integrate the pre-built client static assets, and wrap the node executable.
  postInstall = ''
    mkdir -p $out/libexec/youtarr
    cp -r server migrations package.json node_modules $out/libexec/youtarr/

    # Copy the configuration template file expected by ConfigModule
    cp config/config.example.json $out/libexec/youtarr/server/config.example.json

    # Copy the pre-compiled React frontend static assets into the expected structure
    mkdir -p $out/libexec/youtarr/client/build
    cp -r ${youtarr-client}/* $out/libexec/youtarr/client/build/

    # Wrap the node binary, prefixing PATH with runtime dependencies
    makeWrapper ${nodejs}/bin/node $out/bin/youtarr \
      --add-flags "$out/libexec/youtarr/server/server.js" \
      --prefix PATH : ${
        lib.makeBinPath [
          nodejs
          ffmpeg
          yt-dlp
          atomicparsley
          apprise
        ]
      } \
      --set NODE_ENV "production"
  '';

  meta = with lib; {
    description = "Self-hosted YouTube DVR and automator";
    homepage = "https://github.com/DialmasterOrg/Youtarr";
    license = licenses.gpl3Only;
    maintainers = [ ];
    platforms = platforms.linux;
  };

  passthru.updateScript = nix-update-script;
}
