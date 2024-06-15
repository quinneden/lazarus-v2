{spaghetti, ...}: {
  home-manager.users.${spaghetti.user}.home.file.".config/hypr/per-device.conf" = {
    text = ''
      monitor=,2560x1440@144,0x0,1
    '';
  };
}
