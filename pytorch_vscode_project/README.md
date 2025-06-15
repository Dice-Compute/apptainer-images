# Apptainer Management for PyTorch and VSCode Containers

This repository provides convenient shell scripts to manage container instances designed specifically for PyTorch with integrated VSCode support, utilizing Apptainer (formerly Singularity).

## Requirements

* Apptainer
* Bash shell
* Linux OS (recommended Ubuntu)

## Project Structure

```
.
├── images/
│   └── pytorch_vscode.sif
├── overlays/
├── def-files/
│   └── pytorch_vscode.def
└── scripts/
    ├── 01_build_image.sh
    ├── 02_create_overlay.sh
    ├── 03_start_instance.sh
    ├── 04_stop_instance.sh
    └── 05_list_instances.sh
```

## Usage and Description

### 1. `01_build_image.sh`

Builds an Apptainer container image (`pytorch_vscode.sif`) from the provided definition file.

```bash
./01_build_image.sh
```

### 2. `02_create_overlay.sh`

Creates an overlay directory for persistent storage.

```bash
./02_create_overlay.sh <username>
```

### 3. `03_start_instance.sh`

Starts a container instance with PyTorch and VSCode.

#### Arguments:

* `<username>` (required): Identifies user-specific resources.
* `<persistent>` (optional, default: `false`): Enable persistence.
* `<use_gpu>` (optional, default: `false`): Enable GPU support.
* `<port>` (optional, default: `8888`): Port to access VSCode interface.

#### Examples:

Persistent instance:

```bash
./03_start_instance.sh myusername true true 8888
```

Ephemeral instance:

```bash
./03_start_instance.sh myusername false false 8888
```

Then open your browser to:

```
http://localhost:8888
```

### 4. `04_stop_instance.sh`

Stops a running Apptainer instance.

```bash
./04_stop_instance.sh <username>
```

### 5. `05_list_instances.sh`

Lists all active Apptainer container instances.

```bash
./05_list_instances.sh
```

## Quick Start Guide

Execute these commands sequentially for a quick setup:

```bash
./01_build_image.sh
./02_create_overlay.sh yourusername
./03_start_instance.sh yourusername true false 8888
```

Open your browser at:

```
http://localhost:8888
```

## Cleanup

Stop the container instance:

```bash
./04_stop_instance.sh yourusername
```

List running instances:

```bash
./05_list_instances.sh
```


