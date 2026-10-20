# x86_64 VMs. vSphere (PVSCSI) and Hyper-V expose the disk as /dev/sda,
# KVM with virtio as /dev/vda.
{ lib, ... }: {
  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "sd_mod" "sr_mod" "virtio_pci" "virtio_blk" "vmw_pvscsi" "hv_storvsc" ];

  disko.devices.disk.main.device = lib.mkDefault "/dev/sda";
}
