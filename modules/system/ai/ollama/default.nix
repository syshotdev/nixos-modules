
{ pkgs, ... }: {
  # For use in neovim
  services.ollama = {
    enable       = true;
    package      = pkgs.ollama;
    models       = "/var/lib/ollama/models";
    acceleration = "cuda";
    host         = "127.0.0.1";
    port         = 11434;
  };
}
