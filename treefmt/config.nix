{ lib, pkgs, ... }:
{
  settings = {
    # Configure nixfmt for .nix files
    formatter.nixfmt = {
      command = lib.getExe pkgs.nixfmt;
      includes = [ "*.nix" ];
    };

    formatter.nixf-diagnose = {
      command = lib.getExe pkgs.nixf-diagnose;
      # Specific diagnostics can be ignored using `--ignore`
      # See https://github.com/nix-community/nixd/blob/main/libnixf/src/Basic/diagnostic.py
      options = [
        "--auto-fix"
        "--ignore=sema-unused-def-lambda-witharg-formal"
      ];
      includes = [ "*.nix" ];
      # Make sure nixfmt cleans up after nixf-diagnose.
      priority = -1;
    };

    formatter.zizmor = {
      command = lib.getExe pkgs.zizmor;
      includes = [
        ".github/workflows/*.yml"
        ".github/workflows/*.yaml"
        ".github/actions/**/*.yml"
        ".github/actions/**/*.yaml"
      ];
    };

    formatter.actionlint = {
      command = lib.getExe pkgs.actionlint;
      includes = [
        ".github/workflows/*.yml"
        ".github/workflows/*.yaml"
      ];
    };

    formatter.keep-sorted = {
      command = lib.getExe pkgs.keep-sorted;
      includes = [ "*" ];
    };
  };
}
