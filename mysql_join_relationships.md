# Các quan hệ và loại JOIN trong SQL

## Giới thiệu về quan hệ trong cơ sở dữ liệu

Trong cơ sở dữ liệu quan hệ, các *quan hệ* (relationships) mô tả cách dữ liệu trong các bảng khác nhau liên kết với nhau. Hiểu và thiết kế đúng các quan hệ là yếu tố quan trọng để xây dựng cơ sở dữ liệu hiệu quả, tránh dư thừa dữ liệu và đảm bảo tính toàn vẹn.

### Các loại quan hệ cơ bản

#### 1. Quan hệ một-một (One-to-One)

Mỗi bản ghi trong bảng A liên kết với tối đa một bản ghi trong bảng B, và ngược lại.

**Ví dụ:** 
- Một người chỉ có một căn cước công dân, và một căn cước công dân chỉ thuộc về một người.
- Một nhân viên chỉ có một hồ sơ cá nhân chi tiết, và một hồ sơ cá nhân chi tiết chỉ thuộc về một nhân viên.

**Cách triển khai:**
```sql
CREATE TABLE nhan_vien (
    id INT PRIMARY KEY,
    ho_ten VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE ho_so_ca_nhan (
    id INT PRIMARY KEY,
    nhan_vien_id INT UNIQUE,
    ngay_sinh DATE,
    dia_chi VARCHAR(255),
    so_dien_thoai VARCHAR(20),
    FOREIGN KEY (nhan_vien_id) REFERENCES nhan_vien(id)
);
```

#### 2. Quan hệ một-nhiều (One-to-Many)

Mỗi bản ghi trong bảng A có thể liên kết với nhiều bản ghi trong bảng B, nhưng mỗi bản ghi trong bảng B chỉ liên kết với một bản ghi trong bảng A.

**Ví dụ:**
- Một phòng ban có nhiều nhân viên, nhưng mỗi nhân viên chỉ thuộc về một phòng ban.
- Một khách hàng có thể đặt nhiều đơn hàng, nhưng mỗi đơn hàng chỉ thuộc về một khách hàng.

**Cách triển khai:**
```sql
CREATE TABLE phong_ban (
    id INT PRIMARY KEY,
    ten_phong_ban VARCHAR(100) NOT NULL
);

CREATE TABLE nhan_vien (
    id INT PRIMARY KEY,
    ho_ten VARCHAR(100) NOT NULL,
    phong_ban_id INT,
    FOREIGN KEY (phong_ban_id) REFERENCES phong_ban(id)
);
```

#### 3. Quan hệ nhiều-nhiều (Many-to-Many)

Mỗi bản ghi trong bảng A có thể liên kết với nhiều bản ghi trong bảng B, và ngược lại.

**Ví dụ:**
- Một học sinh có thể học nhiều môn học, và một môn học có thể được học bởi nhiều học sinh.
- Một sản phẩm có thể thuộc nhiều đơn hàng, và một đơn hàng có thể chứa nhiều sản phẩm.

**Cách triển khai:**

Quan hệ nhiều-nhiều được triển khai thông qua một bảng trung gian (bảng liên kết).

```sql
CREATE TABLE san_pham (
    id INT PRIMARY KEY,
    ten_san_pham VARCHAR(100) NOT NULL,
    gia DECIMAL(10, 2) NOT NULL
);

CREATE TABLE don_hang (
    id INT PRIMARY KEY,
    khach_hang_id INT NOT NULL,
    ngay_dat DATETIME NOT NULL,
    trang_thai VARCHAR(20) NOT NULL
);

-- Bảng liên kết cho quan hệ nhiều-nhiều
CREATE TABLE chi_tiet_don_hang (
    don_hang_id INT,
    san_pham_id INT,
    so_luong INT NOT NULL,
    gia_ban DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (don_hang_id, san_pham_id),
    FOREIGN KEY (don_hang_id) REFERENCES don_hang(id),
    FOREIGN KEY (san_pham_id) REFERENCES san_pham(id)
);
```

### Khóa ngoại (Foreign Key)

Khóa ngoại là cơ chế để thực thi các quan hệ giữa các bảng. Một khóa ngoại trong bảng A tham chiếu đến khóa chính của bảng B, tạo ra liên kết giữa hai bảng.

**Các tùy chọn khi xóa/cập nhật:**

