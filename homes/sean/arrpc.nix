{
  inputs,
  pkgs,
  home,
  ...
}: {

  # provided by the arrpc-flake home-manager module
  services.arrpc.enable = true;
}
