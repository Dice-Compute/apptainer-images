#!/bin/bash
# Start web-based shell instance (Apptainer Run instead of Instance Start)

set -euo pipefail

USERNAME=${1:?["username required"]}
PERSISTENT=${2:-false}
USE_GPU=${3:-false}
PORT=${4:-7681}
INSTANCE_NAME="inst_${USERNAME}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$SCRIPT_DIR/.."
IMG="$ROOT_DIR/images/ubuntu22_shell.sif"
OVERLAY_DIR="$ROOT_DIR/overlays/${USERNAME}_overlay"

CMD=(apptainer run --fakeroot --cleanenv --containall \
     --home /home/${USERNAME} \
     --env PASSWORD=coder)

[[ "$USE_GPU" == "true" ]] && CMD+=(--nv)

if [[ "$PERSISTENT" == "true" ]]; then
  "$SCRIPT_DIR/02_create_overlay.sh" "$USERNAME"
  CMD+=(--overlay "$OVERLAY_DIR")
  echo "Starting *persistent* container $INSTANCE_NAME …"
else
  CMD+=(--writable-tmpfs)
  echo "Starting *ephemeral* container $INSTANCE_NAME …"
fi

CMD+=(--env PORT="$PORT" "$IMG")

echo "${CMD[*]}"
"${CMD[@]}"

echo "Container [$INSTANCE_NAME] is running."
echo "Open your browser: http://localhost:${PORT}"

