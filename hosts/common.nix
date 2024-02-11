{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = true;
    xkb.layout = "us";
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  programs.fish.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    cinnamon.nemo
    dbus
    gnome3.adwaita-icon-theme
    grim
    gtklock
    libsForQt5.qt5ct
    lxqt.lxqt-policykit
    mesa
    pavucontrol
    pulseaudio
    slurp
    swaybg
    swayidle
    swaynotificationcenter
    swayosd
    temurin-bin-18
    temurin-jre-bin-8
    udiskie
    wget
    wl-clipboard
    wofi
    xdg-utils
    wvkbd
  ];

  fonts.packages = with pkgs; [
    font-awesome
    jetbrains-mono
    nerdfonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    source-han-sans
    source-han-sans-japanese
    source-han-serif-japanese
  ];

  fonts.fontconfig.defaultFonts = {
    serif = ["Noto Serif" "Source Han Serif"];
    sansSerif = ["Noto Sans" "Source Han Sans"];
  };

  services.dbus.enable = true;
  services.lvm.enable = true;
  services.printing.enable = true;
  services.udisks2.enable = true;
  services.acpid.enable = true;
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

  security.polkit.enable = true;

  systemd = {
    user.services.polkit-lxqt = {
      description = "polkit-lxqt";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
	ExecStart = "${pkgs.lxqt.lxqt-policykit}/bin/lxqt-policykit-agent";
	Restart = "on-failure";
	RestartSec = 1;
	TimeoutStopSec = 10;
      };
    };
  };

  users.defaultUserShell = pkgs.fish;

  system.stateVersion = "24.05";
}
