#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$SCRIPT_DIR/.."

DEF_FILE="$ROOT_DIR/def-files/ubuntu22_shell.def"
SIF_FILE="$ROOT_DIR/images/ubuntu22_shell.sif"

apptainer build "$SIF_FILE" "$DEF_FILE"