1. **CASCADE**: Khi bản ghi cha bị xóa/cập nhật, các bản ghi con liên quan cũng bị xóa/cập nhật.
2. **SET NULL**: Khi bản ghi cha bị xóa/cập nhật, các khóa ngoại trong bản ghi con được đặt thành NULL.
3. **RESTRICT**: Ngăn cản việc xóa/cập nhật bản ghi cha nếu có bản ghi con liên quan.
4. **NO ACTION**: Tương tự như RESTRICT.
5. **SET DEFAULT**: Khi bản ghi cha bị xóa/cập nhật, các khóa ngoại trong bản ghi con được đặt thành giá trị mặc định.

**Ví dụ:**
```sql
CREATE TABLE khach_hang (
    id INT PRIMARY KEY,
    ten VARCHAR(100) NOT NULL
);

CREATE TABLE don_hang (
    id INT PRIMARY KEY,
    khach_hang_id INT,
    ngay_dat DATETIME,
    FOREIGN KEY (khach_hang_id) REFERENCES khach_hang(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
```

## Các loại JOIN trong SQL

JOIN là một thao tác cho phép kết hợp dữ liệu từ hai hoặc nhiều bảng dựa trên các cột liên quan giữa chúng. Có 4 loại JOIN cơ bản, mỗi loại phục vụ một mục đích cụ thể.

Để minh họa các loại JOIN, chúng ta sẽ sử dụng hai bảng mẫu:

```sql
CREATE TABLE nhan_vien (
    id INT PRIMARY KEY,
    ten VARCHAR(100),
    phong_ban_id INT
);

CREATE TABLE phong_ban (
    id INT PRIMARY KEY,
    ten_phong_ban VARCHAR(100)
);

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

INNER JOIN chỉ trả về các bản ghi có giá trị khớp ở cả hai bảng.

```
+---------------+        +---------------+
| nhan_vien     |        | phong_ban     |
+---------------+        +---------------+
| id (PK)       |        | id (PK)       |
| ten           |        | ten_phong_ban |
| phong_ban_id  |<-------+               |
+---------------+        +---------------+

Kết quả của INNER JOIN:

+--------+----------------+
| Chỉ các bản ghi khớp   |
| ở cả hai bảng          |
+--------+----------------+
```

**Cú pháp:**
```sql
SELECT cot1, cot2, ...
FROM bang1
INNER JOIN bang2
ON bang1.cot_chung = bang2.cot_chung;
```

**Ví dụ:**
```sql
SELECT nv.id, nv.ten, pb.ten_phong_ban
FROM nhan_vien nv
INNER JOIN phong_ban pb
ON nv.phong_ban_id = pb.id;
```

**Kết quả:**
```
id | ten         | ten_phong_ban
---+-------------+--------------
1  | Nguyễn Văn A | Kỹ thuật
2  | Trần Thị B   | Marketing
3  | Lê Văn C     | Kỹ thuật
4  | Phạm Thị D   | Nhân sự
```

*Lưu ý: Nhân viên "Hoàng Văn E" không xuất hiện trong kết quả vì phong_ban_id là NULL.*

### 2. LEFT JOIN (hoặc LEFT OUTER JOIN)

LEFT JOIN trả về tất cả các bản ghi từ bảng bên trái và các bản ghi khớp từ bảng bên phải. Nếu không có bản ghi khớp, các cột từ bảng bên phải sẽ có giá trị NULL.

```
+---------------+        +---------------+
| nhan_vien     |        | phong_ban     |
+---------------+        +---------------+
| id (PK)       |        | id (PK)       |
| ten           |        | ten_phong_ban |
| phong_ban_id  |<-------+               |
+---------------+        +---------------+

Kết quả của LEFT JOIN:

+---------------------------+
| Tất cả từ bảng nhan_vien |
| + khớp từ phong_ban      |
+---------------------------+
```

**Cú pháp:**
```sql
SELECT cot1, cot2, ...
FROM bang1
LEFT JOIN bang2
ON bang1.cot_chung = bang2.cot_chung;
```

**Ví dụ:**
```sql
SELECT nv.id, nv.ten, pb.ten_phong_ban
FROM nhan_vien nv
LEFT JOIN phong_ban pb
ON nv.phong_ban_id = pb.id;
```

**Kết quả:**
```
id | ten         | ten_phong_ban
---+-------------+--------------
1  | Nguyễn Văn A | Kỹ thuật
2  | Trần Thị B   | Marketing
3  | Lê Văn C     | Kỹ thuật
4  | Phạm Thị D   | Nhân sự
5  | Hoàng Văn E  | NULL
```

### 3. RIGHT JOIN (hoặc RIGHT OUTER JOIN)

RIGHT JOIN trả về tất cả các bản ghi từ bảng bên phải và các bản ghi khớp từ bảng bên trái. Nếu không có bản ghi khớp, các cột từ bảng bên trái sẽ có giá trị NULL.

```
+---------------+        +---------------+
| nhan_vien     |        | phong_ban     |
+---------------+        +---------------+
| id (PK)       |        | id (PK)       |
| ten           |        | ten_phong_ban |
| phong_ban_id  |<-------+               |
+---------------+        +---------------+

