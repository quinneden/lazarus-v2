{
  spaghetti,
  pkgs,
  ...
}: {
  users.users.${spaghetti.user}.packages = [
    pkgs.kdePackages.qtstyleplugin-kvantum

    # qt6
    # pkgs.kdePackages.qt6gtk2
    # pkgs.kdePackages.qt6ct

    # qt5
    pkgs.libsForQt5.qt5ct
    pkgs.libsForQt5.qtstyleplugins
  ];
}
