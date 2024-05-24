## A Simple NixOS Configuration

NixOS is an operating system based on the package manager 'nix'.
This repo will get you working a working configuration quickly and will teach you 
about nix (the language) and how to configure stuff without the thousands of pitfalls I had to endure.

Some links that may be of use:

- https://nixos.org/learn/
- https://github.com/Misterio77/nix-starter-configs/tree/main (Original configuration this is based on)
- https://github.com/MattCairns/nixos-config (I stole stuff from his repo)

## General configuration quickstart

Notes: 
- I'm pretty sure this ONLY works on NixOS
- Only tested with Intel CPU and Nvidia graphics but should work (as it's basically stock)

```bash
export NIX_CONFIG="experimental-features = nix-command flakes"
nix-shell -p git
nix shell nixpkgs#home-manager
cd ~/Documents
git clone https://github.com/syshotdev/beginner-nixos-config.git nixos-config 
cd nixos-config
nixos-generate-config
cp /etc/nixos/hardware-configuration.nix computers/default
sudo nixos-rebuild switch --flake .#default
home-manager switch --flake .#default@default
```

To explain what's happening here, we're making sure we have dependencies to compile nixos,
going into the `Documents` folder, cloning this repository, and we compile the computer "default" and the user "default".


## Configuration structure

It's best to understand this structure (To know where to put things) but you can skip over this section.

- flake.nix
- modules
  - home
  - system

- computers  (Houses all of the computer-specific configurations)
  - base.nix (Base settings for all computers)
  - default
    - configuration.nix
  - nixos
    - configuration.nix
    - hardware-configuration.nix (Specifically my hardware, in tutorial you'll get your own)

- users
  - default
    - default.nix
  - neck
    - default.nix

Here's how to read this:
Each bullet point has a file, and anything to the right and down of that file is imported.


- The `modules` directory has two parts. `home` and `system`.
- `home` is all of the packages that can be imported via *home-manager*,
- and `system` is stuff that configures the system as a whole, like drivers and desktop environments.

From computers, `configuration.nix` imports modules for the entire system, like drivers and system-level packages. 
It also defines what users it uses on the system.

`users` is a directory that has configurations for specific users, like username, packages, and
user-specific configurations.

Each main folder will (in the future) have a README with more information about it's purpose.

## Defining a new computer

Assuming you are cd'ed in the "nixos-config" directory, you can run these commands to make a new computer configuration.
- Note: COMPUTER_NAME should be changed to what you want your computer to be called
```bash
cd computers/
mkdir COMPUTER_NAME
cp nixos/configuration.nix COMPUTER_NAME
```
To explain what these commands do:
- `cd` goes into a directory, this case the *computers* directory
- `mkdir` (mk)es (dir)ectory, calls it whatever you specified
- `cp` means *copy*, and it takes a source path and a destination path 
This use of `cp` copies my configuration.nix to your computer's configuration folder

Now you need to add your hardware-configuration.nix to your computer configuration.
Usually your hardware-configuration is located at `/etc/nixos/` but maybe your computer is different.
```bash
cp /etc/nixos/hardware-configuration.nix ./COMPUTER_NAME
```

```bash
cd .. # Go up one level
```
Find this line in the flake.nix file, replace COMPUTER_NAME with what you named your computer and save the file.
```nix
# flake.nix
computer = "COMPUTER_NAME";
```

## Defining a new user

To add a new user, cd into the `users` directory and copy the default.
(Replace USERNAME with the username that you want)
```bash
cd users/
cp -r default USERNAME
```

Now, edit the text inside of the USERNAME/default.nix
You'll find lines named user, nickname, and email. Fill those in.
```nix
# USERNAME.nix

# TODO: Change these!
user = "john";
nickname = "Ilovecats0013";
email = "default@default.com";
```

Nickname means online name, which could be the same as your computer USERNAME.

Save the file.

```bash
cd .. # Go to the top folder for next instruction
```

Next, in flake.nix, edit the file and find the line named homeConfigurations
```nix
# flake.nix
homeConfigurations = {
  ...
}
```
Copy the `"default@${computer}"` all the way to the curly bracket after `modules`,
and paste it back into homeConfigurations as it looks now.
Rename all *default*'s in your new copied code to what your USERNAME is.

Lastly, edit your computer's configuration.nix and find the lines where users.users is defined.
```nix
users.users = {
  "neck" = {
    ...
  };
};
```
You can replace the "neck" with your USERNAME, or make a new user with your USERNAME.

## Applying the configuration

Earlier there were commands for building the configuration.
Here they are now, you can run them (hopefully) without any hiccups.

- Make sure you're running Nix 2.4+, and opt into the experimental `flakes` and `nix-command` features:
```bash
# Should be 2.4+
nix --version
export NIX_CONFIG="experimental-features = nix-command flakes"
```

- Run `sudo nixos-rebuild switch --flake .#computer` to apply your system
  configuration.
- Run `home-manager switch --flake .#username@computer` to apply your home
  configuration.
  - If you don't have home-manager installed, try `nix shell nixpkgs#home-manager`.

## Changing packages per-user

Go into the users/USERNAME/default.nix and you'll find `imports`.
Or for packages that you don't need to configure: `home.packages` and [add any package you want.](https://search.nixos.org)

## Adding modules in an organized way

Modules are configurations to your system like a new package, configuration to a package, configuration
to the system (like boot options), themes, etc. Since modules are *modular*, you can enable/disable them
very easily.

However, since they have an enable option and disable option, they take more code to include and organize.



## Total hours spent: like 50 hr
