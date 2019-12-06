#!/bin/bash

echo "Starting bitcoind daemon"
bitcoind -regtest -daemon
sleep 4

echo "Creating wallet 'testwallet'"
bitcoin-cli -regtest createwallet testwallet
sleep 1

echo "Checking balance of testwallet"
bitcoin-cli -regtest -rpcwallet=testwallet getbalance
sleep 1

echo "Generating new address for wallet"
bitcoin-cli -regtest -rpcwallet=testwallet getnewaddress > walletaddress
cat walletaddress
sleep 1

echo "Mining blocks to new adddress"
addr=$(cat walletaddress)
bitcoin-cli -regtest -rpcwallet=testwallet generatetoaddress 101 $addr

echo "Complete!"
