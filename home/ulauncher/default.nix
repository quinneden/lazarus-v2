{
  pkgs,
  spaghetti,
  ...
}: {
  users.users.${spaghetti.user}.packages = with pkgs; [ulauncher];

  home-manager.users.${spaghetti.user}.home.file.".config/hypr/per-app/ulauncher.conf" = {
    text = ''
      exec-once = sleep 1 && ulauncher --hide-window
      # windowrulev2 = noborder, class:^(ulauncher)$
      # windowrulev2 = noshadow, class:^(ulauncher)$
      windowrulev2 = noblur, class:^(ulauncher)$
      windowrulev2 = center 1, class:^(ulauncher)$
      bind = $mainMod, R, exec, ulauncher-toggle
    '';
  };

  imports = [
    ./manifest.json.nix
    ./theme-gtk-3.20.css.nix
    ./theme.css.nix
  ];
}
