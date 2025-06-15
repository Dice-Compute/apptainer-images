# Apptainer Container Management Scripts

This repository contains shell scripts to simplify the management of Apptainer (formerly Singularity) containers. These scripts help you build images, create overlays, start and stop container instances, and list running instances.

## Prerequisites

* Apptainer installed
* Shell (bash recommended)
* Linux-based OS (tested on Ubuntu)

## Directory Structure

```
.
├── images/
│   └── ubuntu22_shell.sif
├── overlays/
├── def-files/
│   └── ubuntu22_shell.def
└── scripts/
    ├── 01_build_image.sh
    ├── 02_create_overlay.sh
    ├── 03_start_instance.sh
    ├── 04_stop_instance.sh
    └── 05_list_instances.sh
```

## Scripts Explanation and Usage

### 1. `01_build_image.sh`

Builds an Apptainer image (`.sif`) from a definition file.

**Usage:**

```bash
./01_build_image.sh
```

### 2. `02_create_overlay.sh`

Creates overlay directories for persistent storage.

**Usage:**

```bash
./02_create_overlay.sh <username>
```

### 3. `03_start_instance.sh`

Starts an Apptainer container instance.

**Arguments:**

* `<username>`: Required. User-specific overlay.
* `<persistent>`: Optional (`true` or `false`). Default is `false`.
* `<use_gpu>`: Optional (`true` or `false`). Default is `false`.
* `<port>`: Optional. Default is `7681`.

**Usage:**

Persistent instance:

```bash
./03_start_instance.sh username true false 7681
```

Ephemeral instance:

```bash
./03_start_instance.sh username false false 7681
```

### 4. `04_stop_instance.sh`

Stops the specified Apptainer container instance.

**Usage:**

```bash
./04_stop_instance.sh <username>
```

### 5. `05_list_instances.sh`

Lists all running Apptainer instances.

**Usage:**

```bash
./05_list_instances.sh
```

## Quick Start

To quickly build an image, create an overlay, and start an instance:

```bash
./01_build_image.sh
./02_create_overlay.sh myusername
./03_start_instance.sh myusername true false 7681
```

Then open your browser and navigate to `http://localhost:7681`.

## Stopping and Cleanup

Stop the container:

```bash
./04_stop_instance.sh myusername
```

Check running instances:

```bash
./05_list_instances.sh
```

## License

MIT License - See LICENSE file for details.

