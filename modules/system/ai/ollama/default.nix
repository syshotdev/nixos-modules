{ pkgs, ... }: {
  services.ollama = {
    enable       = true;
    package      = pkgs.ollama;
    models       = "/var/lib/ollama/models";
    acceleration = "cuda";
    # Network settings ommitted in case they conflict with "broadcast"
    # Defaults are correct for this file
  };
}
