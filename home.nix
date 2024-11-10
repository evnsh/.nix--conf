{ config, pkgs, ... }:

{
  home.username = "evan";
  home.homeDirectory = "/home/evan";

  home.backupFileExtension = "backup";
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    # Add any additional user-specific packages here
  ];

  programs.git = {
    enable = true;
    userName = "evan";
    userEmail = "me@evan.sh";
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch --flake /etc/nixos#";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "docker" ];
    };
  };

  programs.starship = {
    enable = true;
  };

  # Add more home-manager configurations as needed
}
