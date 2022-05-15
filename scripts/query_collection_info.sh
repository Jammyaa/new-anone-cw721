#!/bin/bash

NODE="http://65.108.128.139:2281"
ACCOUNT="Developer"
CHAINID="anone-testnet-1"
SLEEP_TIME="15s"
CONTRACT="one1k4gjju9uaemljh2z5yzsvlp454f26hrfjyj0l0cjwf7wt8twletscpr2f7"

COLLECTION_INFO_QUERY="{\"collection_info\": {}}"
COLLECTION_INFO=$(anoned query wasm contract-state smart "$CONTRACT" "$COLLECTION_INFO_QUERY" --node "$NODE" --output json)

echo $COLLECTION_INFO