Kết quả của RIGHT JOIN:

+---------------------------+
| Khớp từ nhan_vien        |
| + tất cả từ phong_ban    |
+---------------------------+
```

**Cú pháp:**
```sql
SELECT cot1, cot2, ...
FROM bang1
RIGHT JOIN bang2
ON bang1.cot_chung = bang2.cot_chung;
```

**Ví dụ:**
```sql
SELECT nv.id, nv.ten, pb.ten_phong_ban
FROM nhan_vien nv
RIGHT JOIN phong_ban pb
ON nv.phong_ban_id = pb.id;
```

**Kết quả:**
```
id | ten         | ten_phong_ban
---+-------------+--------------
1  | Nguyễn Văn A | Kỹ thuật
3  | Lê Văn C     | Kỹ thuật
2  | Trần Thị B   | Marketing
4  | Phạm Thị D   | Nhân sự
NULL | NULL        | Kinh doanh
```

*Lưu ý: Phòng ban "Kinh doanh" xuất hiện trong kết quả với các giá trị NULL cho các cột của nhân viên vì không có nhân viên nào thuộc phòng ban này.*

### 4. FULL JOIN (hoặc FULL OUTER JOIN)

FULL JOIN trả về tất cả các bản ghi khi có khớp ở một trong hai bảng. Các giá trị NULL sẽ được sử dụng cho các cột của bảng không có khớp.

```
+---------------+        +---------------+
| nhan_vien     |        | phong_ban     |
+---------------+        +---------------+
| id (PK)       |        | id (PK)       |
| ten           |        | ten_phong_ban |
| phong_ban_id  |<-------+               |
+---------------+        +---------------+

Kết quả của FULL JOIN:

+---------------------------+
| Tất cả từ nhan_vien      |
| + Tất cả từ phong_ban    |
+---------------------------+
```

*Lưu ý: MySQL không hỗ trợ trực tiếp cú pháp FULL JOIN, nhưng có thể mô phỏng bằng cách kết hợp LEFT JOIN và RIGHT JOIN với UNION.*

**Cú pháp (cho các hệ quản trị khác như PostgreSQL):**
```sql
SELECT cot1, cot2, ...
FROM bang1
FULL JOIN bang2
ON bang1.cot_chung = bang2.cot_chung;
```

**Mô phỏng FULL JOIN trong MySQL:**
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

**Kết quả:**
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

### 5. CROSS JOIN

CROSS JOIN tạo ra tích Descartes giữa hai bảng, kết hợp mỗi hàng từ bảng đầu tiên với mỗi hàng từ bảng thứ hai. Điều này có nghĩa là nếu bảng A có n hàng và bảng B có m hàng, kết quả sẽ có n*m hàng.

**Cú pháp:**
```sql
SELECT cot1, cot2, ...
FROM bang1
CROSS JOIN bang2;
```

**Ví dụ:**
```sql
-- Giả sử chúng ta chỉ lấy 2 nhân viên và 2 phòng ban
SELECT nv.ten, pb.ten_phong_ban
FROM (SELECT * FROM nhan_vien LIMIT 2) nv
CROSS JOIN (SELECT * FROM phong_ban LIMIT 2) pb;
```

**Kết quả:**
```
ten         | ten_phong_ban
------------+--------------
Nguyễn Văn A | Kỹ thuật
Nguyễn Văn A | Marketing
Trần Thị B   | Kỹ thuật
Trần Thị B   | Marketing
```

### 6. SELF JOIN

SELF JOIN là một kỹ thuật để kết hợp một bảng với chính nó, như thể nó là hai bảng riêng biệt. Điều này hữu ích cho các quan hệ đệ quy hoặc phân cấp.

**Cú pháp:**
```sql
SELECT a.cot1, b.cot2, ...
FROM bang1 a, bang1 b
WHERE điều_kiện;
```

**Ví dụ:** Giả sử chúng ta có bảng nhân viên với cột quản_ly_id tham chiếu đến nhân viên là quản lý.

```sql
CREATE TABLE nhan_vien_cap_bac (
    id INT PRIMARY KEY,
    ten VARCHAR(100),
    quan_ly_id INT,
    FOREIGN KEY (quan_ly_id) REFERENCES nhan_vien_cap_bac(id)
);

