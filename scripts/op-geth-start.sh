#!/bin/sh
set -eou

if [ "$NETWORK_NAME" == "testnet" ]; then
  export NETWORK=opBNBTestnet
fi

if [ "$NETWORK_NAME" == "mainnet" ]; then
  export NETWORK=opBNBMainnet
fi

GETH_DATA_DIR=$BEDROCK_DATADIR
GETH_CHAINDATA_DIR="$GETH_DATA_DIR/geth/chaindata"

if [ ! -d "$GETH_CHAINDATA_DIR" ]; then
  echo "$GETH_CHAINDATA_DIR missing, running init"
  echo "Initializing genesis."
  geth init \
    --datadir="$GETH_DATA_DIR" \
    /genesis/genesis.json
else
  echo "$GETH_CHAINDATA_DIR exists."
fi

# Start op-geth.
exec geth \
  --$NETWORK \
  --datadir="$BEDROCK_DATADIR" \
  --http.addr=0.0.0.0 \
  --authrpc.addr="0.0.0.0" \
  --authrpc.vhosts="*" \
  --authrpc.port=8551 \
  --authrpc.jwtsecret=./jwt.txt \
  --rollup.sequencerhttp=$L2_RPC \
  --verbosity=3 \
  --http.corsdomain=* \
  --http \
  --http.api=eth,net,web3,txpool \
  --http.vhosts=* \
  --http.port=8545 \
  --syncmode=full \
  --metrics \
  --metrics.port=6060 \
  --metrics.addr=0.0.0.0 \
  --allow-insecure-unlock \
  --rpc.allow-unprotected-txs \
  --gcmode=archive \
  --txpool.globalslots=2000  \
  --txpool.globalqueue=500  \
  --txpool.accountqueue=64 \
  --txpool.accountslots=16 \
  --txpool.pricelimit=1 \
  --txpool.nolocals=true \
  --cache=6000 \
  --cache.preimages \
  --rollup.disabletxpoolgossip=false \
  --bootnodes=enr:-KO4QHs5qh_kPFcjMgqkuN9dbxXT4C5Cjad4SAheaUxveCbJQ3XdeMMDHeHilHyqisyYQAByfdhzyKAdUp2SvyzWeBqGAYvRDf80g2V0aMfGhHFtSjqAgmlkgnY0gmlwhDaykUmJc2VjcDI1NmsxoQJUevTL3hJwj21IT2GC6VaNqVQEsJFPtNtO-ld5QTNCfIRzbmFwwIN0Y3CCdl-DdWRwgnZf,enr:-KO4QKIByq-YMjs6IL2YCNZEmlo3dKWNOy4B6sdqE3gjOrXeKdNbwZZGK_JzT1epqCFs3mujjg2vO1lrZLzLy4Rl7PyGAYvRA8bEg2V0aMfGhHFtSjqAgmlkgnY0gmlwhDbjSM6Jc2VjcDI1NmsxoQNQhJ5pqCPnTbK92gEc2F98y-u1OgZVAI1Msx-UiHezY4RzbmFwwIN0Y3CCdl-DdWRwgnZf