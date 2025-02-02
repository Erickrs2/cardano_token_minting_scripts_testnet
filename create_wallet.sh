#!/bin/bash
set -e

NAME="minter"

# Check if a directory does not exist
if [ -d "${NAME}" ] 
then
  exit 1
else
  mkdir -p ${NAME}
fi
cd ${NAME}

cardano-cli address key-gen --verification-key-file ${NAME}_payment.vkey --signing-key-file ${NAME}_payment.skey
# echo "Generating Payment/Enterprise address"/
cardano-cli stake-address key-gen --verification-key-file ${NAME}_stake.vkey --signing-key-file ${NAME}_stake.skey
# echo "Payment/Enterprise address:"
cardano-cli address build --payment-verification-key-file ${NAME}_payment.vkey --testnet-magic 1097911063 | tee ${NAME}_payment.addr
# echo "Base address:"
cardano-cli address build --payment-verification-key-file ${NAME}_payment.vkey --stake-verification-key-file ${NAME}_stake.vkey --testnet-magic 1097911063 | tee ${NAME}_base.addr
# echo "Reward address:"
cardano-cli stake-address build --stake-verification-key-file ${NAME}_stake.vkey --testnet-magic 1097911063 | tee ${NAME}_reward.addr
# echo "Create QR Code"
qr $(cat ${NAME}_base.addr) > ${NAME}"_qrcode.png"
