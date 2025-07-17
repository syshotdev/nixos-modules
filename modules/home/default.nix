{ pkgs, ...}:
let
  # Function that imports a function and calls it with pkgs
  callModule = path: import path { inherit pkgs; };
in {
  development = {
    neovim = callModule ./development/neovim;
  };
  art = import ./art;
  games = import ./games;
  communication = import ./communication;
  sound = import ./sound;
  other = import ./other;
}
