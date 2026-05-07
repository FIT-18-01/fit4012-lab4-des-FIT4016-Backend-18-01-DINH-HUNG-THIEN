[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/BJH8GGf3)
# FIT4012 - Lab 4: DES / TripleDES

Repo này đã được hoàn thiện để:
- mã hóa DES với multi-block và zero padding
- giải mã DES với round keys đảo ngược
- mã hóa / giải mã TripleDES theo E(K3, D(K2, E(K1, P)))
- chạy qua stdin theo hợp đồng kiểm thử CI

## 1. Cấu trúc repo

```text
.
├── .github/
│   ├── grading/
│   │   ├── common.sh
│   │   ├── test_q2.sh
│   │   └── test_q4.sh
│   ├── scripts/
│   │   └── check_submission.sh
│   └── workflows/
│       └── ci.yml
├── logs/
│   ├── .gitkeep
│   └── run-output.txt
├── scripts/
│   └── run_sample.sh
├── tests/
│   ├── test_des_sample.sh
│   ├── test_encrypt_decrypt_roundtrip.sh
│   ├── test_multiblock_padding.sh
│   ├── test_tamper_negative.sh
│   └── test_wrong_key_negative.sh
├── .gitignore
├── CMakeLists.txt
├── Makefile
├── README.md
├── des.cpp
└── report-1page.md
```

## 2. Cách chạy chương trình (How to run)

### Cách 1: Dùng Makefile

```bash
make
./des
```

### Cách 2: Biên dịch trực tiếp

```bash
g++ -std=c++17 -Wall -Wextra -pedantic des.cpp -o des
./des
```

### Cách 3: Dùng CMake

```bash
cmake -S . -B build
cmake --build build
./build/des
```

## 3. Input / Đầu vào

Chương trình đọc từ `stdin` theo định dạng sau:

1. Chọn mode:
   - `1` = DES encrypt
   - `2` = DES decrypt
   - `3` = TripleDES encrypt
   - `4` = TripleDES decrypt
2. Nhập dữ liệu tiếp theo tùy mode:
   - Mode 1: `plaintext` nhị phân bất kỳ độ dài + `key` 64-bit
   - Mode 2: `ciphertext` nhị phân bội số 64 + `key` 64-bit
   - Mode 3: `plaintext` 64-bit + `K1` 64-bit + `K2` 64-bit + `K3` 64-bit
   - Mode 4: `ciphertext` 64-bit + `K1` 64-bit + `K2` 64-bit + `K3` 64-bit

### Chú ý
- Dữ liệu đầu vào phải là chuỗi `0`/`1`.
- Mode 1 cho phép plaintext nhiều block và sẽ zero pad block cuối cùng.
- Mode 2 chỉ chấp nhận ciphertext có độ dài chia hết cho 64.

## 4. Output / Đầu ra

- Chương trình in ra kết quả cuối cùng dưới dạng một chuỗi nhị phân dài.
- Mode 1/3 in ciphertext; mode 2/4 in plaintext.
- Kết quả chỉ là chuỗi nhị phân để CI có thể trích và so sánh.

## 5. Padding đang dùng

- Với DES encrypt mode 1, nếu plaintext không chia hết 64 bit thì block cuối được padding thêm `0` cho đủ 64 bit.
- Zero padding phù hợp cho bài lab nhập môn và cho phép xử lý multi-block.
- Hạn chế: không phân biệt padding với dữ liệu thực, nên không dùng trong thiết kế mã hoá an toàn thực tế.

## 6. Tests

Đã hoàn thiện 5 test chính:
- `tests/test_des_sample.sh`
- `tests/test_encrypt_decrypt_roundtrip.sh`
- `tests/test_multiblock_padding.sh`
- `tests/test_tamper_negative.sh`
- `tests/test_wrong_key_negative.sh`

Các test kiểm tra:
- sample DES mẫu
- round-trip encrypt -> decrypt
- multi-block padding
- tamper negative
- wrong key negative

## 7. Logs / Minh chứng

Thư mục `logs/` chứa `run-output.txt` để minh chứng chương trình chạy thành công.

## 8. Ethics & Safe use

- Chỉ chạy trên dữ liệu học tập hoặc dữ liệu giả lập.
- Không dùng repo này để tấn công hệ thống thật.
- Đây là bài tập học DES / TripleDES, không phải mã hoá sản xuất.
- Nếu tham khảo tài liệu hoặc AI, ghi nguồn rõ ràng.

## 9. Checklist nộp bài

- `des.cpp` hoàn chỉnh
- `README.md` hoàn chỉnh
- `report-1page.md` hoàn chỉnh
- `tests/` ít nhất 5 test
- negative test cho `tamper` và `wrong key`
- `logs/` có file minh chứng
- không còn nội dung placeholder chưa hoàn chỉnh

## 10. CI

CI sẽ kiểm tra:
- build `des.cpp`
- cấu trúc repo và nội dung README/report
- đọc stdin và xử lý multi-block mode 1
- TripleDES encrypt/decrypt đúng theo vector kiểm thử
