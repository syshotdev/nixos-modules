{ pkgs, ...}:
let
  # Function that imports a function and calls it with pkgs
  callModule = path: import path { inherit pkgs; };
in {
  development = {
    neovim = callModule ./development/neovim;
    bash = callModule ./development/bash;
    vs-code = callModule ./development/vs-code;
    git = ./development/git;
    godot4-mono = callModule ./development/godot4-mono;
  };
  art = {
    blender-cad = callModule ./art/blender-cad;
    video-editing = callModule ./art/video-editing;
    video-recording = callModule ./art/video-recording;
  };
  games = {
    minecraft = callModule ./games/minecraft;
  };
  communication = {};
  sound = {};
  other = {
    firefox = ./other/firefox;
  };
}
