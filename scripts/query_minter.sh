#!/bin/bash

NODE="http://65.108.128.139:2281"
ACCOUNT="Developer"
CHAINID="anone-testnet-1"
SLEEP_TIME="15s"
CONTRACT="one1dy3j893n3jnnq5se74cmgpsqu0dxm35736tqk9yf6g8wkjnknuqquxkaw6"

MINTER_QUERY="{\"minter\": {}}"
MINTER=$(anoned query wasm contract-state smart "$CONTRACT" "$MINTER_QUERY" --node "$NODE" --output json)

echo $MINTER