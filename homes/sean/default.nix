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
    username = "sean";
    homeDirectory = "/home/sean";
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

  # let HM manage itself when in standalone mode
  programs.home-manager.enable = true;

  # Nicely reload system(d) units when changing configs
  systemd.user.startServices = lib.mkDefault "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
