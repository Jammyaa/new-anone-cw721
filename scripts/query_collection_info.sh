#!/bin/bash

NODE="http://65.108.128.139:2281"
ACCOUNT="Developer"
CHAINID="anone-testnet-1"
SLEEP_TIME="15s"
CONTRACT="one16aqd3hrge8p30eku3fh0mrznmtupsug7722hzxshd0urs24nut7q85lfdg"

COLLECTION_INFO_QUERY="{\"collection_info\": {}}"
COLLECTION_INFO=$(anoned query wasm contract-state smart "$CONTRACT" "$COLLECTION_INFO_QUERY" --node "$NODE" --output json)

echo $COLLECTION_INFO