#!/usr/bin/env bash
set -euo pipefail

LONG_PLAINTEXT="00010010001101000101011001111000100110101011110011011110111100011010101010101010"
KEY="0001001100110100010101110111100110011011101111001101111111110001"
EXPECTED="01111110101111110100010010010011001000111111101011111010111110000100000010010001101001000010011111010110110001100000111000110100"

g++ -std=c++17 -Wall -Wextra -pedantic des.cpp -o des_test
OUTPUT=$(printf "1\n%s\n%s\n" "$LONG_PLAINTEXT" "$KEY" | ./des_test | tail -n 1)

if [[ "$OUTPUT" != "$EXPECTED" ]]; then
  echo "[FAIL] Multi-block padding result incorrect"
  echo "Expected: $EXPECTED"
  echo "Actual:   $OUTPUT"
  rm -f des_test
  exit 1
fi

echo "[PASS] Multi-block DES padding and encryption are correct."
rm -f des_test
