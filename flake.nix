{
  description = "Nix Flake for Youtarr (YouTube DVR)";

  nixConfig = {
    extra-substituters = [
      "https://icebluerabbit-youtarr-flake.cachix.org"
    ];
    extra-trusted-public-keys = [
      "icebluerabbit-youtarr-flake.cachix.org-1:/SRfDLs8Un3uuJdizztndPNu6AOVNBdGgcXM7C9MLd0="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      flake-parts,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      perSystem =
        {
          config,
          self',
          pkgs,
          system,
          ...
        }:
        {
          formatter = pkgs.nixfmt-tree;

          packages = rec {
            youtarr-client = pkgs.callPackage ./pkgs/youtarr-client.nix { };
            youtarr = pkgs.callPackage ./pkgs/youtarr.nix { inherit youtarr-client; };
            docs = pkgs.callPackage ./modules/docs.nix { inherit youtarr; };
            default = youtarr;
          };

          apps.generate-docs = {
            type = "app";
            program = "${pkgs.writeShellScript "generate-docs" ''
              echo "==> Generating and copying Youtarr options documentation..."
              mkdir -p docs
              cp -f ${self'.packages.docs}/NIXOS_OPTIONS.md docs/NIXOS_OPTIONS.md
              echo "==> Done!"
            ''}";
          };

          checks = pkgs.lib.optionalAttrs pkgs.stdenv.isLinux {
            youtarr-integration-test = pkgs.testers.runNixOSTest {
              name = "youtarr-integration-test";

              nodes.machine = { pkgs, ... }: {
                imports = [ self.nixosModules.youtarr ];

                services.mysql = {
                  enable = true;
                  package = pkgs.mariadb;
                  initialScript = pkgs.writeText "mariadb-init" ''
                    CREATE DATABASE IF NOT EXISTS youtarr;
                    CREATE USER IF NOT EXISTS 'youtarr'@'localhost' IDENTIFIED BY 'test_password';
                    GRANT ALL PRIVILEGES ON youtarr.* TO 'youtarr'@'localhost';
                    CREATE USER IF NOT EXISTS 'youtarr'@'127.0.0.1' IDENTIFIED BY 'test_password';
                    GRANT ALL PRIVILEGES ON youtarr.* TO 'youtarr'@'127.0.0.1';
                    FLUSH PRIVILEGES;
                  '';
                };

                services.youtarr = {
                  enable = true;
                  package = self'.packages.youtarr;
                  # Specify database connection for Youtarr service
                  database = {
                    host = "127.0.0.1";
                    user = "youtarr";
                    name = "youtarr";
                    passwordFile = pkgs.writeText "youtarr-db-password" ''
                      DB_PASSWORD=test_password
                    '';
                  };
                };

                # Disable auto-start on boot in the VM so we can control startup sequence in the test script
                systemd.services.youtarr.wantedBy = pkgs.lib.mkForce [ ];
              };

              # Test script executed inside the virtual machine
              testScript = ''
                machine.wait_for_unit("mysql.service")
                machine.wait_for_open_port(3306)
                machine.start_job("youtarr.service")
                try:
                    machine.wait_for_open_port(3011, timeout=60)
                    machine.succeed("curl -f http://127.0.0.1:3011/api/health")
                except Exception as e:
                    machine.log(machine.succeed("journalctl -u youtarr.service --no-pager"))
                    raise e
              '';
            };
          };
        };

      flake = {
        nixosModules.youtarr = import ./modules/nixos.nix;
        nixosModules.default = self.nixosModules.youtarr;

        lib.settingsOption = import ./modules/settings.nix;
      };
    };
}
