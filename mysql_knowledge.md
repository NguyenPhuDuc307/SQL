# Kiến thức về SQL và MySQL

## Giới thiệu về SQL

SQL (Structured Query Language) là ngôn ngữ lập trình được thiết kế để quản lý và thao tác với dữ liệu trong hệ thống quản lý cơ sở dữ liệu quan hệ (RDBMS). SQL được sử dụng để:
- Tạo và quản lý cơ sở dữ liệu
- Thêm, cập nhật, xóa dữ liệu
- Truy vấn và lọc dữ liệu
- Quản lý quyền truy cập

## MySQL là gì?

MySQL là một trong những hệ quản trị cơ sở dữ liệu quan hệ (RDBMS) phổ biến nhất, mã nguồn mở và miễn phí. MySQL được phát triển bởi Oracle Corporation và có các đặc điểm:
- Hiệu năng cao
- Độ tin cậy tốt
- Dễ sử dụng
- Hỗ trợ đa nền tảng (Windows, Linux, macOS)
- Tuân thủ chuẩn ANSI SQL

## Các lệnh SQL cơ bản trong MySQL

### 1. Làm việc với cơ sở dữ liệu

**Tạo cơ sở dữ liệu mới:**
```sql
CREATE DATABASE ten_database;
```

**Sử dụng cơ sở dữ liệu:**
```sql
USE ten_database;
```

**Xóa cơ sở dữ liệu:**
```sql
DROP DATABASE ten_database;
```

**Liệt kê các cơ sở dữ liệu:**
```sql
SHOW DATABASES;
```

### 2. Làm việc với bảng

**Tạo bảng mới:**
```sql
CREATE TABLE ten_bang (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ho_ten VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    ngay_sinh DATE,
    luong DECIMAL(10, 2),
    trang_thai BOOLEAN DEFAULT TRUE
);
```

**Liệt kê các bảng:**
```sql
SHOW TABLES;
```

**Xem cấu trúc bảng:**
```sql
DESCRIBE ten_bang;
```
hoặc
```sql
SHOW COLUMNS FROM ten_bang;
```

**Thay đổi cấu trúc bảng:**
```sql
ALTER TABLE ten_bang ADD COLUMN so_dien_thoai VARCHAR(15);
ALTER TABLE ten_bang MODIFY COLUMN ho_ten VARCHAR(150) NOT NULL;
ALTER TABLE ten_bang DROP COLUMN so_dien_thoai;
```

**Xóa bảng:**
```sql
DROP TABLE ten_bang;
```

### 3. Thao tác với dữ liệu (CRUD)

**Thêm dữ liệu (Create):**
```sql
INSERT INTO nhan_vien (ho_ten, email, ngay_sinh, luong)
VALUES ('Nguyễn Văn A', 'nguyenvana@gmail.com', '1990-01-01', 10000000);
```

**Truy vấn dữ liệu (Read):**
```sql
-- Lấy tất cả dữ liệu
SELECT * FROM nhan_vien;

-- Lấy một số cột
SELECT ho_ten, email FROM nhan_vien;

-- Lọc dữ liệu
SELECT * FROM nhan_vien WHERE luong > 8000000;

-- Sắp xếp dữ liệu
SELECT * FROM nhan_vien ORDER BY luong DESC;

-- Giới hạn kết quả
SELECT * FROM nhan_vien LIMIT 10;
```

**Cập nhật dữ liệu (Update):**
```sql
UPDATE nhan_vien 
SET luong = luong * 1.1 
WHERE id = 1;
```

**Xóa dữ liệu (Delete):**
```sql
DELETE FROM nhan_vien WHERE id = 1;
```

## Các thao tác nâng cao trong MySQL

### 1. Joins (Kết hợp bảng)

