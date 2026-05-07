# Report 1 page - Lab 4 DES / TripleDES

## Mục tiêu

Triển khai chương trình DES/TripleDES theo hợp đồng đầu vào `stdin`, bao gồm:
- DES encrypt với multi-block và zero padding
- DES decrypt với round keys đảo ngược
- TripleDES encrypt/decrypt theo cấu hình E(K3, D(K2, E(K1, P)))
- tạo test minh chứng các trường hợp đúng và negative case

## Cách làm / Method

Sửa `des.cpp` để nhận mode và dữ liệu nhị phân từ stdin. Mã hoá DES dựa trên:
- bảng hoán vị IP / IP^-1
- PC-1, PC-2 và lịch trình round key
- 16 vòng Feistel với expansion, XOR, S-box và P-box

Với mode 1, plaintext dài hơn 64 bit được chia block 64 bit, block cuối cùng được zero padding. Với mode 2, giải mã bằng cách đảo ngược thứ tự round key. TripleDES thực hiện E(K1), D(K2), E(K3) khi mã hóa và ngược lại khi giải mã.

## Kết quả / Result

Đã hoàn thiện chương trình và test như sau:
- `tests/test_des_sample.sh` kiểm tra sample DES đầu ra.
- `tests/test_encrypt_decrypt_roundtrip.sh` kiểm tra DES encrypt rồi decrypt ra lại plaintext.
- `tests/test_multiblock_padding.sh` kiểm tra multi-block và zero padding.
- `tests/test_tamper_negative.sh` kiểm tra dữ liệu bị thay đổi không khôi phục đúng plaintext.
- `tests/test_wrong_key_negative.sh` kiểm tra giải mã với key sai trả về kết quả khác.

CI cũng kiểm tra trực tiếp mode 1 với plaintext > 64 bit và TripleDES mode 3/4.

## Kết luận / Conclusion

Bài lab giúp hiểu rõ hơn cách hoạt động của DES: hoán vị, rời bước tính round key và Feistel. Zero padding đơn giản nhưng không đảm bảo tính toàn vẹn, nên chỉ dùng cho bài học. TripleDES cung cấp lớp bảo mật bổ sung bằng chuỗi E-D-E. Nhóm có thể mở rộng thêm kiểm thử integrity và định dạng input/ output linh hoạt hơn.
