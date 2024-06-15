{
  spaghetti,
  pkgs,
  ...
}: {
  # enable wl-screenrec
  users.users.${spaghetti.user}.packages = [pkgs.wl-screenrec];
}
