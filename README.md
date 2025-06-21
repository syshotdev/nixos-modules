# WARNING: Under construction

Don't use this directly until this warning is removed.

If you would like to use specific modules, copy the code and refine it to your usecase.
Good luck!


## A Simple NixOS Configuration

NixOS is an operating system based on the package manager 'nix'.
This repo will get you working a working configuration quickly and will teach you 
about nix (the language) and how to configure stuff without the thousands of pitfalls I had to endure.

Some links that may be of use:

- https://nixos.org/learn/
- https://github.com/Misterio77/nix-starter-configs/tree/main (Original configuration this is based on)
- https://github.com/EmergentMind/nix-config (Documented(ish) nix config)
- https://github.com/MattCairns/nixos-config (I stole stuff from his repo)

## Features

- Mostly documented
- A sensible file structure
- Simple
- A quickstart
- Flakes
- Home-manager for user-specific configurations
- Computer-specific configurations
- Optional unstable packages (for more up-to-date packages)
- Custom-package examples
  - Appimage
  - From github
- Neatly organized modules
  - System stuff (drivers, system theme, system-wide programs, etc.)
  - User stuff (git, neovim, user-specific options) 
  - Overlays (Only used for unstable-packages)
  - Custom-packages (Examples of grabbing from online and building)
  - Scripts (Basically shortcuts that execute tedious operations)


# Specific modules
- Automatically setting up git
- Configured Neovim
- Configured Firefox
- Minecraft (Via Prismlauncher)
- Steam
- Video Recording & Editing Bundles
- GPU drivers
  - You manually import these
- CPU optimizations 
  - (Just so you know most Linux distros have these automatically, not NixOS)
- Other things
