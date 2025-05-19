# Giải Bài Tập Phụ Thuộc Hàm

## Bài 1
> Cho trước tập các phụ thuộc hàm F = {A -> B, C -> D, E -> A} trên tập thuộc tính R = {A, B, C, D, E}. Hãy xác định bao đóng của tập thuộc tính F+.

### Giải:

Để xác định bao đóng của tập phụ thuộc hàm F+, ta cần áp dụng các quy tắc suy diễn Armstrong:

**F = {A -> B, C -> D, E -> A}**

Áp dụng các quy tắc suy diễn, ta có:
1. Từ F đã có: A -> B, C -> D, E -> A
2. Từ quy tắc bắc cầu (transitivity): E -> A và A -> B => E -> B
3. Từ quy tắc phản xạ (reflexivity), ta có:
   - A -> A
   - B -> B
   - C -> C
   - D -> D
   - E -> E
   - AB -> A
   - AB -> B
   - ... và nhiều phụ thuộc hàm tầm thường khác

Vậy bao đóng F+ bao gồm:
- Tất cả phụ thuộc hàm trong F: A -> B, C -> D, E -> A
- Các phụ thuộc hàm suy ra: E -> B
- Tất cả các phụ thuộc hàm tầm thường

## Bài 2
> Cho trước tập các phụ thuộc hàm F = {A -> BC, B -> D, CD -> E} trên tập thuộc tính R = {A, B, C, D, E}. Hãy xác định bao đóng của tập thuộc tính F+.

### Giải:

**F = {A -> BC, B -> D, CD -> E}**

Áp dụng các quy tắc suy diễn:
1. Từ F đã có: A -> BC, B -> D, CD -> E
2. Từ A -> BC, ta có thể phân rã: A -> B và A -> C
3. Từ A -> B và B -> D, ta có: A -> D (bắc cầu)
4. Ta có A -> C và A -> D (từ bước 2, 3), nên A -> CD (hợp)
5. Từ A -> CD và CD -> E, ta có: A -> E (bắc cầu)
6. Kết hợp: A -> BCDE

Vậy bao đóng F+ bao gồm:
- Các phụ thuộc hàm trong F: A -> BC, B -> D, CD -> E
- Các phụ thuộc hàm suy ra: A -> B, A -> C, A -> D, A -> E, A -> CD, A -> BCDE
- Và tất cả các phụ thuộc hàm tầm thường

## Bài 3
> Cho LDQH p = (U, F) với U = ABCDE, F = { A → C, BC → D, D → E, E → A }. Tính:
> 1. (AB)+
> 2. (BD)+
> 3. D+

### Giải:

**F = {A → C, BC → D, D → E, E → A}**

#### 1. Tính (AB)+:
- Ban đầu: (AB)+ = {A, B}
- A → C, thêm C: (AB)+ = {A, B, C}
- BC → D, thêm D: (AB)+ = {A, B, C, D}
- D → E, thêm E: (AB)+ = {A, B, C, D, E}
- E → A (đã có A rồi)
- Vậy (AB)+ = {A, B, C, D, E} = U

#### 2. Tính (BD)+:
- Ban đầu: (BD)+ = {B, D}
- D → E, thêm E: (BD)+ = {B, D, E}
- E → A, thêm A: (BD)+ = {B, D, E, A}
- A → C, thêm C: (BD)+ = {B, D, E, A, C}
- BC → D (đã có D rồi)
- Vậy (BD)+ = {B, D, E, A, C} = U

#### 3. Tính D+:
- Ban đầu: D+ = {D}
- D → E, thêm E: D+ = {D, E}
- E → A, thêm A: D+ = {D, E, A}
- A → C, thêm C: D+ = {D, E, A, C}
- BC → D (đã có D rồi, nhưng chưa có B nên không áp dụng được)
- Vậy D+ = {D, E, A, C}

## Bài 4
> Cho LDQH p = (U, F) với U = ABCDEG, F = { B → C, AC → D, D → G, AG → E }. Chứng minh rằng:
> 1. AB → G ∈ F+?
> 2. BD → AD ∈ F+?

### Giải:

**F = {B → C, AC → D, D → G, AG → E}**

#### 1. Chứng minh AB → G ∈ F+:
Cần chứng minh AB → G thuộc F+ bằng cách tính (AB)+ và kiểm tra xem G có thuộc (AB)+ hay không:
- Ban đầu: (AB)+ = {A, B}
- B → C, thêm C: (AB)+ = {A, B, C}
- AC → D, thêm D: (AB)+ = {A, B, C, D}
- D → G, thêm G: (AB)+ = {A, B, C, D, G}

Ta thấy G ∈ (AB)+, vậy AB → G ∈ F+

#### 2. Chứng minh BD → AD ∈ F+:
Cần chứng minh BD → AD thuộc F+ bằng cách tính (BD)+ và kiểm tra xem AD có thuộc (BD)+ hay không:
- Ban đầu: (BD)+ = {B, D}
- B → C, thêm C: (BD)+ = {B, D, C}
- D → G, thêm G: (BD)+ = {B, D, C, G}

