# !/bin/bash
FZF_SHARE=/run/current-system/sw/share/fzf
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

if [[ $- == *i* ]]; then
  [ -f "$(FZF_SHARE)/key-bindings.bash" ] \
    && source "$(FZF_SHARE)/key-bindings.bash"
  [ -f "$(FZF_SHARE)/completion.bash" ] \
    && source "$(FZF_SHARE)/completion.bash"
fi
