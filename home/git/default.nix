{
  config,
  pkgs,
  spaghetti,
  secrets,
  ...
}: {
  home-manager.users.${spaghetti.user}.programs.git = {
    enable = true;
    extraConfig = {
      credential.helper = "libsecret";
      user.name = "Quinn Edenfield";
      user.email = "quinnyxboy@gmail.com";
    };
  };
}