INSERT INTO nhan_vien_cap_bac VALUES
(1, 'Nguyễn Văn Giám Đốc', NULL),
(2, 'Trần Thị Trưởng Phòng', 1),
(3, 'Lê Văn Nhân Viên A', 2),
(4, 'Phạm Thị Nhân Viên B', 2),
(5, 'Hoàng Văn Nhân Viên C', 2);

-- Truy vấn để hiển thị mỗi nhân viên và quản lý của họ
SELECT nv.ten AS nhan_vien, ql.ten AS quan_ly
FROM nhan_vien_cap_bac nv
LEFT JOIN nhan_vien_cap_bac ql
ON nv.quan_ly_id = ql.id;
```

**Kết quả:**
```
nhan_vien       | quan_ly
----------------+-------------------
Nguyễn Văn Giám Đốc | NULL
Trần Thị Trưởng Phòng | Nguyễn Văn Giám Đốc
Lê Văn Nhân Viên A | Trần Thị Trưởng Phòng
Phạm Thị Nhân Viên B | Trần Thị Trưởng Phòng
Hoàng Văn Nhân Viên C | Trần Thị Trưởng Phòng
```

### 7. NATURAL JOIN

NATURAL JOIN là một dạng đặc biệt của JOIN trong đó hệ thống tự động kết hợp các cột có cùng tên trong hai bảng. Thường không được khuyến khích sử dụng vì có thể dẫn đến kết quả không mong muốn nếu hai bảng có nhiều cột trùng tên.

**Cú pháp:**
```sql
SELECT cot1, cot2, ...
FROM bang1
NATURAL JOIN bang2;
```

**Ví dụ:**
```sql
-- Giả sử chúng ta có hai bảng với cột id trùng tên
CREATE TABLE san_pham (
    id INT PRIMARY KEY,
    ten_san_pham VARCHAR(100)
);

CREATE TABLE chi_tiet_san_pham (
    id INT,
    mau_sac VARCHAR(50),
    kich_thuoc VARCHAR(20),
    FOREIGN KEY (id) REFERENCES san_pham(id)
);

INSERT INTO san_pham VALUES 
(1, 'Laptop'), 
(2, 'Điện thoại');

INSERT INTO chi_tiet_san_pham VALUES 
(1, 'Đen', '15 inch'), 
(2, 'Trắng', '6.5 inch');

SELECT * FROM san_pham NATURAL JOIN chi_tiet_san_pham;
```

**Kết quả:**
```
id | ten_san_pham | mau_sac | kich_thuoc
---+-------------+---------+------------
1  | Laptop      | Đen     | 15 inch
2  | Điện thoại  | Trắng   | 6.5 inch
```

### 8. JOIN với điều kiện phức tạp

JOIN không chỉ giới hạn ở các điều kiện đơn giản. Bạn có thể sử dụng nhiều điều kiện hoặc các điều kiện phức tạp.

**Ví dụ:**
```sql
SELECT nv.ten, pb.ten_phong_ban
FROM nhan_vien nv
JOIN phong_ban pb
ON nv.phong_ban_id = pb.id
AND pb.ten_phong_ban LIKE 'K%';
```

Truy vấn này chỉ trả về nhân viên thuộc phòng ban có tên bắt đầu bằng 'K'.

**Kết quả:**
```
ten         | ten_phong_ban
------------+--------------
Nguyễn Văn A | Kỹ thuật
Lê Văn C     | Kỹ thuật
```

### 9. JOIN nhiều bảng

Bạn có thể JOIN nhiều hơn hai bảng trong một truy vấn.

**Ví dụ:**
```sql
CREATE TABLE du_an (
    id INT PRIMARY KEY,
    ten_du_an VARCHAR(100),
    phong_ban_id INT,
    FOREIGN KEY (phong_ban_id) REFERENCES phong_ban(id)
);

