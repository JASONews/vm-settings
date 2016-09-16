if test "$OSTYPE" = "linux-gnu"; then
	sudo apt-get update
	sudo apt-get install tmux
	sudo apt-get install neovim
fi
. ./neovim/install.sh && echo "neovim done"
. ./tmux/install.sh && echo "tmux done"
. ./bash/install.sh && echo "bash done"
