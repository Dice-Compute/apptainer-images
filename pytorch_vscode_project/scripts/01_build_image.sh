#!/bin/bash
set -euo pipefail

ROOT_DIR="$(dirname "${BASH_SOURCE[0]}")/.."
IMG_DIR="$ROOT_DIR/images"
DEF_DIR="$ROOT_DIR/def-files"

mkdir -p "$IMG_DIR"

echo "🔨 Building image …"
apptainer build --fakeroot "$IMG_DIR/pytorch_vscode.sif" \
              "$DEF_DIR/pytorch_vscode.def"
echo "✅ Image ready: $IMG_DIR/pytorch_vscode.sif"
