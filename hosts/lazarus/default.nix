let
  scheme = "tokyo-night-dark";
in
  {
    config,
    pkgs,
    lib,
    inputs,
    outputs,
    nix-colors,
    spaghetti,
    ...
  }: {
    imports = [
      inputs.nixos-apple-silicon.nixosModules.apple-silicon-support
      nix-colors.homeManagerModules.default
      ./per-device.nix # per device hypr configuration
      ./boot.nix

      ./hardware.nix # machine hardware config
      ../standard.nix # standard or minimal configs

      ../../hardware

      ../../home
      ../../home/ags
      ../../home/bottom
      ../../home/codium
      ../../home/copyq
      ../../home/dunst
      ../../home/firefox
      ../../home/git
      ../../home/hypr
      ../../home/kde
      ../../home/kitty
      ../../home/ulauncher
      ../../home/gtk
      ../../home/zsh
    ];

    colorscheme = inputs.nix-colors.colorSchemes.${scheme};
    home-manager.users.${spaghetti.user}.colorscheme = inputs.nix-colors.colorSchemes.${scheme};

    networking = {
      hostName = "lazarus";
      wireless.iwd = {
        enable = true;
        settings.General.EnableNetworkConfiguration = true;
      };
    };

    hardware.asahi = {
      peripheralFirmwareDirectory = ./firmware;
      useExperimentalGPUDriver = true;
      experimentalGPUInstallMode = "replace";
      withRust = true;
    };

    services = {
      xserver = {
        enable = true;
      };
    };

    environment = {
      systemPackages = with pkgs; [
        asahi-bless
        asahi-btsync
      ];
    };
  }
