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
    shares = {
      shared = { path = "/data/shared"; users = [ "brandon" "evan" ]; readOnly = false; };
      evan = { path = "/data/evan"; users = [ "evan" ]; readOnly = false; };
      brandon = { path = "/data/brandon"; users = [ "brandon" ]; readOnly = false; };
      timemachine = { path = "/data/timemachine"; users = [ "brandon" "evan" ]; readOnly = false; };
    };
  };

  # Ensure the directories exist
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

  # Plex Media Server configuration
  services.plex = {
    enable = true;
    openFirewall = true;
  };

  # MinIO configuration for block storage
  services.minio = {
    enable = true;
    region = "eu-west-3";
    dataDir = [ "/block-data" ];
  };

  # System packages for Plex and MinIO
  environment.systemPackages = with pkgs; [
    pkgs.plex
    pkgs.minio
  ];
}
