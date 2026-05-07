#!/usr/bin/env bash
set -euo pipefail

PLAINTEXT="00010010001101000101011001111000100110101011110011011110111100011010101010101010"
KEY="0001001100110100010101110111100110011011101111001101111111110001"

g++ -std=c++17 -Wall -Wextra -pedantic des.cpp -o des_test

CIPHERTEXT=$(printf "1\n%s\n%s\n" "$PLAINTEXT" "$KEY" | ./des_test | tail -n 1)
DECRYPTED=$(printf "2\n%s\n%s\n" "$CIPHERTEXT" "$KEY" | ./des_test | tail -n 1)

if [[ "$DECRYPTED" != "$PLAINTEXT" ]]; then
  echo "[FAIL] Round-trip DES failed"
  echo "Plaintext:  $PLAINTEXT"
  echo "Decrypted:  $DECRYPTED"
  rm -f des_test
  exit 1
fi

echo "[PASS] DES round-trip encrypt/decrypt works."
rm -f des_test
