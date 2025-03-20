{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./apple-silicon-support
    ../shared
  ];

  networking.hostName = "latte";
}
