#!/bin/bash

#NODE="tcp://localhost:2281"
NODE="http://65.108.128.139:2281"
#ACCOUNT="test"
ACCOUNT="Developer"
CHAINID="anone-testnet-1"
SLEEP_TIME="15s"
CONTRACT="one1mn2uykuljvg3jgym22vwsqc2kqrwvzrh5pw8mfypvwjw0l3nuz2sdllp4u"

ALL_MODELS_QUERY="{\"all_models\": {}}"
OWNER_OF=$(anoned query wasm contract-state smart "$CONTRACT" "$ALL_MODELS_QUERY" --node "$NODE" --output json)

echo $OWNER_OF