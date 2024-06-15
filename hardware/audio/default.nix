{
  config,
  pkgs,
  spaghetti,
  ...
}: {
  imports = [inputs.nixos-apple-silicon.nixosModules.apple-silicon-support];
  home-manager.users.${spaghetti.user}.home.file.".config/hypr/per-app/audio.conf" = {
    text = ''
      windowrule = float, ^(pavucontrol)$
    '';
  };
  users.users.${spaghetti.user}.packages = with pkgs; [pamixer pavucontrol];
  security.rtkit.enable = true;
  sound.enable = true;
  hardware.asahi.setupAsahiSound = true;
}
