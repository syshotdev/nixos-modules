{
  pkgs,
  ...
}: {

  home.packages = with pkgs; [ 
    platformio-core
    gcc
    gdb
    python39
  ];

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
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
        sha256 = "sha256-d8kwQVoG/MOujmvMaX6Y0wl85L2PNdv2EnqTZKo8pGk=";
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
