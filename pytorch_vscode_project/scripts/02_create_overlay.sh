#!/bin/bash

set -euo pipefail

USERNAME=${1:?["username required"]}
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OVERLAY_DIR="$SCRIPT_DIR/../overlays/${USERNAME}_overlay"

if [[ -d "$OVERLAY_DIR" ]]; then
  echo "ℹ️  Overlay directory already exists: $OVERLAY_DIR"
else
  echo "➕ Creating overlay directory for $USERNAME …"
  mkdir -p "$OVERLAY_DIR"
  chmod 700 "$OVERLAY_DIR"
  echo "✅ Overlay directory created: $OVERLAY_DIR"
fi
