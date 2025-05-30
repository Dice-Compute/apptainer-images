#!/bin/bash
set -euo pipefail

USERNAME=${1:?["username required"]}
INSTANCE_NAME="inst_${USERNAME}"

echo "🛑 Stopping instance: $INSTANCE_NAME"
apptainer instance stop "$INSTANCE_NAME"
