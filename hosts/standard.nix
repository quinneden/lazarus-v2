{
  config,
  pkgs,
  lib,
  outputs,
  inputs,
  spaghetti,
  ...
}: {
  imports = [./console.nix];
  system.stateVersion = "24.11";
  time.timeZone = "America/Los_Angeles";

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixVersions.latest;
    gc = {
      automatic = true; # auto nix garbage collection
      dates = "weekly";
      options = "--delete-older-than 5d";
    };
    settings = {
      auto-optimise-store = true; # runs gc, need to set interval otherwise defaults to 14d from memory
      experimental-features = ["nix-command" "flakes"]; # flakes and nixcommand required for config
    };
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [3389]; # rdp
    };
  };

  services = {
    openssh.enable = true;
    fstrim.enable = true; # ssd trim in background, not enabled by default :0
    gvfs.enable = true; # trash and mount
    tumbler.enable = true; # thumbnail support
    printing.enable = true; # need more than this to print afik? http://localhost:631/ for config
  };

  fonts = {
    fontconfig.defaultFonts.monospace = ["Hack Nerd Font Mono"];
    fontDir.enable = true;
    packages = with pkgs; [
      material-design-icons
      inter
      material-symbols
      ibm-plex
      hack-font
    ];
  };

  programs = {
    dconf.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    seahorse.enable = true;
  };

  environment = {
    sessionVariables = rec
    {
      CLUTTER_BACKEND = "wayland";
      QT_QPA_PLATFORM = "wayland";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      GTK_THEME = "${config.colorscheme.slug}"; # sets default gtk theme the package built by nix-colors
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      NIXOS_OZONE_WL = "1"; # fixes electron apps in wayland... why do i use electron? fucking codium
      XCURSOR_THEME = "graphite-dark";
    };

    shells = with pkgs; [zsh]; # default shell to zsh

    systemPackages = with pkgs; [
      busybox # nice-to-have
      ripgrep
      micro
      curl
      wget
      libsecret
      gitAndTools.gitFull
      polkit_gnome
      waypipe
    ];
  };

  users.users.${spaghetti.user} = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "${spaghetti.user}";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      graphite-cursors # cursor package, is this handled by /home/gtk/default.nix now? nope manual atm
      nix-init # git flake helper
      remmina # rdp client
      fet-sh # minimalistic fetch script
      qview # image viewer
      gscreenshot # image capture
      imagemagick # bitmap editor cli
      libnotify # notifications
      wf-recorder # screen recorder
      mate.mate-calc # calc
      p7zip # TODO needs a gui
      udiskie # usb mounting
      curl # into the fetal position
      wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
      vlc # play me some vids

      ## TESTING ##
      gnome.gnome-disk-utility
      inputs.wallpaper-generator.defaultPackage.aarch64-linux
      ## TESTING ##

      # (callPackage ../packages/image-colorizer {})
      # (callPackage ../packages/wcp {}) # IT WORKS! Currently has bugs with RGBA colours, see package notes
      # (callPackage ../packages/libfprint {}) # builds, need to write to the fprint reader now :)
      # (callPackage ../packages/sov {}) # sway overview, needs some hyprland config to see if works on hyprland
    ];
  };
}
