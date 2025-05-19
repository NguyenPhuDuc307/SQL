# Chỉ mục các bài tập đã giải

## Phụ thuộc hàm (Functional Dependencies)

[1_functional_dependencies_solutions.md](./1_functional_dependencies_solutions.md)

### Nội dung:
- **Bài 1**: Xác định bao đóng F+ của tập phụ thuộc hàm F = {A -> B, C -> D, E -> A} trên R = {A, B, C, D, E}
- **Bài 2**: Xác định bao đóng F+ của tập phụ thuộc hàm F = {A -> BC, B -> D, CD -> E} trên R = {A, B, C, D, E}
- **Bài 3**: Tính (AB)+, (BD)+, D+ với F = {A → C, BC → D, D → E, E → A} trên U = ABCDE
- **Bài 4**: Chứng minh AB → G ∈ F+ và BD → AD ∈ F+ với F = {B → C, AC → D, D → G, AG → E} trên U = ABCDEG
- **Bài 5**: Tìm phủ tối thiểu của F = {D→G, C→A, CD→E, A→B} trên U = {A, B, C, D, E, G}
- **Bài 6**: Tìm phủ tối thiểu của F = {B→I, Q→I, I→S, SQ→I, IQ→B} trên U = {B, Q, I, S}
- **Bài 7**: Tìm phủ tối thiểu của F = {A→ B, BC → D, CE → D, AE → F, CD → A} trên U = {A, B, C, D, E, F}

## Khóa lược đồ quan hệ (Relational Schema Keys)

[2_relational_keys_solutions.md](./2_relational_keys_solutions.md)

### Nội dung:
- **Bài 1**: Tìm tất cả các khóa của R với F = {B→C, AC→D, D→G, AG→E} trên U = {A, B, C, D, E, G}
- **Bài 2**: Tìm tất cả các khóa của R với F = {I→LM, HI→K, K→N, KN→I} trên U = {H, I, K, L, M, N}
- **Bài 3**: Tìm tất cả các khóa của R với F = {A→B, BC→D, CE→D, AE→F, CD→A} trên U = {A, B, C, D, E, F}

## Chuẩn hóa quan hệ (Normalization)

[3_normalization_solutions.md](./3_normalization_solutions.md)

### Nội dung:
- **Bài 1**: Chuẩn hóa quan hệ về 3NF với F = {B→C, AC→D, D→G, AG→E} trên U = {A, B, C, D, E, G}
- **Bài 2**: Chuẩn hóa quan hệ về 3NF với F = {I→LM, HI→K, K→N, KN→I} trên U = {H, I, K, L, M, N}
- **Bài 3**: Chuẩn hóa quan hệ về 3NF với F = {A→B, BC→D, CE→D, AE→F, CD→A} trên U = {A, B, C, D, E, F}
- **Bài 4**: Với lược đồ quan hệ Q(A,B,C,D,E,G,H) và tập phụ thuộc hàm F = {E→C; H→E; A→D; A,E→H; D,G→B; D,G→C}:
  1. Xác định tất cả các khóa của Q
  2. Kiểm tra Q có đạt 3NF không
  3. Tìm phủ tối thiểu của F
  4. Phân rã Q về dạng chuẩn 3NF

## Tổng quan kiến thức lý thuyết

Để hiểu sâu hơn về phụ thuộc hàm, khóa lược đồ và chuẩn hóa quan hệ, bạn có thể tham khảo file:

[5. mysql_dependencies_keys_normalization.md](../knowledge/5.%20mysql_dependencies_keys_normalization.md)
