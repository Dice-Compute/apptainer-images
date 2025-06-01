#!/bin/bash

set -euo pipefail

USERNAME=${1:?["username required"]}
PERSISTENT=${2:-false}
USE_GPU=${3:-false}
PORT=${4:-8888}
INSTANCE_NAME="inst_${USERNAME}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$SCRIPT_DIR/.."
IMG="$ROOT_DIR/images/pytorch_vscode.sif"
OVERLAY_DIR="$ROOT_DIR/overlays/${USERNAME}_overlay"

CMD=(apptainer instance start --fakeroot --cleanenv --containall \
     --home /home/${USERNAME} \
     --env PASSWORD=coder)

[[ "$USE_GPU" == "true" ]] && CMD+=(--nv)

if [[ "$PERSISTENT" == "true" ]]; then
  "$SCRIPT_DIR/02_create_overlay.sh" "$USERNAME"
  CMD+=(--overlay "$OVERLAY_DIR")
  echo "Starting *persistent* instance $INSTANCE_NAME …"
else
  CMD+=(--writable-tmpfs)
  echo "Starting *ephemeral* instance $INSTANCE_NAME …"
fi

apptainer instance stop "$INSTANCE_NAME" >/dev/null 2>&1 || true

CMD+=(--env PORT="$PORT" "$IMG" "$INSTANCE_NAME")

echo "${CMD[*]}"
"${CMD[@]}"

echo "Instance [$INSTANCE_NAME] is running."
echo "Open: http://localhost:${PORT}"

