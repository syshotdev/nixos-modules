
{
  pkgs,
  ...
}: {
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };
  programs.fd = {
    enable = true;
  };

  home.packages = with pkgs; [ 
    fzf
    fd
    bashInteractive
    bash-completion
  ];
}
