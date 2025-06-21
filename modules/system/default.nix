# Add your reusable NixOS modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{ pkgs, ...}:
let
  # Function that imports a function and calls it with pkgs
  callModule = path: import path { inherit pkgs; };
in {
  optimizations = {
    gpu = callModule ./optimizations/gpu; # General GPU settings like optimizations
    nvidia = callModule ./optimizations/gpu/nvidia;
    #amd = callModule ./optimizations/gpu/amd;

    cpu = callModule ./optimizations/cpu; # General CPU optimizations (Find battery life settings there)
    intel-cpu = callModule ./optimizations/cpu/intel;
    #amd-cpu = callModule ./optimizations/cpu/amd;
  };
  vr = {
    monado = callModule ./vr/monado;
    simula = callModule ./vr/simula;
  };
  steam = callModule ./steam;
  kitty = callModule ./kitty;
}
