# Giải Bài Tập Chuẩn Hóa Quan Hệ

## Bài 1
> Cho R(U), U={A, B, C, D, E, G}, F={B→C, AC→D, D→G, AG→E}. Chuẩn hóa quan hệ về 3NF?

### Giải:

**Bước 1**: Xác định các khóa của lược đồ quan hệ.

Đầu tiên, xác định thuộc tính nào không xuất hiện ở vế phải:
- Các thuộc tính ở vế phải: C, D, G, E
- Thuộc tính không xuất hiện ở vế phải: A, B
- Tập L = {A, B}

Kiểm tra bao đóng của {A, B}:
- Ban đầu: (AB)+ = {A, B}
- B → C, thêm C: (AB)+ = {A, B, C}
- AC → D, thêm D: (AB)+ = {A, B, C, D}
- D → G, thêm G: (AB)+ = {A, B, C, D, G}
- AG → E, thêm E: (AB)+ = {A, B, C, D, G, E} = U

Vậy {A, B} là siêu khóa. Kiểm tra tính tối thiểu:
- A+ = {A} ≠ U
- B+ = {B, C} ≠ U

Vậy {A, B} là khóa của R.

**Bước 2**: Tìm phủ tối thiểu của F.
F = {B → C, AC → D, D → G, AG → E}

Kiểm tra thuộc tính dư thừa ở vế trái:
- B → C: không có thuộc tính dư thừa
- AC → D: kiểm tra A+ = {A} và C+ = {C}, không thuộc tính nào đủ để xác định D
- D → G: không có thuộc tính dư thừa
- AG → E: kiểm tra A+ = {A} và G+ = {G}, không thuộc tính nào đủ để xác định E

Kiểm tra phụ thuộc hàm dư thừa:
- Không có phụ thuộc hàm nào dư thừa

Vậy phủ tối thiểu Fmin = {B → C, AC → D, D → G, AG → E}

**Bước 3**: Chuẩn hóa về 3NF theo thuật toán tổng hợp.

Với mỗi phụ thuộc hàm trong Fmin, tạo một quan hệ:
1. R1(B, C) từ B → C
2. R2(A, C, D) từ AC → D
3. R3(D, G) từ D → G
4. R4(A, G, E) từ AG → E

Kiểm tra xem có quan hệ nào chứa khóa của R không:
- Khóa của R là {A, B}
- Không có quan hệ nào chứa đầy đủ {A, B}

Do không có quan hệ nào chứa khóa của R, ta tạo thêm một quan hệ chứa khóa:
5. R5(A, B)

**Bước 4**: Loại bỏ quan hệ thừa.
- Kiểm tra R5(A, B) có phải là tập con của quan hệ nào khác không: Không
- Kiểm tra các quan hệ khác: Không có quan hệ nào là tập con của quan hệ khác

Vậy kết quả chuẩn hóa 3NF của R:
1. R1(B, C) với khóa {B}
2. R2(A, C, D) với khóa {A, C}
3. R3(D, G) với khóa {D}
4. R4(A, G, E) với khóa {A, G}
5. R5(A, B) với khóa {A, B}

## Bài 2
> Cho R(U), U={H, I, K, L, M, N}, F={I→LM, HI→K, K→N, KN→I}. Chuẩn hóa quan hệ về 3NF?

### Giải:

**Bước 1**: Xác định các khóa của lược đồ quan hệ.

Đầu tiên, xác định thuộc tính nào không xuất hiện ở vế phải:
- Các thuộc tính ở vế phải: L, M, K, N, I
- Thuộc tính không xuất hiện ở vế phải: H
- Tập L = {H}

H không đủ để xác định tất cả các thuộc tính. Thử {H, I}:
- Ban đầu: (HI)+ = {H, I}
- I → LM, thêm L, M: (HI)+ = {H, I, L, M}
- HI → K, thêm K: (HI)+ = {H, I, L, M, K}
- K → N, thêm N: (HI)+ = {H, I, L, M, K, N} = U

Vậy {H, I} là siêu khóa. Kiểm tra tính tối thiểu:
- H+ = {H} ≠ U
- I+ = {I, L, M} ≠ U

