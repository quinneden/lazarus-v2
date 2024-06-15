{
  description = "spaghetti nixos";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1"; # latest git
    hyprpicker.url = "github:hyprwm/hyprpicker";

    nix-colors.url = "github:kyesarri/nix-colors"; # colour themes, my fork
    prism.url = "github:IogaMaster/prism"; # wallpaper gen
    wallpaper-generator.url = "github:kyesarri/wallpaper-generator"; # another one

    alejandra.url = "github:kamadorueda/alejandra/3.0.0";

    ags.url = "github:Aylur/ags"; # shell

    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-apple-silicon = {
      url = "github:tpwrules/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    hyprland,
    hyprpicker,
    alejandra,
    nix-colors,
    auto-cpufreq,
    prism,
    wallpaper-generator,
    nixos-apple-silicon,
    ...
  } @ inputs: let
    spaghetti = {
      user = "quinn";
      plymouth = "deus_ex";
      scheme = "horizon-dark";
      scheme1 = "gigavolt";
      scheme2 = "papercolor-dark";
      iconPkg = "pkgs.zafiro-icons";
    };
    system = "aarch64-linux";
    specialArgs = {inherit nix-colors auto-cpufreq inputs prism spaghetti wallpaper-generator;};
  in {
    nixosConfigurations = {
      "lazarus" = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        pkgs = import nixpkgs {
          inherit system;
          nixpkgs.overlays = [
            inputs.nixos-apple-silicon.overlays.apple-silicon-overlay
            (final: prev: {mesa = final.mesa-asahi-edge;})
          ];
        };
        modules = [
          home-manager.nixosModules.home-manager
          ./hosts/lazarus
          {
            environment.systemPackages = [alejandra.defaultPackage.aarch64-linux];
          }
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit nix-colors inputs;};
            };
          }
        ];
      };
    };
  };
}
