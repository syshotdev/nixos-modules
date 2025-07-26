# This is an addon to broadcast ollama to the the network.
# Requires "ollama" to already be configured, this is just an addon
# WARNING: FOR SOME REASON MAKES NIXOS NOT BOOT. I HAVE NO IDEA WHY.
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
