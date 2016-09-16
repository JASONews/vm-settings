which tmux 
test -eq $? 0 || (echo "Please install tmux first" && return 1)
cp ./.tmux.conf ~/
test -eq $? 0 && (echo "tmux.conf done" && return 0)
echo "failed"