INSERT INTO du_an VALUES
(1, 'Dự án A', 1),
(2, 'Dự án B', 2),
(3, 'Dự án C', 1);

SELECT nv.ten, pb.ten_phong_ban, da.ten_du_an
FROM nhan_vien nv
JOIN phong_ban pb ON nv.phong_ban_id = pb.id
LEFT JOIN du_an da ON pb.id = da.phong_ban_id;
```

## Kỹ thuật và khái niệm nâng cao

### 1. Subqueries trong JOIN

Bạn có thể sử dụng subqueries (truy vấn con) trong mệnh đề JOIN.

**Ví dụ:**
```sql
SELECT nv.ten, pb.ten_phong_ban
FROM nhan_vien nv
JOIN (SELECT * FROM phong_ban WHERE id < 3) pb
ON nv.phong_ban_id = pb.id;
```

### 2. JOIN và Aggregation

Kết hợp JOIN với các hàm tổng hợp (aggregation functions) như COUNT, SUM, AVG, v.v.

**Ví dụ:**
```sql
SELECT pb.ten_phong_ban, COUNT(nv.id) AS so_nhan_vien
FROM phong_ban pb
LEFT JOIN nhan_vien nv ON pb.id = nv.phong_ban_id
GROUP BY pb.ten_phong_ban;
```

**Kết quả:**
```
ten_phong_ban | so_nhan_vien
--------------+-------------
Kỹ thuật     | 2
Marketing    | 1
Nhân sự      | 1
Kinh doanh   | 0
```

### 3. USING clause

Khi các cột liên kết trong các bảng có cùng tên, bạn có thể sử dụng mệnh đề USING thay vì ON.

**Cú pháp:**
```sql
SELECT cot1, cot2, ...
FROM bang1
JOIN bang2
USING (cot_chung);
```

**Ví dụ:**
```sql
-- Giả sử cả hai bảng đều có cột phong_ban_id
SELECT nv.ten, pb.ten_phong_ban
FROM nhan_vien nv
JOIN phong_ban pb USING (phong_ban_id);
```

### 4. Non-Equi JOIN

Hầu hết các JOIN sử dụng điều kiện bằng nhau (equi), nhưng bạn cũng có thể sử dụng các toán tử khác như >, <, >=, <=.

**Ví dụ:**
```sql
CREATE TABLE muc_luong (
    muc INT PRIMARY KEY,
    luong_toi_thieu DECIMAL(10,2),
    luong_toi_da DECIMAL(10,2)
);

INSERT INTO muc_luong VALUES
(1, 5000000, 10000000),
(2, 10000001, 15000000),
(3, 15000001, 20000000);

CREATE TABLE nhan_vien_luong (
    id INT PRIMARY KEY,
    ten VARCHAR(100),
    luong DECIMAL(10,2)
);

INSERT INTO nhan_vien_luong VALUES
(1, 'A', 8000000),
(2, 'B', 12000000),
(3, 'C', 18000000);

-- Non-Equi JOIN
SELECT nv.ten, nv.luong, ml.muc
FROM nhan_vien_luong nv
JOIN muc_luong ml
ON nv.luong BETWEEN ml.luong_toi_thieu AND ml.luong_toi_da;
```

**Kết quả:**
```
ten | luong    | muc
----+----------+----
A   | 8000000  | 1
B   | 12000000 | 2
C   | 18000000 | 3
```

## Tối ưu hóa JOIN

### 1. Chỉ mục (Index)

Đảm bảo các cột sử dụng trong mệnh đề JOIN có chỉ mục để tăng hiệu suất truy vấn. Thông thường, khóa chính (PRIMARY KEY) và khóa ngoại (FOREIGN KEY) đều nên được đánh chỉ mục.

```sql
CREATE INDEX idx_phong_ban_id ON nhan_vien(phong_ban_id);
```

### 2. Hạn chế dữ liệu

Sử dụng WHERE để lọc dữ liệu trước khi JOIN, đặc biệt khi làm việc với bảng lớn.

```sql
SELECT nv.ten, pb.ten_phong_ban
FROM nhan_vien nv
JOIN phong_ban pb ON nv.phong_ban_id = pb.id
WHERE nv.id < 100 AND pb.id IN (1, 2, 3);
```

### 3. Tránh CROSS JOIN không cần thiết

CROSS JOIN tạo ra tích Descartes, có thể dẫn đến tập kết quả rất lớn. Hãy đảm bảo bạn luôn có điều kiện JOIN khi làm việc với nhiều bảng.

### 4. Cấu trúc truy vấn

Đôi khi, thay đổi thứ tự của các JOIN hoặc sử dụng subqueries có thể cải thiện hiệu suất.

## Các trường hợp sử dụng thực tế

### 1. Báo cáo doanh số theo sản phẩm và danh mục

```sql
CREATE TABLE danh_muc (
    id INT PRIMARY KEY,
    ten_danh_muc VARCHAR(100)
);

