#!/usr/bin/env bash

set -e

die() {
	local error="${1:-Not Specified}"

	echo "ERROR: ${error}"
	exit 1
}

which nix &>/dev/null || die "Nix is not on path"

NIX="$(which nix) \
  --extra-experimental-features nix-command \
  --extra-experimental-features flakes"

${NIX} build github:cfcosta/neovim.nix

XDG_CONFIG_HOME=result/home-files/.config result/home-path/bin/nvim
