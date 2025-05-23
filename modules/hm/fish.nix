{
  config,
  pkgs,
  lib,
  ...
}: let
  plugin = name: {
    name = "${name}";
    src = pkgs.fishPlugins.${name}.src;
  };
in {
  options.my.fish = {
    enable = lib.mkEnableOption "fish";
  };
  config = lib.mkIf config.my.fish.enable {
    programs.fish = {
      enable = true;
      shellAliases = {
        lg = "lazygit";
        ns = "nix-shell --run fish";
        dev = "nix develop";
        lazyvim = "NVIM_APPNAME=lazyvim nvim";
      };
      plugins = map plugin [
        "tide"
        "fzf"
      ];
      functions = {
        v = ''
          if set -q argv[1]
            nvim $argv
          else
            nvim .
          end
        '';
        ta = ''
          if set -q argv[1]
            set session $argv[1]
          else
            set session (path basename $HOME)
          end
          tmux attach -t $session 2> /dev/null || tmux new-session -s $session
        '';

        ad = ''
          argparse 'd/dir' 'p/path' 'h/help' -- $argv
          if set -q _flag_d
            echo $PWD >> ~/.dotfiles/utils/tmux_dirs
          end
          if set -q _flag_p
            echo $PWD >> ~/.dotfiles/utils/paths
          end
          if set -q _flag_h
            printf "\t p or path to add dir to ~/.dotfiles/utils/paths\n"
            printf "\t d or dir to add dir ~/.dotfiles/utils/tmux_dirs\n"
            printf "\t h or help to print this message\n"
          end
        '';
        ve = ''
          set -l excludes .git node_module .cache .npm .mozilla .meteor .nv
          set -l fd_command fd --type d --hidden
          for exclude in $excludes
            set fd_command $fd_command --exclude $exclude
          end
          set -l dir ($fd_command | fzf)

          test -n "$dir" && nvim $dir

        '';
        m = ''
          if type -q cargo; and [ -f Cargo.toml ]
            cargo run
          end
          if [ -f Makefile ]
            make
          end
        '';

        fzf_complete = ''
          set -l cmdline (commandline)
          # HACK: Color descriptions manually.
          complete -C | string replace -r \t'(.*)$' \t(set_color $fish_pager_color_description)'$1'(set_color normal) \
            | fzf -d \t -1 -0 --ansi --header="$cmdline" --height="80%" --tabstop=4 \
            | read -l token
          # Remove description
          set token (string replace -r \t'.*' ''' -- $token)
          commandline -rt "$token"
        '';
      };
      interactiveShellInit = ''
        if command -q fd
          export FZF_DEFAULT_COMMAND='fd -H -E .git .'
        end

        bind \en 'nvim -c ":lua Snacks.picker.smart()"'
        bind \eg 'nvim -c ":lua Snacks.picker.grep()"'
        bind \ed 've'
        bind \eu 'fzf_complete; commandline -f repaint'

        set -gx fish_greeting
        set -gx EDITOR nvim
        set -gx VISUAL nvim
        # set -gx PAGER "nvim +Man!" # extremely slow
        # set -gx MANWIDTH 999
        set -q nvm_default_version; or set -U nvm_default_version latest
        fish_add_path $HOME/.cargo/bin $HOME/.local/share/bob/nvim-bin $HOME/.cabal/bin $HOME/.ghcup/bin $HOME/.local/bin $home/.config/emacs/bin

        if command -q direnv
          set -gx DIRENV_LOG_FORMAT ""
          direnv hook fish | source
        end
      '';
    };
  };
}
