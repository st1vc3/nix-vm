# nix-vm

Minimal NixOS dev VM for Apple Silicon (`dev-arm`) and x86_64 (`dev-x86`):
Hyprland, SDDM, Neovim, fastfetch. Disk layout is declared with
[disko](https://github.com/nix-community/disko), so partitioning is part of the config.

| Host      | Arch    | Target                         | Disk       |
|-----------|---------|--------------------------------|------------|
| `dev-arm` | aarch64 | UTM (QEMU backend)             | `/dev/vda` |
| `dev-x86` | x86_64  | vSphere, Hyper-V (KVM: `vda`)  | `/dev/sda` |

## Install

1. Boot the NixOS minimal ISO for your architecture (nixos.org/download).
   The VM needs UEFI and 3D acceleration (UTM: display `virtio-gpu-gl-pci`).
2. In the installer, check the disk name with `lsblk` and fix `hosts/*.nix` if it differs.
3. Run:

```bash
sudo -i
HOST=dev-arm                       # or dev-x86
nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- \
  --mode destroy,format,mount --flake github:st1vc3/nix-vm#$HOST
nixos-install --flake github:st1vc3/nix-vm#$HOST --no-root-passwd
poweroff                           # remove the ISO, then boot
```

   To change something before installing, `git clone https://github.com/st1vc3/nix-vm`
   (via `nix-shell -p git`) and use `.#$HOST` instead.

4. Log in as `stiven` / `changeme` in SDDM (session: Hyprland), open a terminal with
   Super+Q and run `passwd`.

## Update

```bash
git clone https://github.com/st1vc3/nix-vm ~/nix-vm && cd ~/nix-vm
sudo nixos-rebuild switch --flake .#dev-arm
nix flake update                   # bump nixpkgs, then rebuild again
```
