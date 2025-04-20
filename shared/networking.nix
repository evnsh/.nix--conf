{ config, lib, pkgs, ... }:

{
  networking = {
    # Firewall configuration
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 139 445 ]; # Allow SSH, web ports, and Samba
      allowedUDPPorts = [ 137 138 ]; # Allow Samba UDP ports
      allowPing = true;
    };

    # Use systemd-resolved for DNS resolution
    useNetworkd = true;
    useDHCP = false; # Let systemd-networkd handle DHCP
  };

  # Enable and configure encrypted DNS with Cloudflare
  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = [ "~." ];
    fallbackDns = [ "1.1.1.1" "1.0.0.1" "2606:4700:4700::1111" "2606:4700:4700::1001" ];
    extraConfig = ''
      MulticastDNS=yes
    '';
  };
}