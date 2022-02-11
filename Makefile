deps:
	/opt/bin/opkg update
	/opt/bin/opkg install nano git zsh make

oh-my-zsh:
	rm -rf $(HOME)/dotfiles/oh-my-zsh
	git clone --depth 1 git@github.com:ohmyzsh/ohmyzsh.git $(HOME)/dotfiles/oh-my-zsh
	ln -s $(HOME)/dotfiles/oh-my-zsh $(HOME)/.oh-my-zsh

# https://github.com/junegunn/fzf
install-console-fzf:
	curl -sLo /tmp/fzf.tar.gz https://github.com/junegunn/fzf/releases/download/0.29.0/fzf-0.29.0-linux_amd64.tar.gz
	tar -xvzf /tmp/fzf.tar.gz -C /tmp
	cp /tmp/fzf ~/dotfiles/bin
	echo "Consider running make zsh-fzf to install zsh shell integration"

zsh-fzf-repo:
	rm -rf ~/.fzf
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

zsh-fzf:
	rm -rf ~/.oh-my-zsh/custom/plugins/fzf || true
	git clone https://github.com/junegunn/fzf.git ~/.oh-my-zsh/custom/plugins/fzf
	~/.oh-my-zsh/custom/plugins/fzf/install --bin
	mkdir -p ~/.oh-my-zsh/custom/plugins/fzf-zsh
	cp ~/dotfiles/helpers/fzf-zsh.plugin.zsh ~/.oh-my-zsh/custom/plugins/fzf-zsh



setup: deps oh-my-zsh
	init_simple.sh

