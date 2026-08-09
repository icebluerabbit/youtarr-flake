# Youtarr Nix Flake

[![CI](https://github.com/icebluerabbit/youtarr-flake/actions/workflows/ci.yml/badge.svg)](https://github.com/icebluerabbit/youtarr-flake/actions/workflows/ci.yml)
[![Dependency Updates](https://github.com/icebluerabbit/youtarr-flake/actions/workflows/flake-update.yml/badge.svg)](https://github.com/icebluerabbit/youtarr-flake/actions/workflows/flake-update.yml)
[![Cachix Cache](https://img.shields.io/badge/Cachix-icebluerabbit--youtarr--flake-blue.svg)](https://icebluerabbit-youtarr-flake.cachix.org)
[![Nix Built](https://img.shields.io/badge/Nix-Flake-blue.svg?logo=nixos&logoColor=white)](https://nixos.org)

This repository provides a Nix Flake for [**Youtarr**](https://github.com/DialmasterOrg/Youtarr) (a self-hosted YouTube DVR and automator), containing the backend Node Express application package, the React client package, and fully configurable NixOS and Home Manager service modules.

---

## 📚 Documentation

*   [**NixOS Options (`docs/NIXOS_OPTIONS.md`)**](docs/NIXOS_OPTIONS.md): Configuration options for the NixOS service module.
*   [**Home Manager Options (`docs/HOME_MANAGER_OPTIONS.md`)**](docs/HOME_MANAGER_OPTIONS.md): Configuration options for the Home Manager service module.

---

## ✨ Key Features

*   **Stateless Server Packaging**: Bundles and wraps the Express backend with its runtime dependencies (`ffmpeg`, `yt-dlp`, `atomicparsley`, and `apprise`) directly into the final binary's `PATH`.
*   **Fully Managed Declarative Config**: Exposes a structured, typed `settings` schema that automatically generates and manages Youtarr's `config.json` at startup, ensuring your Nix files are the single source of truth.
*   **BYOB (Bring Your Own Database)**: Separates database concerns. Easily hook Youtarr up to an external MySQL/MariaDB instance while loading database credentials securely at runtime via a `passwordFile` (avoiding secret leaks in the read-only Nix store).

---

## ❄️ Nix Integration

Add Youtarr to your flake inputs:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    youtarr-flake.url = "github:icebluerabbit/youtarr-flake";
  };
}
```

### NixOS Module

Activate the module and declare settings system-wide:

```nix
{ inputs, pkgs, ... }: {
  imports = [ inputs.youtarr-flake.nixosModules.default ];

  services.youtarr = {
    enable = true;
    
    # Configure database options securely
    database = {
      host = "127.0.0.1";
      user = "youtarr";
      name = "youtarr";
      passwordFile = "/run/secrets/youtarr-db-password";
    };

    # Declaratively manage Youtarr's global preferences
    settings = {
      preferredResolution = "1080";
      channelAutoDownload = true;
      channelDownloadFrequency = "0 */6 * * *"; # check every 6 hours
      writeVideoNfoFiles = true;
      sponsorblockEnabled = true;
      sponsorblockAction = "remove";
    };
  };
}
```

### Home Manager Module

Declare settings on a per-user level using user systemd services:

```nix
{ inputs, ... }: {
  imports = [ inputs.youtarr-flake.homeManagerModules.default ];

  services.youtarr = {
    enable = true;
    
    database = {
      host = "127.0.0.1";
      user = "youtarr";
      name = "youtarr";
      passwordFile = "/home/user/.secrets/youtarr-db-password";
    };

    settings = {
      preferredResolution = "720";
      darkModeEnabled = true;
    };
  };
}
```

---

## ⚙️ Advanced Customization (Package Overrides)

If you want to use custom versions of the runtime dependency packages (such as a specific release of `yt-dlp` or a custom-compiled `ffmpeg`), you can set them directly via the module options:

```nix
services.youtarr = {
  # Swap out runtime packages with module options
  ffmpegPackage = pkgs.ffmpeg_7-headless;
  ytdlpPackage = pkgs.yt-dlp;
};
```

Alternatively, you can also override the package inputs at the derivation level using the standard `.override` pattern:

```nix
services.youtarr.package = inputs.youtarr-flake.packages.${pkgs.system}.default.override {
  # Use a custom yt-dlp package override
  yt-dlp = pkgs.yt-dlp.overrideAttrs (oldAttrs: {
    version = "2026.06.20";
    # ... custom attributes or patches
  });
};
```

---

## 🛠️ Development & Utilities

### Run Integration Tests
Launch the QEMU VM integrated system check to compile targets, bootstrap database fixtures, and verify that the backend initializes:
```bash
nix flake check -L
```

### Regenerate Option Reference Manuals
Rebuild the markdown documentation files from the Nix module schemas:
```bash
nix run .#generate-docs
```
