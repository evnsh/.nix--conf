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

  # SSH key configuration
  users.users.evan.openssh.authorizedKeys.keys = [
    "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBACAZNMlh6YKmbFiTV3diL3p+1HpndHkRch98nJuGO8b2dx5WvdUg2bO2sKA+f6kT8fqpMFVjMYqANyTjtkFLVYocACCF+scZfnWr0lpGwN6P+mu6NIXcvtOy02nJE7G6TOgvwrbhs/KwwLU2TbJonQ9WnOwgEwWmvBdOQzFihXUpyeVBg== me@evan.sh"
  ];

  system.stateVersion = "24.11";
}