{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
    xkb.layout = "us";
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    dbus
    mesa
    pulseaudio
    temurin-bin-18
    temurin-jre-bin-8
    wget
  ];

  services.dbus.enable = true;
  services.lvm.enable = true;
  services.printing.enable = true;
  services.udisks2.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.printing.drivers = [ pkgs.gutenprint ];

  console.useXkbConfig = true;

  networking.networkmanager.enable = true;

  boot.supportedFilesystems = [ "exfat" "ntfs" "xfs"];
   
   nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.defaultUserShell = pkgs.fish;

  system.stateVersion = "24.05";
}
