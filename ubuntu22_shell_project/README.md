# 🐧 Container-Based Instance Manager with OverlayFS

This repository provides a collection of Bash scripts to build and manage lightweight, isolated Linux instances using OverlayFS and Linux namespaces — without relying on Docker or other container runtimes.

---

## 📦 Overview

The system simulates container-like environments by:

- Building a minimal Debian root filesystem
- Creating writable overlays per instance
- Running each instance with `unshare`, `chroot`, and its own namespace
- Allowing you to start, stop, and list isolated instances

This is ideal for educational purposes, testing Linux isolation concepts, or creating minimal container-like setups.

---

## ⚙️ Requirements

Make sure your system supports:

- Linux with OverlayFS support
- `sudo` privileges
- Installed tools:
  - `debootstrap`
  - `unshare` (from `util-linux`)
  - `iproute2`, `iputils-ping` (optional for testing from inside container)

---

## 📁 Directory Structure

```
.
├── image/
│   └── rootfs/                  # Base Debian root filesystem
├── instances/
│   └── <instance_name>/
│       ├── upper/               # Writable overlay
│       ├── work/                # Workdir for OverlayFS
│       ├── merged/              # Merged mount point
│       └── pidfile              # Stores instance PID
├── 01_build_image.sh            # Builds the rootfs using debootstrap
├── 02_create_overlay.sh         # Creates overlay dirs for an instance
├── 03_start_instance.sh         # Launches an isolated container
├── 04_stop_instance.sh          # Stops and cleans up the instance
└── 05_list_instances.sh         # Shows running instances
```

---

## 🚀 Usage

### 🔨 1. Build the Base Image

```bash
sudo ./01_build_image.sh
```

This uses `debootstrap` to download and extract a minimal Debian filesystem into `image/rootfs`.

---

### 🧱 2. Create an Overlay for an Instance

```bash
./02_create_overlay.sh <instance_name>
```

This creates a layered filesystem under `instances/<instance_name>/`:
- `upper/` — Writable layer for the instance
- `work/` — Required by OverlayFS
- `merged/` — Mount point where final FS is created

---

### 🧬 3. Start the Instance

```bash
sudo ./03_start_instance.sh <instance_name>
```

This will:
- Mount the overlay filesystem
- Use `unshare` to isolate the UTS, PID, and mount namespaces
- `chroot` into the `merged/` directory
- Launch a new shell

Inside the shell, you'll be running as root within an isolated environment.

---

### 🛑 4. Stop the Instance

```bash
sudo ./04_stop_instance.sh <instance_name>
```

- Reads the PID from `pidfile`
- Sends `SIGKILL` to the instance process
- Unmounts and cleans up the `merged/` mount point

---

### 📋 5. List Running Instances

```bash
./05_list_instances.sh
```

Lists all currently active containers (those with a `pidfile` and active process), along with their names and PIDs.

---

## 📌 Notes

- This does not set up network namespaces or virtual ethernet pairs — but you can extend it!
- It’s intended for educational/demo purposes — not production.
- You can install packages into the base image by entering it manually:

```bash
sudo chroot image/rootfs /bin/bash
```

---

## 🧠 Concepts Used

- **OverlayFS**: Combines read-only base image with writable upper layers.
- **Linux namespaces**: Isolate UTS, PID, and mount environments.
- **chroot**: Changes root filesystem to the merged overlay directory.
- **debootstrap**: Builds a minimal Debian system.

---
