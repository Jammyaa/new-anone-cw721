#!/bin/bash

#NODE="tcp://localhost:2281"
NODE="http://65.108.128.139:2281"
#ACCOUNT="test"
ACCOUNT="Developer"
CHAINID="anone-testnet-1"
SLEEP_TIME="15s"
CONTRACT="one1nq6auma68amwaz5w5t2hdad8p9jh03t0txlz0g5y66l4yswepkyq027dnt"

ALL_MODELS_QUERY="{\"all_models\": {}}"
OWNER_OF=$(anoned query wasm contract-state smart "$CONTRACT" "$ALL_MODELS_QUERY" --node "$NODE" --output json)

echo $OWNER_OF