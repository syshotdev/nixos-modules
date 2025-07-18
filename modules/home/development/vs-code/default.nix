{
  pkgs,
  ...
}: {
# TODO: Decouple this package from the flake.nix pkgs
# Basically, make this its own module that gets its own version
  home.packages = with pkgs; [ 
    platformio-core
    gcc
    gdb
    python310
  ];
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      catppuccin.catppuccin-vsc
      vscodevim.vim
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "auto-build";
        publisher = "MarlinFirmware";
        version = "2.1.61";
        sha256 = "sha256-rxpHBRlVnU+X+OVpdnOkJlpLxxRZU2kO3iwMB8UP+/c=";
      }
      {
        name = "platformio-ide";
        publisher = "platformio";
        version = "3.3.3";
        sha256 = "sha256-cVYnFhdeClHhuVaTWRU2IDIA1mFq1iLveZUIhEhMSck=";
      }
      {
        name = "remote-containers";
        publisher = "ms-vscode-remote";
        version = "0.395.0";
        sha256 = "sha256-dYqas9Tdp8brMMaGU4Sz1Qu3+rM0/aaErhPwlaawoaY=";
      }
    ];
  };
}
