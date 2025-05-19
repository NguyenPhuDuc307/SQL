# Các quan hệ và loại JOIN trong SQL

## Giới thiệu về quan hệ trong cơ sở dữ liệu

Trong cơ sở dữ liệu quan hệ, các *quan hệ* (relationships) mô tả cách dữ liệu trong các bảng khác nhau liên kết với nhau. Hiểu và thiết kế đúng các quan hệ là yếu tố quan trọng để xây dựng cơ sở dữ liệu hiệu quả, tránh dư thừa dữ liệu và đảm bảo tính toàn vẹn.

### Các loại quan hệ cơ bản

#### 1. Quan hệ một-một (One-to-One)

```
+-----------------+         +-------------------+
|   nhan_vien     |         | ho_so_ca_nhan     |
+-----------------+         +-------------------+
| id (PK)         |-------->| id (PK)           |
| ho_ten          |         | nhan_vien_id (FK) |
| email           |         | ngay_sinh         |
+-----------------+         | dia_chi           |
                            +-------------------+
```

Mỗi bản ghi trong bảng A liên kết với tối đa một bản ghi trong bảng B, và ngược lại.

**Ví dụ:** 
- Một người chỉ có một căn cước công dân, và một căn cước công dân chỉ thuộc về một người.
- Một nhân viên chỉ có một hồ sơ cá nhân chi tiết, và một hồ sơ cá nhân chi tiết chỉ thuộc về một nhân viên.

#### 2. Quan hệ một-nhiều (One-to-Many)

```
+---------------+         +---------------+
|   phong_ban   |         |   nhan_vien   |
+---------------+         +---------------+
| id (PK)       |-------->| id (PK)       |
| ten_phong_ban |    |    | ho_ten        |
+---------------+    |    | phong_ban_id  |
                     |    | email         |
                     |    +---------------+
                     |
                     |--->+---------------+
                          | id (PK)       |
                          | ho_ten        |
                          | phong_ban_id  |
                          | email         |
                          +---------------+
```

Mỗi bản ghi trong bảng A có thể liên kết với nhiều bản ghi trong bảng B, nhưng mỗi bản ghi trong bảng B chỉ liên kết với một bản ghi trong bảng A.

**Ví dụ:**
- Một phòng ban có nhiều nhân viên, nhưng mỗi nhân viên chỉ thuộc về một phòng ban.
- Một khách hàng có thể đặt nhiều đơn hàng, nhưng mỗi đơn hàng chỉ thuộc về một khách hàng.

#### 3. Quan hệ nhiều-nhiều (Many-to-Many)

```
+---------------+      +-------------------+      +---------------+
|   hoc_sinh    |      | hoc_sinh_mon_hoc  |      |    mon_hoc    |
+---------------+      +-------------------+      +---------------+
| id (PK)       |----->| hoc_sinh_id (PK)  |<-----| id (PK)       |
| ho_ten        |      | mon_hoc_id (PK)   |      | ten_mon_hoc   |
| lop           |      | diem              |      | so_tin_chi    |
+---------------+      +-------------------+      +---------------+
```

Mỗi bản ghi trong bảng A có thể liên kết với nhiều bản ghi trong bảng B, và ngược lại.

**Ví dụ:**
- Một học sinh có thể học nhiều môn học, và một môn học có thể được học bởi nhiều học sinh.
- Một sản phẩm có thể thuộc nhiều đơn hàng, và một đơn hàng có thể chứa nhiều sản phẩm.

## Các loại JOIN cơ bản trong SQL

JOIN là thao tác kết hợp dữ liệu từ nhiều bảng dựa trên các cột liên quan giữa chúng. Dưới đây là 4 loại JOIN cơ bản được sử dụng phổ biến nhất.

### Ví dụ bảng dữ liệu

Để minh họa các loại JOIN, chúng ta sẽ sử dụng hai bảng mẫu:

