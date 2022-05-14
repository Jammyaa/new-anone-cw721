#!/bin/bash

NODE="http://65.108.128.139:2281"
ACCOUNT="Developer"
CHAINID="anone-testnet-1"
SLEEP_TIME="15s"
CONTRACT="one1yzu3kyld7k948tqrkz2vn67v6qa9qqzghfkud9443xydtzc6q0squvrvjz"

COLLECTION_INFO_QUERY="{\"collection_info\": {}}"
COLLECTION_INFO=$(anoned query wasm contract-state smart "$CONTRACT" "$COLLECTION_INFO_QUERY" --node "$NODE" --output json)

echo $COLLECTION_INFO