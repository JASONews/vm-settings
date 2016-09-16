if test "$OSTYPE" = "linux-gnu"; then
	sudo apt-get install software-properties-common
	sudo add-apt-repository ppa:neovim-ppa/unstable
	sudo apt-get update
	sudo apt-get install tmux
	sudo apt-get install neovim
fi
CDIR="$(pwd)"
cd $CDIR/neovim && (. install.sh && echo "neovim done")
cd $CDIR/tmux && (. install.sh && echo "tmux done")
cd $CDIR/bash && (. install.sh && echo "bash done")
cd $CDIR
