# The terminal that this nixos instance uses
# I picked kitty because unicode support, hardware accel, tilability, fuzzy finding, and more
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    kitty
  ];

  fonts.packages = with pkgs; [
    nerdfonts
    jetbrains-mono
  ];

  # Link Kitty configuration
  environment.etc."xdg/kitty/kitty.conf".source = ./kitty.conf;
  environment.etc."xdg/kitty/gruvbox.conf".source = ./gruvbox.conf;

  # Set kitty as default terminal
  environment.variables = {
    TERMINAL = "kitty";
  };
}
