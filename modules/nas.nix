{ config, lib, pkgs, ... }:

{
  # Additional users configuration
  users.users.brandon = {
    isNormalUser = true;
    hashedPassword = "$y$j9T$1MQNqfmCF.UzZurQ9JHuD0$U/6j2g5/n/ys5GkTrlg2yr/EH.hnkcCK1EjqDAiWkM6";
    home = "/data/brandon";
    extraGroups = [ "users" ];
    openssh.authorizedKeys.keys = [];
  };

  # Samba configuration for sharing
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "Samba NAS";
        "netbios name" = "nas";
        "security" = "user";
        "invalid users" = [ "root" ];
        "guest account" = "nobody";
        "map to guest" = "bad user";
        "browseable" = "yes";
        "writable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
      };
      "shared" = {
        path = "/data/shared";
        users = [ "brandon" "evan" ];
        readOnly = false;
      };
      "evan" = {
        path = "/data/evan";
        users = [ "evan" ];
        readOnly = false;
      };
      "brandon" = {
        path = "/data/brandon";
        users = [ "brandon" ];
        readOnly = false;
      };
      "timemachine" = {
        path = "/data/timemachine";
        "fruit:time machine" = "yes";
      };
    };
  };

  systemd.services.createDirectories = {
    description = "Create NAS user directories";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = "yes";
    };
    script = ''
      for dir in /data/brandon /data/evan /data/shared /data/shared/movies /data/shared/shows /data/timemachine; do
        mkdir -p "$dir"
      done
      chown -R brandon:users /data/brandon
      chown -R evan:users /data/evan
      chown -R users:users /data/shared
      chown -R users:users /data/shared/movies
      chown -R users:users /data/shared/shows
      chown -R users:users /data/timemachine
    '';
  };

  services.plex = {
    enable = true;
    openFirewall = true;
  };

  services.minio = {
    enable = true;
    region = "eu-west-3";
    dataDir = [ "/block-data" ];
  };

  services.tailscale = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    pkgs.plex
    pkgs.minio
    pkgs.tailscale
  ];
}
