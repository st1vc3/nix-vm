{ pkgs, ... }: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "dev";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Vienna";
  console.keyMap = "de";

  # The Hyprland package ships a "Hyprland (uwsm-managed)" session too,
  # which only works with uwsm enabled.
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  services.displayManager.defaultSession = "hyprland-uwsm";
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.xserver.xkb.layout = "de";

  users.users.stiven = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "changeme";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICla91Ky/VtQH7fxIoRPfd/t6OuX8q9CEEVIW0gFyONg"
    ];
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.PermitRootLogin = "no";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  environment.systemPackages = with pkgs; [
    fastfetch
    git
    kitty # Hyprland's default config opens kitty on Super+Q
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "26.05";
}
