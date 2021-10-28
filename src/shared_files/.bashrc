alias vim=vi
alias tb="nc termbin.com 9999"
alias nodebin="tac $(ls -t1 ~/.safe/node/root_dir/sn_node.log.* | head -n 1) | sed -e '/ERROR/{N;N;q}' | tac | tb"