Ta thấy A ∉ (BD)+, nên BD → AD ∉ F+

## Bài 5
> Cho R(U), U={A, B, C, D, E, G}, F={D→G, C→A, CD→E, A→B}. Tìm phủ tối thiểu?

### Giải:

Để tìm phủ tối thiểu Fmin của F, ta thực hiện 3 bước:

**Bước 1**: Tách vế phải của các phụ thuộc hàm
- F = {D → G, C → A, CD → E, A → B}
- F đã ở dạng tách vế phải (mỗi vế phải chỉ có một thuộc tính)

**Bước 2**: Loại bỏ thuộc tính dư thừa ở vế trái
- D → G: không có thuộc tính dư thừa
- C → A: không có thuộc tính dư thừa  
- CD → E: kiểm tra C+ = {C, A, B} và D+ = {D, G}, không thuộc tính nào đủ để xác định E, nên không có thuộc tính dư thừa
- A → B: không có thuộc tính dư thừa

**Bước 3**: Loại bỏ phụ thuộc hàm dư thừa
- Kiểm tra D → G: không thể suy ra từ các phụ thuộc hàm còn lại
- Kiểm tra C → A: không thể suy ra từ các phụ thuộc hàm còn lại
- Kiểm tra CD → E: không thể suy ra từ các phụ thuộc hàm còn lại
- Kiểm tra A → B: không thể suy ra từ các phụ thuộc hàm còn lại

Vậy phủ tối thiểu Fmin = {D → G, C → A, CD → E, A → B}

## Bài 6
> Cho R(U), U={B, Q, I, S, Q}, F={B→I, Q→I, I→S, SQ→I, IQ→B}. Tìm phủ tối thiểu?

### Giải:

Trước tiên, nhận thấy U có hai thuộc tính Q trùng lặp. Giả sử U = {B, Q, I, S}.

**Bước 1**: Tách vế phải
- F = {B → I, Q → I, I → S, SQ → I, IQ → B}
- F đã ở dạng tách vế phải

**Bước 2**: Loại bỏ thuộc tính dư thừa ở vế trái
- B → I: không có thuộc tính dư thừa
- Q → I: không có thuộc tính dư thừa
- I → S: không có thuộc tính dư thừa
- SQ → I: Kiểm tra S+ = {S} và Q+ = {Q, I, S}. Q → I đã có trong tập F, nên S là dư thừa trong SQ → I
- IQ → B: Kiểm tra I+ = {I, S} và Q+ = {Q, I, S}. Không thuộc tính nào đủ để suy ra B, nên không có thuộc tính dư thừa

Sau bước 2, F = {B → I, Q → I, I → S, Q → I, IQ → B}

**Bước 3**: Loại bỏ phụ thuộc hàm dư thừa
- Ta thấy Q → I xuất hiện hai lần, loại bỏ một phụ thuộc
- Kiểm tra B → I: không thể suy ra từ các phụ thuộc hàm còn lại
- Kiểm tra Q → I: không thể suy ra từ các phụ thuộc hàm còn lại
- Kiểm tra I → S: không thể suy ra từ các phụ thuộc hàm còn lại
- Kiểm tra IQ → B: không thể suy ra từ các phụ thuộc hàm còn lại

Vậy phủ tối thiểu Fmin = {B → I, Q → I, I → S, IQ → B}

## Bài 7
> Cho R(U), U = {A, B, C, D, E, F}, F = { A→ B, BC → D, CE → D, AE → F, CD → A}. Tìm phủ tối thiểu?

### Giải:

**Bước 1**: Tách vế phải
- F = {A → B, BC → D, CE → D, AE → F, CD → A}
- F đã ở dạng tách vế phải

**Bước 2**: Loại bỏ thuộc tính dư thừa ở vế trái
- A → B: không có thuộc tính dư thừa
- BC → D: kiểm tra B+ = {B} và C+ = {C}, không thuộc tính nào đủ để xác định D, nên không có thuộc tính dư thừa
- CE → D: kiểm tra C+ = {C} và E+ = {E}, không thuộc tính nào đủ để xác định D, nên không có thuộc tính dư thừa
- AE → F: kiểm tra A+ = {A, B} và E+ = {E}, không thuộc tính nào đủ để xác định F, nên không có thuộc tính dư thừa
- CD → A: không có thuộc tính dư thừa

**Bước 3**: Loại bỏ phụ thuộc hàm dư thừa
- Kiểm tra A → B: không thể suy ra từ các phụ thuộc hàm còn lại
- Kiểm tra BC → D và CE → D: hai phụ thuộc hàm này có cùng vế phải, nhưng không thể suy ra từ nhau
- Kiểm tra AE → F: không thể suy ra từ các phụ thuộc hàm còn lại
- Kiểm tra CD → A: không thể suy ra từ các phụ thuộc hàm còn lại

Vậy phủ tối thiểu Fmin = {A → B, BC → D, CE → D, AE → F, CD → A}
