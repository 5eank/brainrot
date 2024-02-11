{
 pkgs, ...}: {

  home.packages = with pkgs; [
    fastfetch
    firefox
    gparted
    nwg-launchers
    obs-studio
    steam
    vesktop
    vlc
  ];
}