CREATE TABLE san_pham_dm (
    id INT PRIMARY KEY,
    ten VARCHAR(100),
    danh_muc_id INT,
    gia DECIMAL(10,2),
    FOREIGN KEY (danh_muc_id) REFERENCES danh_muc(id)
);

CREATE TABLE doanh_so (
    id INT PRIMARY KEY,
    san_pham_id INT,
    ngay_ban DATE,
    so_luong INT,
    FOREIGN KEY (san_pham_id) REFERENCES san_pham_dm(id)
);

-- Truy vấn báo cáo doanh số theo danh mục và sản phẩm
SELECT 
    dm.ten_danh_muc,
    sp.ten AS ten_san_pham,
    SUM(ds.so_luong) AS tong_so_luong,
    SUM(ds.so_luong * sp.gia) AS tong_doanh_thu
FROM doanh_so ds
JOIN san_pham_dm sp ON ds.san_pham_id = sp.id
JOIN danh_muc dm ON sp.danh_muc_id = dm.id
GROUP BY dm.ten_danh_muc, sp.ten
ORDER BY dm.ten_danh_muc, tong_doanh_thu DESC;
```

**Minh họa mối quan hệ giữa các bảng:**

```
+---------------+        +---------------+        +---------------+
|   danh_muc    |        |  san_pham_dm  |        |   doanh_so    |
+---------------+        +---------------+        +---------------+
| id (PK)       |<-------| id (PK)       |<-------| id (PK)       |
| ten_danh_muc  |        | ten           |        | san_pham_id   |
+---------------+        | danh_muc_id   |        | ngay_ban      |
                         | gia           |        | so_luong      |
                         +---------------+        +---------------+

                         Mối quan hệ một-nhiều giữa các bảng
```
```

### 2. Tìm kiếm nhân viên không thuộc dự án nào

```sql
CREATE TABLE du_an_nhan_vien (
    du_an_id INT,
    nhan_vien_id INT,
    PRIMARY KEY (du_an_id, nhan_vien_id),
    FOREIGN KEY (du_an_id) REFERENCES du_an(id),
    FOREIGN KEY (nhan_vien_id) REFERENCES nhan_vien(id)
);

-- Tìm nhân viên không tham gia dự án nào
SELECT nv.id, nv.ten
FROM nhan_vien nv
LEFT JOIN du_an_nhan_vien danv ON nv.id = danv.nhan_vien_id
WHERE danv.du_an_id IS NULL;
```

### 3. Tìm khách hàng có đơn hàng trong tháng này và tháng trước

```sql
CREATE TABLE khach_hang_hang (
    id INT PRIMARY KEY,
    ten VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE don_hang_hang (
    id INT PRIMARY KEY,
    khach_hang_id INT,
    ngay_dat DATE,
    tong_tien DECIMAL(10,2),
    FOREIGN KEY (khach_hang_id) REFERENCES khach_hang_hang(id)
);

-- Tìm khách hàng có đơn hàng trong cả tháng này và tháng trước
SELECT DISTINCT kh.id, kh.ten, kh.email
FROM khach_hang_hang kh
JOIN don_hang_hang dh1 ON kh.id = dh1.khach_hang_id
JOIN don_hang_hang dh2 ON kh.id = dh2.khach_hang_id
WHERE 
    YEAR(dh1.ngay_dat) = YEAR(CURRENT_DATE) AND
    MONTH(dh1.ngay_dat) = MONTH(CURRENT_DATE) AND
    YEAR(dh2.ngay_dat) = YEAR(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)) AND
    MONTH(dh2.ngay_dat) = MONTH(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH));
```

## Tổng kết

Các loại JOIN khác nhau và quan hệ trong cơ sở dữ liệu là công cụ cực kỳ quan trọng để truy vấn và phân tích dữ liệu từ nhiều bảng. Hiểu rõ cách sử dụng chúng giúp bạn thiết kế cơ sở dữ liệu hiệu quả và viết các truy vấn tối ưu.

