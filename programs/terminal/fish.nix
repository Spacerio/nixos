{ config, pkgs, ... }: {
	
  programs.fish = {
    enable = true;
    shellAliases = {
	  lg = "lazygit -ucf='/home/lait/.config/lazygit/config.yml,/home/lait/.cache/wal/colors-lazygit.yml'";
	  v = "nvim .";
    };
	functions = {
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
	};
	interactiveShellInit = ''
		# if command -q tmux && [ "$TERM" != "tmux" ] && [ -z "$TMUX" ]
		# 	ta
		# end

		if command -q fd
			export FZF_DEFAULT_COMMAND='fd -H -E .git .'
		end

		# if ! command -q fisher
		# 	curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
		# end

		set -gx fish_greeting 
		set -gx EDITOR nvim
		set -gx VISUAL nvim
		set -gx PAGER "nvim +Man!"
		set -q nvm_default_version; or set -U nvm_default_version latest
		fish_add_path $HOME/.cargo/bin $HOME/.local/share/bob/nvim-bin $HOME/.cabal/bin $HOME/.ghcup/bin $HOME/.local/bin
	'';
  };
}
