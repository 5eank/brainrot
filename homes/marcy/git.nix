_: {
  # enable programs
  programs = {
    git = {
      enable = true;
      userName = "5eank";
      userEmail = "seankhouas@outlook.com";
      extraConfig = {
        commit.gpgsign = true;
        gpg.format = "ssh";
        user.signingkey = "~/.ssh/id_ed25519.pub";
        init.defaultBranch = "master";
      };
    };
    # ... add more programs as you see fit
  };
}