```sql
-- INNER JOIN: Lấy các bản ghi có giá trị khớp ở cả hai bảng
SELECT nv.ho_ten, pb.ten_phong_ban
FROM nhan_vien nv
INNER JOIN phong_ban pb ON nv.phong_ban_id = pb.id;

-- LEFT JOIN: Lấy tất cả bản ghi từ bảng bên trái và các bản ghi khớp từ bảng bên phải
SELECT nv.ho_ten, pb.ten_phong_ban
FROM nhan_vien nv
LEFT JOIN phong_ban pb ON nv.phong_ban_id = pb.id;

-- RIGHT JOIN: Lấy tất cả bản ghi từ bảng bên phải và các bản ghi khớp từ bảng bên trái
SELECT nv.ho_ten, pb.ten_phong_ban
FROM nhan_vien nv
RIGHT JOIN phong_ban pb ON nv.phong_ban_id = pb.id;
```

### 2. Aggregation Functions (Hàm tổng hợp)

```sql
-- Đếm số lượng nhân viên
SELECT COUNT(*) FROM nhan_vien;

-- Tính tổng lương
SELECT SUM(luong) FROM nhan_vien;

-- Tính trung bình lương
SELECT AVG(luong) FROM nhan_vien;

-- Tìm lương cao nhất
SELECT MAX(luong) FROM nhan_vien;

-- Tìm lương thấp nhất
SELECT MIN(luong) FROM nhan_vien;
```

### 3. GROUP BY và HAVING

```sql
-- Nhóm nhân viên theo phòng ban và đếm số lượng
SELECT phong_ban_id, COUNT(*) as so_nhan_vien
FROM nhan_vien
GROUP BY phong_ban_id;

-- Nhóm và lọc kết quả
SELECT phong_ban_id, AVG(luong) as luong_trung_binh
FROM nhan_vien
GROUP BY phong_ban_id
HAVING AVG(luong) > 9000000;
```

### 4. Subqueries (Truy vấn con)

```sql
-- Tìm nhân viên có lương cao nhất
SELECT * FROM nhan_vien 
WHERE luong = (SELECT MAX(luong) FROM nhan_vien);

-- Tìm nhân viên có lương cao hơn trung bình
SELECT * FROM nhan_vien 
WHERE luong > (SELECT AVG(luong) FROM nhan_vien);
```

### 5. Indexes (Chỉ mục)

```sql
-- Tạo chỉ mục cho cột email
CREATE INDEX idx_email ON nhan_vien(email);

-- Tạo chỉ mục kết hợp
CREATE INDEX idx_ho_ten_email ON nhan_vien(ho_ten, email);

-- Xóa chỉ mục
DROP INDEX idx_email ON nhan_vien;
```

### 6. Transactions (Giao dịch)

```sql
-- Bắt đầu giao dịch
START TRANSACTION;

-- Thực hiện các thao tác
UPDATE tai_khoan SET so_du = so_du - 1000000 WHERE id = 1;
UPDATE tai_khoan SET so_du = so_du + 1000000 WHERE id = 2;

-- Kiểm tra nếu có lỗi thì rollback
-- ROLLBACK;

-- Nếu thành công thì commit
COMMIT;
```

### 7. Stored Procedures (Thủ tục lưu trữ)

```sql
DELIMITER //
CREATE PROCEDURE tang_luong(IN nhan_vien_id INT, IN phan_tram FLOAT)
BEGIN
    UPDATE nhan_vien
    SET luong = luong * (1 + phan_tram/100)
    WHERE id = nhan_vien_id;
END //
DELIMITER ;

-- Gọi thủ tục
CALL tang_luong(1, 10);
```

### 8. Triggers (Bộ kích hoạt)

```sql
DELIMITER //
CREATE TRIGGER before_nhan_vien_update
BEFORE UPDATE ON nhan_vien
FOR EACH ROW
BEGIN
    INSERT INTO nhat_ky_luong(nhan_vien_id, luong_cu, luong_moi, ngay_thay_doi)
    VALUES(OLD.id, OLD.luong, NEW.luong, NOW());
END //
DELIMITER ;
```

### 9. Views (Khung nhìn)

```sql
CREATE VIEW thong_tin_nhan_vien AS
SELECT nv.id, nv.ho_ten, nv.email, pb.ten_phong_ban
FROM nhan_vien nv
JOIN phong_ban pb ON nv.phong_ban_id = pb.id;

-- Truy vấn view
SELECT * FROM thong_tin_nhan_vien;
```

## Các tính năng đặc biệt của MySQL

### 1. Full-Text Search (Tìm kiếm toàn văn)

