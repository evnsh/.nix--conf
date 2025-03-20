{ config, pkgs, ... }:

{
  imports = [
    ./users.nix
    ./networking.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  # Shared configuration goes here
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";

  nixpkgs.config.allowUnfree = true;

  # Common system packages
  environment.systemPackages = with pkgs; [
    neovim
    git
    wget
    curl
    btop
    fastfetch
    starship
  ];

  # Enable some common services
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  system.stateVersion = "24.11";
}