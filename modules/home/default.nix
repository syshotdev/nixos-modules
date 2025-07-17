{ pkgs, ...}: {
  development = {
    neovim = ./development/neovim { inherit pkgs; };
  };
  art = import ./art;
  games = import ./games;
  communication = import ./communication;
  sound = import ./sound;
  other = import ./other;
}
