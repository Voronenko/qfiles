deps:
	/opt/bin/opkg update
	/opt/bin/opkg install nano git zsh make

oh-my-zsh:
	rm -rf $(HOME)/dotfiles/oh-my-zsh
	git clone --depth 1 git@github.com:ohmyzsh/ohmyzsh.git $(HOME)/dotfiles/oh-my-zsh
	ln -s $(HOME)/dotfiles/oh-my-zsh $(HOME)/.oh-my-zsh

setup: deps oh-my-zsh
	init_simple.sh

