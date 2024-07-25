#!/bin/sh
set -eou

if [ "$NETWORK_NAME" == "testnet" ]; then
  export NETWORK=opBNBTestnet
fi

if [ "$NETWORK_NAME" == "mainnet" ]; then
  export NETWORK=opBNBMainnet
fi

# Start op-node.
exec op-node \
  --network=$NETWORK \
  --snapshotlog.file=./snapshot.log \
  --l2.jwt-secret=./jwt.txt \
  --l1=$OP_NODE__RPC_ENDPOINT \
  --l2=http://op-geth:8551 \
  --l1.trustrpc \
  --sequencer.l1-confs=15  \
  --verifier.l1-confs=15 \
  --l1.http-poll-interval=3s  \
  --l1.epoch-poll-interval=3s  \
  --l1.rpc-max-batch-size=20 \
  --rollup.config=/genesis/rollup.json \
  --rpc.addr=0.0.0.0 \
  --rpc.port=7000 \
  --p2p.sync.req-resp  \
  --p2p.listen.ip=0.0.0.0 \
  --p2p.listen.tcp=9003 \
  --p2p.listen.udp=9003 \
  --p2p.bootnodes=enr:-J24QPSZMaGw3NhO6Ll25cawknKcOFLPjUnpy72HCkwqaHBKaaR9ylr-ejx20INZ69BLLj334aEqjNHKJeWhiAdVcn-GAYv28FmZgmlkgnY0gmlwhDTDWQOHb3BzdGFja4PMAQCJc2VjcDI1NmsxoQJ-_5GZKjs7jaB4TILdgC8EwnwyL3Qip89wmjnyjvDDwoN0Y3CCIyuDdWRwgiMs,enr:-J24QA9sgVxbZ0KoJ7-1gx_szfc7Oexzz7xL2iHS7VMHGj2QQaLc_IQZmFthywENgJWXbApj7tw7BiouKDOZD4noWEWGAYppffmvgmlkgnY0gmlwhDbjSM6Hb3BzdGFja4PMAQCJc2VjcDI1NmsxoQKetGQX7sXd4u8hZr6uayTZgHRDvGm36YaryqZkgnidS4N0Y3CCIyuDdWRwgiMs \
  --metrics.enabled \
  --metrics.addr=0.0.0.0 \
  --metrics.port=7300 \
  --rpc.enable-admin \
  --p2p.ban.peers=false \
  --p2p.scoring=none \
  --log.level=debug \
  --syncmode=execution-layer \
  --l1.max-concurrency=20 \
  --l2.skip-sync-start-check=true 