Vậy {H, I} là một khóa của R.

Thử {H, K}:
- Ban đầu: (HK)+ = {H, K}
- K → N, thêm N: (HK)+ = {H, K, N}
- KN → I, thêm I: (HK)+ = {H, K, N, I}
- I → LM, thêm L, M: (HK)+ = {H, K, N, I, L, M} = U

Vậy {H, K} cũng là một khóa của R.

**Bước 2**: Tìm phủ tối thiểu của F.
F = {I → LM, HI → K, K → N, KN → I}

Tách vế phải:
- I → LM tách thành I → L, I → M
- HI → K
- K → N
- KN → I

Kiểm tra thuộc tính dư thừa ở vế trái:
- I → L, I → M: không có thuộc tính dư thừa
- HI → K: kiểm tra H+ = {H} và I+ = {I, L, M}, không thuộc tính nào đủ để xác định K
- K → N: không có thuộc tính dư thừa
- KN → I: kiểm tra K+ = {K, N} và N+ = {N}, không thuộc tính nào đủ để xác định I

Kiểm tra phụ thuộc hàm dư thừa:
- Không có phụ thuộc hàm nào dư thừa

Vậy phủ tối thiểu Fmin = {I → L, I → M, HI → K, K → N, KN → I}

**Bước 3**: Chuẩn hóa về 3NF theo thuật toán tổng hợp.

Với mỗi phụ thuộc hàm trong Fmin, tạo một quan hệ:
1. R1(I, L) từ I → L
2. R2(I, M) từ I → M
3. R3(H, I, K) từ HI → K
4. R4(K, N) từ K → N
5. R5(K, N, I) từ KN → I

Kiểm tra xem có quan hệ nào chứa khóa của R không:
- Các khóa của R là {H, I} và {H, K}
- R3(H, I, K) chứa khóa {H, I}

**Bước 4**: Loại bỏ quan hệ thừa.
- R1(I, L) và R2(I, M) có thể gộp thành R1'(I, L, M) vì cùng có khóa {I}
- Kiểm tra các quan hệ khác: Không có quan hệ nào là tập con của quan hệ khác

Vậy kết quả chuẩn hóa 3NF của R:
1. R1'(I, L, M) với khóa {I}
2. R3(H, I, K) với khóa {H, I}
3. R4(K, N) với khóa {K}
4. R5(K, N, I) với khóa {K, N} và {N, I}

## Bài 3
> Cho R(U), U={ A, B, C, D, E, F}, F={A→B, BC→D, CE→D, AE→F, CD→A}. Chuẩn hóa quan hệ về 3NF?

### Giải:

**Bước 1**: Xác định các khóa của lược đồ quan hệ.

Đầu tiên, xác định thuộc tính nào không xuất hiện ở vế phải:
- Các thuộc tính ở vế phải: B, D, F, A
- Thuộc tính không xuất hiện ở vế phải: C, E
- Tập L = {C, E}

Kiểm tra bao đóng của {C, E}:
- Ban đầu: (CE)+ = {C, E}
- CE → D, thêm D: (CE)+ = {C, E, D}
- CD → A, thêm A: (CE)+ = {C, E, D, A}
- A → B, thêm B: (CE)+ = {C, E, D, A, B}
- AE → F, thêm F: (CE)+ = {C, E, D, A, B, F} = U

Vậy {C, E} là siêu khóa. Kiểm tra tính tối thiểu:
- C+ = {C} ≠ U
- E+ = {E} ≠ U

Vậy {C, E} là khóa của R.

**Bước 2**: Tìm phủ tối thiểu của F.
F = {A → B, BC → D, CE → D, AE → F, CD → A}

Kiểm tra thuộc tính dư thừa ở vế trái:
- A → B: không có thuộc tính dư thừa
- BC → D: kiểm tra B+ = {B} và C+ = {C}, không thuộc tính nào đủ để xác định D
- CE → D: kiểm tra C+ = {C} và E+ = {E}, không thuộc tính nào đủ để xác định D
- AE → F: kiểm tra A+ = {A, B} và E+ = {E}, không thuộc tính nào đủ để xác định F
- CD → A: kiểm tra C+ = {C} và D+ = {D}, không thuộc tính nào đủ để xác định A

