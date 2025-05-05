# !/bin/bash
# Credits to ChatGPT for making this entire script
# UNFINISHED!!! DO NOT USE, will open apps that should NOT open
# Such as: gtk login, background tasks, 10000 firefox programs
# Before you refactor this: test the script, I purposely made it save in the "~"
# directory, which really means "~/Programming/Nix/modules-repo/~". Sorry for the bug

mkdir -p "~/.local/session-saver"

# Make session.txt empty
> "~/.local/session-saver/session.txt"

# Loop over all running processes by the current user
for pid in $(pgrep -u "$USER"); do
  # Get the command name (executable path or name)
  cmd=$(ps -p "$pid" -o cmd= | awk '{print $1}')
  
  # Strip path if full path (e.g., /usr/bin/firefox → firefox)
  cmd_basename=$(basename "$cmd")

  # Try to find a .desktop file that matches the command
  desktop_file=$( \
    (ls /run/current-system/sw/share/applications ~/.nix-profile/share/applications 2>/dev/null || true) \
    | grep -i "${cmd_basename}.*\.desktop" \
    | head -n 1 \
  )

  # If a matching .desktop file is found, record its name
  if [[ -n "$desktop_file" ]]; then
    printf "$desktop_file\n"
    desktop_name=$(basename "$desktop_file")

    # Check if already added
    if [[ ! " ${seen[*]} " =~ " $desktop_name " ]]; then
      echo "$desktop_name" >> "~/.local/session-saver/session.txt"
      seen+=("$desktop_name")
    fi
  fi
done
