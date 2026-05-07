#!/usr/bin/env bash
set -euo pipefail

PLAINTEXT="0001001000110100010101100111100010011010101111001101111011110001"
KEY="0001001100110100010101110111100110011011101111001101111111110001"
WRONG_KEY="1111000011001100101010101111010101010110011001111000111100001111"

g++ -std=c++17 -Wall -Wextra -pedantic des.cpp -o des_test
CIPHERTEXT=$(printf "1\n%s\n%s\n" "$PLAINTEXT" "$KEY" | ./des_test | tail -n 1)
DECRYPTED=$(printf "2\n%s\n%s\n" "$CIPHERTEXT" "$WRONG_KEY" | ./des_test | tail -n 1)

if [[ "$DECRYPTED" == "$PLAINTEXT" ]]; then
  echo "[FAIL] Wrong key negative test failed: ciphertext decrypted correctly with wrong key"
  echo "Wrong key: $WRONG_KEY"
  rm -f des_test
  exit 1
fi

echo "[PASS] Wrong key negative test passed: wrong key does not recover plaintext."
rm -f des_test
