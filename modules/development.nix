{ config, lib, pkgs, cursor-arm, ... }:

{
  environment.systemPackages = with pkgs; [
    nodejs_22
    gnumake
    docker-compose
    go
    python3
    clang
    kubectl
    zed-editor
    asahi-bless
  ];

  virtualisation.docker.enable = true;
}