Kiểm tra phụ thuộc hàm dư thừa:
- BC → D và CE → D: cả hai đều không thể thay thế cho nhau

Vậy phủ tối thiểu Fmin = {A → B, BC → D, CE → D, AE → F, CD → A}

**Bước 3**: Chuẩn hóa về 3NF theo thuật toán tổng hợp.

Với mỗi phụ thuộc hàm trong Fmin, tạo một quan hệ:
1. R1(A, B) từ A → B
2. R2(B, C, D) từ BC → D
3. R3(C, E, D) từ CE → D
4. R4(A, E, F) từ AE → F
5. R5(C, D, A) từ CD → A

Kiểm tra xem có quan hệ nào chứa khóa của R không:
- Khóa của R là {C, E}
- R3(C, E, D) chứa khóa {C, E}

**Bước 4**: Loại bỏ quan hệ thừa.
- Kiểm tra các quan hệ: Không có quan hệ nào là tập con của quan hệ khác

Vậy kết quả chuẩn hóa 3NF của R:
1. R1(A, B) với khóa {A}
2. R2(B, C, D) với khóa {B, C}
3. R3(C, E, D) với khóa {C, E}
4. R4(A, E, F) với khóa {A, E}
5. R5(C, D, A) với khóa {C, D}

## Bài 4
> Cho lược đồ quan hệ Q(A,B,C,D,E,G,H) và tập phụ thuộc hàm: F = { E → C; H → E; A → D; A,E → H; D,G → B; D,G → C }
> 1. Hãy xác định tất cả các khóa của Q
> 2. Hãy cho biết Q có đạt 3NF không?
> 3. Tìm phủ tối thiểu của F.
> 4. Phân rã Q về dạng chuẩn 3, yêu cầu phân rã bảo toàn thông tin và phụ thuộc hàm.

### Giải:

#### 1. Xác định tất cả các khóa của Q:

Đầu tiên, xác định thuộc tính nào không xuất hiện ở vế phải:
- Các thuộc tính ở vế phải: C, E, D, H, B
- Thuộc tính không xuất hiện ở vế phải: A, G
- Tập L = {A, G}

Kiểm tra bao đóng của {A, G}:
- Ban đầu: (AG)+ = {A, G}
- A → D, thêm D: (AG)+ = {A, G, D}
- DG → B, thêm B: (AG)+ = {A, G, D, B}
- DG → C, thêm C: (AG)+ = {A, G, D, B, C}
- Không có phụ thuộc hàm nào áp dụng được để thêm E hoặc H
- (AG)+ = {A, G, D, B, C} ≠ U

Vậy {A, G} không phải là siêu khóa. Ta thử thêm các thuộc tính khác:

- {A, G, E}:
  - Ban đầu: (AGE)+ = {A, G, E}
  - A → D, thêm D: (AGE)+ = {A, G, E, D}
  - DG → B, thêm B: (AGE)+ = {A, G, E, D, B}
  - DG → C, thêm C: (AGE)+ = {A, G, E, D, B, C}
  - E → C (đã có C)
  - AE → H, thêm H: (AGE)+ = {A, G, E, D, B, C, H} = U

Vậy {A, G, E} là siêu khóa. Kiểm tra tính tối thiểu:
- (AG)+ = {A, G, D, B, C} ≠ U
- (AE)+ = {A, E, D, C, H} ≠ U
- (GE)+ = {G, E, C} ≠ U

Vậy {A, G, E} là khóa của Q.

- {A, G, H}:
  - Ban đầu: (AGH)+ = {A, G, H}
  - A → D, thêm D: (AGH)+ = {A, G, H, D}
  - DG → B, thêm B: (AGH)+ = {A, G, H, D, B}
  - DG → C, thêm C: (AGH)+ = {A, G, H, D, B, C}
  - H → E, thêm E: (AGH)+ = {A, G, H, D, B, C, E} = U

