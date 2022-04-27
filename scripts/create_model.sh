#!/bin/bash

#NODE="tcp://localhost:2281"
NODE="http://65.108.128.139:2281"
#OWNER="test"
CHAINID="anone-testnet-1"
SLEEP_TIME="15s"
CONTRACT="one1nq6auma68amwaz5w5t2hdad8p9jh03t0txlz0g5y66l4yswepkyq027dnt"

LATEST=$(bash scripts/query_all_models.sh | jq -r ".data.tokens | last")
MODEL_ID=$(($LATEST+1))

# CHANGE ONLY THIS
OWNER="Developer"
MODEL_URI="https://drive.google.com/file/d/1HpYCJaIB4nEu54V8cPAK1cCiIur9Ua0M/view?usp=sharing"

CREATE_MODEL="{\"create_shoe_model\": {\"model_id\":\"$MODEL_ID\",  \"model_uri\": \"$MODEL_URI\", \"owner\":\"$(anoned keys show $OWNER -a)\"}}"

echo $CREATE_MODEL

RES=$(anoned tx wasm execute "$CONTRACT" "$CREATE_MODEL" --from "$OWNER" -y --output json --chain-id "$CHAINID" --node "$NODE" --gas 35000000 --fees 0uan1 -y --output json)
echo $RES

TXHASH=$(echo $RES | jq -r .txhash)

echo $TXHASH

# sleep for chain to update
sleep "$SLEEP_TIME"

RAW_LOG=$(anoned query tx "$TXHASH" --chain-id "$CHAINID" --node "$NODE" -o json | jq -r .raw_log)

echo $RAW_LOG

NAME_QUERY="{\"model_info\": {\"model_id\": \"$MODEL_ID\"}}"
OWNER_OF=$(anoned query wasm contract-state smart "$CONTRACT" "$NAME_QUERY" --node "$NODE" --output json)
echo $OWNER_OF
