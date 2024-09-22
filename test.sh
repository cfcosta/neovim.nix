#!/usr/bin/env bash

set -e

die() {
  local error="${1:-Not Specified}"

  echo "ERROR: ${error}"
  exit 1
}

which nix &>/dev/null || die "Nix is not on path"

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

NIX="nix \
  --extra-experimental-features nix-command \
  --extra-experimental-features flakes"

${NIX} run "${ROOT}#"
