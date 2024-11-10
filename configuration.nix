{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./apple-silicon-support
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  networking.hostName = "nixos";
  networking = {
    networkmanager.enable = true;
    networkmanager.wifi.backend = "iwd";
    wireless.iwd = {
      enable = true;
      settings.General.EnableNetworkConfiguration = true;
    };
  };

  time.timeZone = "Europe/Paris";

  users.users.evan = {
    initialPassword = "evan";
    isNormalUser = true;
    extraGroups = ["wheel" "docker"];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;
  security.sudo.wheelNeedsPassword = false;

  virtualisation.docker.enable = true;

  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  environment.systemPackages = with pkgs; [
    wget
    git
    neovim
    httpie
    whois
    neofetch
    btop
    killall
  ];

  system.stateVersion = "24.11";
}
