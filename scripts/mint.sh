#!/bin/bash

#NODE="tcp://localhost:2281"
NODE="http://65.108.128.139:2281"
#OWNER="test"
CHAINID="anone-testnet-1"
SLEEP_TIME="15s"
CONTRACT="one1tj748034gl3zvujn2tz4p4m8rf9j9uarsj5j3c5a5z2neqel77cslz2lp0"

LATEST=$(bash scripts/query_all_nfts.sh | jq -r ".data.tokens | last")
TOKEN_ID=$(($LATEST+1))
MODEL_ID="$1"
SIZE="M"
# CHANGE ONLY THIS
OWNER="Developer"

MINT="{\"mint\": {\"model_id\":\"$MODEL_ID\", \"token_id\":\"$TOKEN_ID\",  \"size\": \"$SIZE\", \"owner\":\"$(anoned keys show $OWNER -a)\"}}"

echo $MINT

RES=$(anoned tx wasm execute "$CONTRACT" "$MINT" --from "$OWNER" -y --output json --chain-id "$CHAINID" --node "$NODE" --gas 35000000 --fees 0uan1 -y --output json)
echo $RES

TXHASH=$(echo $RES | jq -r .txhash)

echo $TXHASH

# sleep for chain to update
sleep "$SLEEP_TIME"

RAW_LOG=$(anoned query tx "$TXHASH" --chain-id "$CHAINID" --node "$NODE" -o json | jq -r .raw_log)

echo $RAW_LOG

NAME_QUERY="{\"nft_info\": {\"token_id\": \"$TOKEN_ID\"}}"
OWNER_OF=$(anoned query wasm contract-state smart "$CONTRACT" "$NAME_QUERY" --node "$NODE" --output json)
echo $OWNER_OF