Vậy {A, G, H} cũng là siêu khóa. Kiểm tra tính tối thiểu:
- (AG)+ = {A, G, D, B, C} ≠ U
- (AH)+ = {A, H, D, E, C} ≠ U
- (GH)+ = {G, H, E, C} ≠ U

Vậy {A, G, H} cũng là khóa của Q.

#### 2. Kiểm tra Q có đạt 3NF không:

Để đạt 3NF, với mọi phụ thuộc hàm X → Y trong F, một trong các điều kiện sau phải thỏa mãn:
- X là siêu khóa, hoặc
- Y là một phần của khóa, hoặc
- Y là thuộc tính khóa

Các khóa của Q là {A, G, E} và {A, G, H}.
Kiểm tra từng phụ thuộc hàm:
- E → C: E không phải siêu khóa, C không phải thuộc tính khóa -> vi phạm 3NF
- H → E: H không phải siêu khóa, E là một phần của khóa {A, G, E} -> thỏa mãn 3NF
- A → D: A không phải siêu khóa, D không phải thuộc tính khóa -> vi phạm 3NF
- AE → H: {A, E} không phải siêu khóa, H là một phần của khóa {A, G, H} -> thỏa mãn 3NF
- DG → B: {D, G} không phải siêu khóa, B không phải thuộc tính khóa -> vi phạm 3NF
- DG → C: {D, G} không phải siêu khóa, C không phải thuộc tính khóa -> vi phạm 3NF

Do có ít nhất một phụ thuộc hàm vi phạm 3NF, nên Q không đạt 3NF.

#### 3. Tìm phủ tối thiểu của F:

F = {E → C, H → E, A → D, AE → H, DG → B, DG → C}

Kiểm tra thuộc tính dư thừa ở vế trái:
- E → C: không có thuộc tính dư thừa
- H → E: không có thuộc tính dư thừa
- A → D: không có thuộc tính dư thừa
- AE → H: kiểm tra A+ = {A, D} và E+ = {E, C}, không thuộc tính nào đủ để xác định H
- DG → B: kiểm tra D+ = {D} và G+ = {G}, không thuộc tính nào đủ để xác định B
- DG → C: tương tự, không thuộc tính nào dư thừa

Kiểm tra phụ thuộc hàm dư thừa:
- Kiểm tra E → C: không thể suy ra từ các phụ thuộc hàm còn lại
- Kiểm tra H → E: không thể suy ra từ các phụ thuộc hàm còn lại
- Kiểm tra A → D: không thể suy ra từ các phụ thuộc hàm còn lại
- Kiểm tra AE → H: không thể suy ra từ các phụ thuộc hàm còn lại
- Kiểm tra DG → B: không thể suy ra từ các phụ thuộc hàm còn lại
- Kiểm tra DG → C: 
  - Từ E → C, ta có C suy ra từ E
  - Nhưng không có cách nào từ DG suy ra E
  - Không thể suy ra DG → C từ các phụ thuộc hàm khác

Vậy phủ tối thiểu Fmin = {E → C, H → E, A → D, AE → H, DG → B, DG → C}

#### 4. Phân rã Q về dạng chuẩn 3NF:

Áp dụng thuật toán tổng hợp với phủ tối thiểu Fmin:
1. R1(E, C) từ E → C
2. R2(H, E) từ H → E
3. R3(A, D) từ A → D
4. R4(A, E, H) từ AE → H
5. R5(D, G, B) từ DG → B
6. R6(D, G, C) từ DG → C

Kiểm tra xem có quan hệ nào chứa khóa của Q không:
- Các khóa của Q là {A, G, E} và {A, G, H}
- Không có quan hệ nào chứa đầy đủ các thuộc tính của một khóa

Do không có quan hệ nào chứa khóa của Q, ta tạo thêm một quan hệ chứa một khóa:
7. R7(A, G, E)

Phân rã cuối cùng của Q về 3NF:
1. R1(E, C) với khóa {E}
2. R2(H, E) với khóa {H}
3. R3(A, D) với khóa {A}
4. R4(A, E, H) với khóa {A, E}
5. R5(D, G, B) với khóa {D, G}
6. R6(D, G, C) với khóa {D, G}
7. R7(A, G, E) với khóa {A, G, E}
