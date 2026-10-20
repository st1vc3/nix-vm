{
  description = "Minimal NixOS dev VM (aarch64 + x86_64) with Hyprland";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, disko, ... }:
    let
      mkHost = system: host: nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          disko.nixosModules.disko
          ./disko.nix
          ./configuration.nix
          ./hosts/${host}.nix
        ];
      };
    in {
      nixosConfigurations = {
        dev-arm = mkHost "aarch64-linux" "arm";
        dev-x86 = mkHost "x86_64-linux" "x86";
      };
    };
}
