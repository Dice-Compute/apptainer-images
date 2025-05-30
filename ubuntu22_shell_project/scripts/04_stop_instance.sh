#!/bin/bash


set -euo pipefail

USERNAME=${1:?["username required"]}
INSTANCE_NAME="inst_${USERNAME}"

apptainer instance stop "$INSTANCE_NAME"
echo "🛑 Instance [$INSTANCE_NAME] stopped."

