{
  config,
  pkgs,
  spaghetti,
  ...
}: {
  services.blueman.enable = true;

  home-manager.users.${spaghetti.user}.home.file.".config/hypr/per-app/bluetooth.conf" = {
    text = ''
      exec-once = blueman-tray
      windowrule = float, title:.blueman-manager-wrapped
    '';
  };

  users.users.${spaghetti.user} = {
    packages = with pkgs; [gnome.gnome-bluetooth];
  };
}
