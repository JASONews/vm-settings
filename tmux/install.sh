which tmux 
test  $? -eq 0 || (echo "Please install tmux first" && exit 1)
cp ./.tmux.conf ~/
test  $? -eq 0 && (echo "tmux.conf done" && exit 0)
echo "copy tmux.conf failed"
