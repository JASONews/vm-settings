if test ! -d fonts; then
	git clone https://github.com/powerline/fonts.git
	cd fonts &&  . install.sh  && cd - && echo "powerline fonts done"
	rm -rf fonts
else
	echo "fonts directory already exists" && exit 1
fi



