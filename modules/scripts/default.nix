{ pkgs, ... }:
let
  # Helper function for making commands that you can execute via terminal
  mkScript = name: scriptPath: extraPkgs: pkgs.writeScriptBin name 
    (builtins.readFile scriptPath) {
      # Fundamental packages for execution
      coreutils = pkgs.coreutils;
      bash = pkgs.bash;

      # Extra packages required by script
      inherit extraPkgs;
    };

  # Define your scripts here
  scripts = [
    # TODO: Find a way to add bannedwords.txt to the directory of FindBannedInFiles.sh
    (mkScript "find-banned-in-files" ./FindBannedInFiles.sh [ pkgs.ripgrep ])
    (mkScript "publicize-folder" ./PublicizeFolder.sh [])
    (mkScript "rebuild" ./RebuildSystem.sh [])
    (mkScript "vr-run" ./VrRun.sh [ pkgs.patchelf ])
  ];
in {
  # scripts = scripts, to access put scriptModules.scripts in imports and it'll install all of 'em
  inherit scripts;
}
