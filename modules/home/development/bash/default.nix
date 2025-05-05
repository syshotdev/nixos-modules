
{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [ 
    fzf
    fd
    bashInteractive
    bash-completion
  ];

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      # load completions from the bash-completion package in $HOME/.nix-profile
      if [ -f "${pkgs.bash-completion}/etc/bash_completion" ]; then
        source "${pkgs.bash-completion}/etc/bash_completion"
      fi
    '';
  };
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };
  programs.fd = {
    enable = true;
  };
}