```sql
-- Bảng nhân viên
CREATE TABLE nhan_vien (
    id INT PRIMARY KEY,
    ten VARCHAR(100),
    phong_ban_id INT
);

-- Bảng phòng ban
CREATE TABLE phong_ban (
    id INT PRIMARY KEY,
    ten_phong_ban VARCHAR(100)
);

-- Dữ liệu mẫu
INSERT INTO phong_ban VALUES
(1, 'Kỹ thuật'),
(2, 'Marketing'),
(3, 'Nhân sự'),
(4, 'Kinh doanh');

INSERT INTO nhan_vien VALUES
(1, 'Nguyễn Văn A', 1),
(2, 'Trần Thị B', 2),
(3, 'Lê Văn C', 1),
(4, 'Phạm Thị D', 3),
(5, 'Hoàng Văn E', NULL);
```

### 1. INNER JOIN

```
+-------------+-------------+
|  INNER JOIN | Chỉ phần   |
|             | giao nhau   |
+-------------+-------------+
|             |             |
|    +---+    |             |
|    |XXX|    |             |
|    +---+    |             |
|             |             |
+-------------+-------------+
  Bảng A        Bảng B
```

- **Mô tả**: Chỉ trả về các bản ghi có giá trị khớp ở cả hai bảng.
- **Cú pháp**:

```sql
SELECT cot1, cot2, ...
FROM bang1
INNER JOIN bang2
ON bang1.cot_chung = bang2.cot_chung;
```

- **Ví dụ**:

```sql
SELECT nv.id, nv.ten, pb.ten_phong_ban
FROM nhan_vien nv
INNER JOIN phong_ban pb
ON nv.phong_ban_id = pb.id;
```

- **Kết quả**:

```
id | ten         | ten_phong_ban
---+-------------+--------------
1  | Nguyễn Văn A | Kỹ thuật
2  | Trần Thị B   | Marketing
3  | Lê Văn C     | Kỹ thuật
4  | Phạm Thị D   | Nhân sự
```

*Lưu ý*: Nhân viên "Hoàng Văn E" không xuất hiện trong kết quả vì phong_ban_id là NULL.

### 2. LEFT JOIN (LEFT OUTER JOIN)

```
+-------------+-------------+
|  LEFT JOIN  | Toàn bộ     |
|             | bảng A + phần|
|             | giao với B   |
+-------------+-------------+
|             |             |
|    +---+    |             |
|    |XXX|XXX |             |
|    +---+    |             |
|             |             |
+-------------+-------------+
  Bảng A        Bảng B
```

- **Mô tả**: Trả về tất cả các bản ghi từ bảng bên trái (bang1) và các bản ghi khớp từ bảng bên phải (bang2). Nếu không có bản ghi khớp, các cột từ bảng bên phải sẽ có giá trị NULL.
- **Cú pháp**:

```sql
SELECT cot1, cot2, ...
FROM bang1
LEFT JOIN bang2
ON bang1.cot_chung = bang2.cot_chung;
```

- **Ví dụ**:

```sql
SELECT nv.id, nv.ten, pb.ten_phong_ban
FROM nhan_vien nv
LEFT JOIN phong_ban pb
ON nv.phong_ban_id = pb.id;
```

- **Kết quả**:

```
id | ten         | ten_phong_ban
---+-------------+--------------
1  | Nguyễn Văn A | Kỹ thuật
2  | Trần Thị B   | Marketing
3  | Lê Văn C     | Kỹ thuật
4  | Phạm Thị D   | Nhân sự
5  | Hoàng Văn E  | NULL
```

### 3. RIGHT JOIN (RIGHT OUTER JOIN)

```
+-------------+-------------+
| RIGHT JOIN  | Toàn bộ     |
|             | bảng B + phần|
|             | giao với A   |
+-------------+-------------+
|             |             |
|    +---+    |             |
|    |XXX|    |             |
|    |XXX|    |             |
|    +---+    |             |
+-------------+-------------+
  Bảng A        Bảng B
```

- **Mô tả**: Trả về tất cả các bản ghi từ bảng bên phải (bang2) và các bản ghi khớp từ bảng bên trái (bang1). Nếu không có bản ghi khớp, các cột từ bảng bên trái sẽ có giá trị NULL.
- **Cú pháp**:

