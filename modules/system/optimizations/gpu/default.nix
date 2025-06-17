{ config, lib, pkgs, ... }:
{
  hardware.opengl = {
    enable = true;
    # Mesa is general opengl drivers (I think)
    extraPackages = [ pkgs.mesa ];
  };
}
