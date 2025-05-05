{ pkgs, config, ... }:
let
  # Helper function for making commands that you can execute via terminal
  mkTerminalScript = name: scriptPath:
    (pkgs.writeScriptBin name (builtins.readFile scriptPath));
in {
  # I really should figure out a way to OPTIONALLY add these scripts
  environment.systemPackages = with pkgs; [
    # TODO: Find a way to add bannedwords.txt to the directory of FindBannedInFiles.sh
    # Looking at it again, the forum thread that I made had the answer lol,
    # I just forgot to listen to him. Poor guy
    ripgrep
    (mkTerminalScript "find-banned-in-files" ./FindBannedInFiles.sh)
    (mkTerminalScript "publicize-folder" ./PublicizeFolder.sh)
    (mkTerminalScript "rebuild" ./RebuildSystem.sh)
    patchelf
    (mkTerminalScript "vr-run" ./VrRun.sh)
    ntfs3g
    (mkTerminalScript "force-mount-drive" ./ForceMountDrive.sh)
  ];
}
