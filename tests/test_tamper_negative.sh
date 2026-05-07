#!/usr/bin/env bash
set -euo pipefail

PLAINTEXT="0001001000110100010101100111100010011010101111001101111011110001"
KEY="0001001100110100010101110111100110011011101111001101111111110001"

g++ -std=c++17 -Wall -Wextra -pedantic des.cpp -o des_test
CIPHERTEXT=$(printf "1\n%s\n%s\n" "$PLAINTEXT" "$KEY" | ./des_test | tail -n 1)

if [[ -z "$CIPHERTEXT" ]]; then
  echo "[FAIL] Could not produce ciphertext for tamper test"
  rm -f des_test
  exit 1
fi

if [[ "${CIPHERTEXT:0:1}" == "0" ]]; then
  TAMPERED="1${CIPHERTEXT:1}"
else
  TAMPERED="0${CIPHERTEXT:1}"
fi

DECRYPTED=$(printf "2\n%s\n%s\n" "$TAMPERED" "$KEY" | ./des_test | tail -n 1)

if [[ "$DECRYPTED" == "$PLAINTEXT" ]]; then
  echo "[FAIL] Tampered ciphertext should not decrypt to the original plaintext"
  echo "Tampered: $TAMPERED"
  echo "Decrypted: $DECRYPTED"
  rm -f des_test
  exit 1
fi

echo "[PASS] Tamper negative test passed: modified ciphertext does not recover plaintext."
rm -f des_test
