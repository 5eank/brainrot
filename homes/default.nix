{
  inputs,
  self,
  config,
  ...
}: {
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs self;
      inherit (config.networking) hostName;
    };
    users = {
      sean = ./sean;
      # more users can go here, the format is only for convenience
    };
  };
}
