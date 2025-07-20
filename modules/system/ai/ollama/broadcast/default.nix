# This is an addon to broadcast ollama to the the network.
# Requires "ollama" to already be configured, this is just an addon
{ pkgs, ... }: {
  services.ollama = {
    enable       = true;
    models       = "/var/lib/ollama/models";

    # Open up ollama to the network
    openFirewall = true;
    host         = "0.0.0.0";
    port         = 11434;
  };
}
