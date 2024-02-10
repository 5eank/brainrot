{
 pkgs, ...}: {

  home.packages = with pkgs; [
    fastfetch
    firefox
    gparted
    obs-studio
    steam
    vesktop
    vlc
  ];
}
