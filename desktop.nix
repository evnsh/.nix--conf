{ config, lib, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    xkb = {
      variant = "";
      layout = "us";
    };
  };

  services.xserver.displayManager.gdm.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" "FantasqueSansMono" "FiraCode" ]; })
  ];

  environment.systemPackages = with pkgs; [
    hyprland
    hyprpaper
    sddm
    catppuccin-cursors.mochaDark
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    xdg-utils
    xwayland
    firefox
    wofi
    _1password-gui
    waybar
    armcord
    hyprcursor
    moonlight-qt
    hyprlock
    pamixer
    brightnessctl
    kitty
    dunst
  ];

  programs.zsh.enable = true;
  programs.starship.enable = true;
}