```sql
-- Tạo chỉ mục FULLTEXT
CREATE FULLTEXT INDEX ft_noi_dung ON bai_viet(tieu_de, noi_dung);

-- Tìm kiếm với MATCH ... AGAINST
SELECT * FROM bai_viet
WHERE MATCH(tieu_de, noi_dung) AGAINST('từ khóa' IN NATURAL LANGUAGE MODE);
```

### 2. Replication (Sao chép)

MySQL hỗ trợ sao chép master-slave để phân tải và sao lưu dữ liệu:

```sql
-- Trên master
GRANT REPLICATION SLAVE ON *.* TO 'repl_user'@'slave_ip' IDENTIFIED BY 'password';
FLUSH TABLES WITH READ LOCK;
SHOW MASTER STATUS; -- Ghi lại file và position

-- Trên slave
CHANGE MASTER TO
    MASTER_HOST='master_ip',
    MASTER_USER='repl_user',
    MASTER_PASSWORD='password',
    MASTER_LOG_FILE='recorded_log_file',
    MASTER_LOG_POS=recorded_position;
START SLAVE;
```

### 3. Partitioning (Phân vùng)

```sql
CREATE TABLE sales (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sale_date DATE,
    amount DECIMAL(10,2)
)
PARTITION BY RANGE (YEAR(sale_date)) (
    PARTITION p0 VALUES LESS THAN (2020),
    PARTITION p1 VALUES LESS THAN (2021),
    PARTITION p2 VALUES LESS THAN (2022),
    PARTITION p3 VALUES LESS THAN (2023),
    PARTITION p4 VALUES LESS THAN MAXVALUE
);
```

## Tối ưu hóa hiệu suất MySQL

### 1. Tối ưu hóa truy vấn

- Sử dụng EXPLAIN để phân tích truy vấn:
  ```sql
  EXPLAIN SELECT * FROM nhan_vien WHERE luong > 10000000;
  ```

- Tránh sử dụng SELECT * khi không cần thiết
- Sử dụng các chỉ mục phù hợp
- Tránh sử dụng hàm trên cột trong mệnh đề WHERE

### 2. Tối ưu hóa cấu hình MySQL

Các thông số quan trọng trong my.cnf:
- innodb_buffer_pool_size: Kích thước bộ nhớ đệm cho InnoDB
- key_buffer_size: Kích thước bộ đệm cho MyISAM
- max_connections: Số kết nối tối đa
- query_cache_size: Kích thước bộ nhớ đệm truy vấn

## Bảo mật MySQL

### 1. Quản lý người dùng và quyền

```sql
-- Tạo người dùng mới
CREATE USER 'ten_nguoi_dung'@'localhost' IDENTIFIED BY 'mat_khau';

-- Cấp quyền
GRANT SELECT, INSERT, UPDATE ON ten_database.* TO 'ten_nguoi_dung'@'localhost';

-- Thu hồi quyền
REVOKE INSERT ON ten_database.* FROM 'ten_nguoi_dung'@'localhost';

-- Xóa người dùng
DROP USER 'ten_nguoi_dung'@'localhost';
```

### 2. Các biện pháp bảo mật khác

- Luôn cập nhật MySQL lên phiên bản mới nhất
- Tắt các tính năng không sử dụng
- Mã hóa kết nối với SSL
- Sử dụng tường lửa để giới hạn truy cập
- Sao lưu dữ liệu thường xuyên

## Công cụ làm việc với MySQL

1. MySQL Workbench: Công cụ đồ họa chính thức để thiết kế, quản lý và truy vấn cơ sở dữ liệu MySQL
2. phpMyAdmin: Giao diện web để quản lý MySQL
3. Sequel Pro/Sequel Ace (macOS): Ứng dụng giao diện đồ họa cho MySQL
4. DBeaver: Công cụ đa nền tảng hỗ trợ nhiều hệ quản trị CSDL khác nhau

## Tài liệu tham khảo

- [Tài liệu chính thức MySQL](https://dev.mysql.com/doc/)
- [MySQL Reference Manual](https://dev.mysql.com/doc/refman/8.0/en/)
- [W3Schools SQL Tutorial](https://www.w3schools.com/sql/)
