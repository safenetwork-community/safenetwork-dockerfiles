alias tb="nc termbin.com 9999"
alias nodebin="tac $(ls -t1 ~/.safe/node/baby-fleming-nodes/sn-node-genesis/sn_node.log.* | head -n 1) | sed -e '/ERROR/{N;N;q}' | tac | tb"
