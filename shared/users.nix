{ config, pkgs, ... }:

{
  # Define the evan user
  users.users.evan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBACAZNMlh6YKmbFiTV3diL3p+1HpndHkRch98nJuGO8b2dx5WvdUg2bO2sKA+f6kT8fqpMFVjMYqANyTjtkFLVYocACCF+scZfnWr0lpGwN6P+mu6NIXcvtOy02nJE7G6TOgvwrbhs/KwwLU2TbJonQ9WnOwgEwWmvBdOQzFihXUpyeVBg== me@evan.sh"
    ];
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