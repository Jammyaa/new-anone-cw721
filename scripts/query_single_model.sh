#!/bin/bash

#NODE="tcp://localhost:2281"
NODE="http://65.108.128.139:2281"
#ACCOUNT="test"
ACCOUNT="Developer"
CHAINID="anone-testnet-1"
SLEEP_TIME="15s"
CONTRACT="one1nq6auma68amwaz5w5t2hdad8p9jh03t0txlz0g5y66l4yswepkyq027dnt"

# CHANGE MODEL_ID HERE
# $# is to check number of arguments
MODEL_ID="$1"

QUERY="{\"model_info\": {\"model_id\": \"$MODEL_ID\"}}"
echo $(anoned query wasm contract-state smart "$CONTRACT" "$QUERY" --node "$NODE" --output json | jq --color-output -r )