{ config, pkgs, ... }:

{
  # Define the evan user
  users.users.evan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.zsh;
    # We don't set a password here, as we're using SSH key authentication only
  };

  # Disable root login
  users.users.root.hashedPassword = "!";

  # Enable sudo for the wheel group without password
  security.sudo.wheelNeedsPassword = false;

  # Set up ZSH as the default shell for evan
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
    };
  };

  # Configure starship prompt
  programs.starship = {
    enable = true;
  };

  programs.git = {
    enable = true;
  };

  # Additional ZSH configuration
  environment.shellInit = ''
    eval "$(starship init zsh)"
  '';
}