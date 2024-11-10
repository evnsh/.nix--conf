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
    cursor-arm.packages.aarch64-linux.default
    zed-editor
    asahi-bless
  ];
}
