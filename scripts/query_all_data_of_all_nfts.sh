#!/bin/bash

#NODE="tcp://localhost:2281"
NODE="http://65.108.128.139:2281"
#ACCOUNT="test"
ACCOUNT="Developer"
CHAINID="anone-testnet-1"
SLEEP_TIME="15s"
CONTRACT="one14h9jdcg8ke8vnech25erz8v98utc6vaneaph3rlpx627nas4jt3s7jv0ur"

ALL_NFTS_QUERY="{\"all_tokens_info\": {}}"
OWNER_OF=$(anoned query wasm contract-state smart "$CONTRACT" "$ALL_NFTS_QUERY" --node "$NODE" --output json)

echo $OWNER_OF