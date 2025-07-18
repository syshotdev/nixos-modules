# Add your reusable NixOS modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{...}: {
  # List your module files here
  ai = import ./ai;
  optimizations = import ./optimizations;
  vr = import ./vr;
  steam = ./steam;
  kitty = ./kitty;
}