### Minh họa trực quan các loại JOIN

#### Sơ đồ Venn biểu diễn các loại JOIN

```
                    TableA                TableB
                    .-------.             .-------.
                    |       |             |       |
                    |   A   |             |   B   |
                    |       |             |       |
                    '-------'             '-------'
```

#### 1. INNER JOIN
```
                    TableA                TableB
                    .-------.             .-------.
                    |       |.....        |       |
                    |   A   |    :        |   B   |
                    |       |    :        |       |
                    '-------'    :        '-------'
                             \   :        /
                              \  :       /
                               \ :      /
                                \:     /
                            .----.-----.
                            |    :     |
                            |  INNER   |
                            |  JOIN    |
                            '---------'
```

#### 2. LEFT JOIN
```
                    TableA                TableB
                    .-------.             .-------.
                    |       |.....        |       |
                    |   A   |    :        |   B   |
                    |       |    :        |       |
                    '-------'    :        '-------'
                        |        :        /
                        |        :       /
                        |        :      /
                        |        :     /
                    .----.-------.----.
                    |    :       :    |
                    |  LEFT JOIN      |
                    |                 |
                    '-----------------'
```

#### 3. RIGHT JOIN
```
                    TableA                TableB
                    .-------.             .-------.
                    |       |.....        |       |
                    |   A   |    :        |   B   |
                    |       |    :        |       |
                    '-------'    :        '-------'
                         \       :        |
                          \      :        |
                           \     :        |
                            \    :        |
                    .---------.---.-------.
                    |         :   :       |
                    |    RIGHT JOIN       |
                    |                     |
                    '---------------------'
```

#### 4. FULL JOIN
```
                    TableA                TableB
                    .-------.             .-------.
                    |       |.....        |       |
                    |   A   |    :        |   B   |
                    |       |    :        |       |
                    '-------'    :        '-------'
                        |        :        |
                        |        :        |
                        |        :        |
                    .----.-------.--------.
                    |    :       :        |
                    |                     |
                    |      FULL JOIN      |
                    |                     |
                    '---------------------'
```

#### 5. CROSS JOIN
```
                    TableA                TableB
                    .-------.             .-------.
                    |       |             |       |
                    |   A   | ....        |   B   |
                    |       |    :        |       |
                    '-------'    :        '-------'
                       | |       :           | |
                       | '-------+-----------' |
                       |         :             |
                       |         :             |
                    .---.---------.-----------.-.
                    |   :         :           : |
                    |                           |
                    |       CROSS JOIN          |
                    |                           |
                    '---------------------------'
                    Mọi hàng của A kết hợp với mọi hàng của B
```

#### Minh họa chi tiết các loại JOIN bằng ký tự

```
          INNER JOIN           LEFT JOIN            RIGHT JOIN           FULL JOIN
        +-----------+        +-----------+        +-----------+        +-----------+
        |     |     |        |     |     |        |     |     |        |     |     |
        |     |#####|        |#####|#####|        |#####|     |        |#####|#####|
        |     |     |        |     |     |        |     |     |        |     |     |
        +-----------+        +-----------+        +-----------+        +-----------+
       Chỉ phần chung    Tất cả từ bảng trái   Tất cả từ bảng phải  Tất cả từ cả hai
```

### Minh họa quan hệ cơ sở dữ liệu

#### 1. Quan hệ một-một (One-to-One)

```
+---------------+         +----------------+
|   nhan_vien   |         | ho_so_ca_nhan  |
+---------------+         +----------------+
| id (PK)       |-------->| id (PK)        |
| ho_ten        |         | nhan_vien_id   |
| email         |         | ngay_sinh      |
+---------------+         | dia_chi        |
                          +----------------+
```

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

Để master SQL JOIN, hãy thực hành thường xuyên các loại JOIN khác nhau trên các bộ dữ liệu thực tế với các điều kiện khác nhau. Việc hiểu và sử dụng thành thạo JOIN sẽ giúp bạn trở thành một developer database xuất sắc.

---

**Tài liệu tham khảo:**
- [MySQL Documentation - JOIN](https://dev.mysql.com/doc/refman/8.0/en/join.html)
- [W3Schools SQL Tutorial - SQL Joins](https://www.w3schools.com/sql/sql_join.asp)
- [MySQL Documentation - Optimization](https://dev.mysql.com/doc/refman/8.0/en/optimization.html)
