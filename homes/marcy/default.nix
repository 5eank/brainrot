{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./arrpc.nix
    ./packages.nix # home.packages and similar stuff
    ./programs.nix # programs.<programName>.enable
    ./git.nix
    ./nvim-flake.nix
  ];

  home = {
    username = "marcy";
    homeDirectory = "/home/marcy";
    file.".config/lockonsleep/config.sh".source = ./lock.sh;
    file.".config/foot/foot.ini".source = ./foot.ini;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard-Mauve-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = ["mauve"];
        variant = "mocha";
      };
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    settings = import ./hyprland.nix;
  };

  programs.waybar = {
    enable = true;
    settings = import ./waybar.nix;
    style = import ./waybar-style.nix;
  };

  services.udiskie.enable = true;

  # let HM manage itself when in standalone mode
  programs.home-manager.enable = true;

  # Nicely reload system(d) units when changing configs
  systemd.user.startServices = lib.mkDefault "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
