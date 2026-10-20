# Apple Silicon VMs (UTM with the QEMU backend).
{ modulesPath, ... }: {
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "virtio_pci" "virtio_blk" "usbhid" ];

  disko.devices.disk.main.device = "/dev/vda";
}