```sql
SELECT cot1, cot2, ...
FROM bang1
RIGHT JOIN bang2
ON bang1.cot_chung = bang2.cot_chung;
```

- **Ví dụ**:

```sql
SELECT nv.id, nv.ten, pb.ten_phong_ban
FROM nhan_vien nv
RIGHT JOIN phong_ban pb
ON nv.phong_ban_id = pb.id;
```

- **Kết quả**:

```
id | ten         | ten_phong_ban
---+-------------+--------------
1  | Nguyễn Văn A | Kỹ thuật
3  | Lê Văn C     | Kỹ thuật
2  | Trần Thị B   | Marketing
4  | Phạm Thị D   | Nhân sự
NULL | NULL        | Kinh doanh
```

*Lưu ý*: Phòng ban "Kinh doanh" xuất hiện trong kết quả với các giá trị NULL cho các cột của nhân viên vì không có nhân viên nào thuộc phòng ban này.

### 4. FULL JOIN (FULL OUTER JOIN)

```
+-------------+-------------+
|  FULL JOIN  | Toàn bộ     |
|             | bảng A và B  |
+-------------+-------------+
|             |             |
|    +---+    |             |
|    |XXX|XXX |             |
|    |XXX|XXX |             |
|    +---+    |             |
+-------------+-------------+
  Bảng A        Bảng B
```

- **Mô tả**: Trả về tất cả các bản ghi khi có khớp ở một trong hai bảng. Các giá trị NULL sẽ được sử dụng cho các cột của bảng không có khớp.
- **Cú pháp** (cho các hệ quản trị như PostgreSQL):

```sql
SELECT cot1, cot2, ...
FROM bang1
FULL JOIN bang2
ON bang1.cot_chung = bang2.cot_chung;
```

- **Mô phỏng FULL JOIN trong MySQL** (MySQL không hỗ trợ trực tiếp FULL JOIN):

```sql
SELECT nv.id, nv.ten, pb.ten_phong_ban
FROM nhan_vien nv
LEFT JOIN phong_ban pb ON nv.phong_ban_id = pb.id

UNION

SELECT nv.id, nv.ten, pb.ten_phong_ban
FROM nhan_vien nv
RIGHT JOIN phong_ban pb ON nv.phong_ban_id = pb.id
WHERE nv.id IS NULL;
```

- **Kết quả**:

```
id | ten         | ten_phong_ban
---+-------------+--------------
1  | Nguyễn Văn A | Kỹ thuật
2  | Trần Thị B   | Marketing
3  | Lê Văn C     | Kỹ thuật
4  | Phạm Thị D   | Nhân sự
5  | Hoàng Văn E  | NULL
NULL | NULL        | Kinh doanh
```

## Sơ đồ tổng hợp 4 loại JOIN cơ bản

```
+-------------+-------------+-------------+-------------+
|  INNER JOIN |  LEFT JOIN  | RIGHT JOIN  |  FULL JOIN  |
+-------------+-------------+-------------+-------------+
|             |             |             |             |
|    +---+    |    +---+    |    +---+    |    +---+    |
|    |XXX|    |    |XXX|XXX |    |XXX|    |    |XXX|XXX |
|    +---+    |    +---+    |    |XXX|    |    |XXX|XXX |
|             |             |    +---+    |    +---+    |
+-------------+-------------+-------------+-------------+
|  Chỉ phần  | Tất cả từ  | Tất cả từ   | Tất cả từ   |
| chung giữa | bảng trái  | bảng phải   | cả hai bảng |
| hai bảng   | + phần khớp| + phần khớp | và phần khớp|
+-------------+-------------+-------------+-------------+
```

## Tài liệu tham khảo:

- [MySQL Documentation - JOIN](https://dev.mysql.com/doc/refman/8.0/en/join.html)
- [W3Schools SQL Tutorial - SQL Joins](https://www.w3schools.com/sql/sql_join.asp)
- [MySQL Documentation - Optimization](https://dev.mysql.com/doc/refman/8.0/en/optimization.html)
