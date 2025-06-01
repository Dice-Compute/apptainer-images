#!/bin/bash


set -euo pipefail

USERNAME=${1:?["username required"]}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$SCRIPT_DIR/.."
OVERLAY_DIR="$ROOT_DIR/overlays/${USERNAME}_overlay"

if [[ -d "$OVERLAY_DIR" ]]; then
  echo "Overlay directory already exists: $OVERLAY_DIR"
else
  mkdir -p "$OVERLAY_DIR/upper" "$OVERLAY_DIR/work"
  echo "Overlay directory created: $OVERLAY_DIR"
fi

