{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
    ../../shared
  ];

  networking = {
    hostName = "fragile";
    interfaces.enp3s0 = {
      useDHCP = false;
      wakeOnLan.enable = true;
      ipv4.addresses = [{
        address = "10.0.0.20";
        prefixLength = 24;
      }];
    };
    defaultGateway = {
      address = "10.0.0.254";
      interface = "enp3s0";
    };
    nameservers = [ "1.1.1.1" "1.0.0.1" "2606:4700:4700::1111" "2606:4700:4700::1001" ];
  };

  # Enable IPv6 privacy extensions
  boot.kernel.sysctl."net.ipv6.conf.all.use_tempaddr" = 2;
}
