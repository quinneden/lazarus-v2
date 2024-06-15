{
  pkgs,
  spaghetti,
  ...
}: {
  imports = [./theme.nix];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    syntaxHighlighting.highlighters = ["main" "brackets" "pattern" "cursor" "line"];
    syntaxHighlighting.patterns = {};
    syntaxHighlighting.styles = {"globbing" = "none";};
    promptInit = "info='n n host kern cpu wm os sh n n' fet.sh";
    ohMyZsh = {
      enable = true;
      custom = "/home/${spaghetti.user}/.config/omzsh/";
      theme = "omzsh-nix";
      plugins = [
        "sudo"
        "zsh-navigation-tools"
        "colorize"
      ];
    };
    shellAliases = {
      nano = "micro";
      mi = "micro";
      code = "codium";
      py = "python";
      dsize = "du -hs";
      fuck = "sudo rm -rf";
      rf = "rm -rf";
      l = "eza --icons  -a --group-directories-first";
      ll = "eza --icons  -a --group-directories-first --long --git --group";
      tree = "eza --icons --tree --group-directories-first";
      # codenix = "cd ~/.config/lazarus && codium ~/.config/lazarus";
      nix-switch = "sudo nixos-rebuild switch --flake ~/.dotfiles#lazarus --impure";
      flake-update = "nix flake update ~/.dotfiles";
      nix-clean = "sudo nix-collect-garbage && sudo nix-collect-garbage -d && sudo rm /nix/var/nix/gcroots/auto/* && nix-collect-garbage && nix-collect-garbage -d";
    };
  };
}
