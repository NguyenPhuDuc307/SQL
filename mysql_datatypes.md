# Các kiểu dữ liệu trong MySQL

MySQL hỗ trợ nhiều kiểu dữ liệu khác nhau được phân thành các nhóm chính: số, chuỗi, ngày giờ, không gian và JSON. Tài liệu này sẽ giúp bạn hiểu rõ về cách sử dụng các kiểu dữ liệu này.

## 1. Kiểu dữ liệu số (Numeric Data Types)

### 1.1. Kiểu số nguyên (Integer Types)

| Kiểu dữ liệu | Kích thước | Phạm vi (Có dấu) | Phạm vi (Không dấu) |
|--------------|------------|-------------------|---------------------|
| TINYINT      | 1 byte     | -128 đến 127      | 0 đến 255           |
| SMALLINT     | 2 bytes    | -32,768 đến 32,767 | 0 đến 65,535       |
| MEDIUMINT    | 3 bytes    | -8,388,608 đến 8,388,607 | 0 đến 16,777,215 |
| INT (INTEGER) | 4 bytes   | -2^31 đến 2^31-1  | 0 đến 2^32-1        |
| BIGINT       | 8 bytes    | -2^63 đến 2^63-1  | 0 đến 2^64-1        |

**Ví dụ sử dụng:**

```sql
CREATE TABLE sinh_vien (
    ma_sinh_vien TINYINT UNSIGNED,
    tuoi TINYINT UNSIGNED,
    diem_thi SMALLINT,
    hoc_phi INT,
    so_tien_thue BIGINT
);
```

**Thuộc tính thêm:**
- `UNSIGNED`: Chỉ cho phép giá trị không âm, tăng phạm vi giá trị dương lên gấp đôi.
- `ZEROFILL`: Điền các số 0 vào phía trước để điền đủ chiều rộng hiển thị.
- `AUTO_INCREMENT`: Tự động tăng giá trị khi thêm bản ghi mới.

### 1.2. Kiểu số thập phân (Decimal Types)

| Kiểu dữ liệu | Kích thước | Mô tả |
|--------------|------------|-------|
| DECIMAL(M,D), NUMERIC(M,D) | Thay đổi | Số thập phân chính xác. M là tổng số chữ số (tối đa 65), D là số chữ số sau dấu thập phân (tối đa 30) |
| FLOAT(M,D) | 4 bytes | Số thập phân dấu phẩy động độ chính xác đơn |
| DOUBLE(M,D) | 8 bytes | Số thập phân dấu phẩy động độ chính xác kép |

**Ví dụ sử dụng:**

```sql
CREATE TABLE san_pham (
    gia DECIMAL(10,2),
    chiet_khau FLOAT(7,2),
    trong_luong DOUBLE(10,3)
);
```

**Lưu ý:**
- `DECIMAL` được khuyến nghị sử dụng cho dữ liệu tài chính vì tính chính xác cao.
- `FLOAT` và `DOUBLE` có thể gây ra lỗi làm tròn và không nên sử dụng khi cần độ chính xác cao.

### 1.3. Kiểu bit (BIT Type)

`BIT(M)`: Lưu trữ giá trị bit với M có thể từ 1 đến 64. Được sử dụng để lưu trữ dữ liệu nhị phân.

**Ví dụ:**
```sql
CREATE TABLE cau_hinh (
    trang_thai BIT(1),
    quyen_han BIT(8)
);
```

## 2. Kiểu dữ liệu chuỗi (String Types)

### 2.1. Kiểu chuỗi ký tự (Character String Types)

| Kiểu dữ liệu | Kích thước tối đa | Mô tả |
|--------------|-------------------|-------|
| CHAR(M) | M ký tự (tối đa 255) | Chuỗi có độ dài cố định từ 0 đến M |
| VARCHAR(M) | M ký tự (tối đa 65,535) | Chuỗi có độ dài thay đổi từ 0 đến M |

**Ví dụ sử dụng:**

```sql
CREATE TABLE khach_hang (
    ma_quoc_gia CHAR(2),
    ho_ten VARCHAR(100),
    dia_chi VARCHAR(255)
);
```

**Lưu ý:**
- `CHAR` luôn sử dụng đủ số byte được khai báo, phần thừa được điền bằng khoảng trắng.
- `VARCHAR` chỉ sử dụng số byte cần thiết cộng thêm 1-2 byte để lưu độ dài.
- Từ MySQL 5.0.3 trở lên, `VARCHAR` hỗ trợ tối đa 65,535 ký tự.

### 2.2. Kiểu chuỗi văn bản (Text Types)

| Kiểu dữ liệu | Kích thước tối đa | Mô tả |
|--------------|-------------------|-------|
| TINYTEXT | 255 bytes | Chuỗi văn bản ngắn |
| TEXT | 65,535 bytes (~64KB) | Chuỗi văn bản |
| MEDIUMTEXT | 16,777,215 bytes (~16MB) | Chuỗi văn bản kích thước trung bình |
| LONGTEXT | 4,294,967,295 bytes (~4GB) | Chuỗi văn bản kích thước lớn |

**Ví dụ sử dụng:**

```sql
CREATE TABLE bai_viet (
    tieu_de VARCHAR(200),
    mo_ta TINYTEXT,
    noi_dung TEXT,
    noi_dung_day_du MEDIUMTEXT,
    noi_dung_html LONGTEXT
);
```

**Lưu ý:**
- Các kiểu TEXT không thể có giá trị mặc định.
- Khi tìm kiếm hoặc sắp xếp, MySQL chỉ sử dụng tiền tố đầu tiên của các cột TEXT.

### 2.3. Kiểu chuỗi nhị phân (Binary String Types)

| Kiểu dữ liệu | Kích thước tối đa | Mô tả |
|--------------|-------------------|-------|
| BINARY(M) | M byte (tối đa 255) | Chuỗi nhị phân có độ dài cố định |
| VARBINARY(M) | M byte (tối đa 65,535) | Chuỗi nhị phân có độ dài thay đổi |
| TINYBLOB | 255 bytes | Đối tượng nhị phân nhỏ |
| BLOB | 65,535 bytes (~64KB) | Đối tượng nhị phân |
| MEDIUMBLOB | 16,777,215 bytes (~16MB) | Đối tượng nhị phân kích thước trung bình |
| LONGBLOB | 4,294,967,295 bytes (~4GB) | Đối tượng nhị phân kích thước lớn |

**Ví dụ sử dụng:**

```sql
CREATE TABLE tai_lieu (
    ma_tai_lieu BINARY(16),
    thumbnail VARBINARY(1000),
    anh_nho TINYBLOB,
    anh_binh_thuong BLOB,
    anh_lon MEDIUMBLOB,
    video LONGBLOB
);
```

**Lưu ý:**
- Kiểu BINARY và VARBINARY so sánh dữ liệu dựa trên giá trị byte, nên phép so sánh phân biệt chữ hoa/thường.
- Kiểu BLOB thường được sử dụng để lưu trữ hình ảnh, âm thanh, hoặc các tệp tin nhị phân khác.

### 2.4. Kiểu liệt kê và tập hợp (ENUM and SET Types)

| Kiểu dữ liệu | Mô tả |
|--------------|-------|
| ENUM('val1', 'val2', ...) | Kiểu liệt kê, cho phép chọn một giá trị từ danh sách đã định nghĩa (tối đa 65,535 giá trị) |
| SET('val1', 'val2', ...) | Kiểu tập hợp, cho phép chọn không hoặc nhiều giá trị từ danh sách đã định nghĩa (tối đa 64 giá trị) |

**Ví dụ sử dụng:**

```sql
CREATE TABLE khach_san (
    hang_phong ENUM('Tiêu chuẩn', 'Cao cấp', 'Deluxe', 'Suite'),
    dich_vu SET('WiFi', 'Bể bơi', 'Phòng gym', 'Spa', 'Buffet sáng')
);
```

**Lưu ý:**
- `ENUM` lưu trữ hiệu quả vì giá trị được lưu dưới dạng chỉ số (1 cho giá trị đầu tiên).
- `SET` cho phép lưu nhiều giá trị cùng lúc, lưu trữ dưới dạng bit.

## 3. Kiểu dữ liệu ngày giờ (Date and Time Types)

| Kiểu dữ liệu | Kích thước | Phạm vi | Định dạng |
|--------------|------------|---------|-----------|
| DATE | 3 bytes | '1000-01-01' đến '9999-12-31' | 'YYYY-MM-DD' |
| TIME | 3 bytes | '-838:59:59' đến '838:59:59' | 'HH:MM:SS' |
| DATETIME | 8 bytes | '1000-01-01 00:00:00' đến '9999-12-31 23:59:59' | 'YYYY-MM-DD HH:MM:SS' |
| TIMESTAMP | 4 bytes | '1970-01-01 00:00:01' UTC đến '2038-01-19 03:14:07' UTC | 'YYYY-MM-DD HH:MM:SS' |
| YEAR[(4)] | 1 byte | 1901 đến 2155 | 'YYYY' |

**Ví dụ sử dụng:**

```sql
CREATE TABLE dat_phong (
    ngay_den DATE,
    thoi_gian_check_in TIME,
    thoi_diem_dat DATETIME,
    cap_nhat_lan_cuoi TIMESTAMP,
    nam_xay_dung YEAR
);
```

**Lưu ý:**
- `TIMESTAMP` tự động chuyển đổi giữa múi giờ và phụ thuộc vào thiết lập múi giờ của máy chủ MySQL.
- `TIMESTAMP` có thể tự động cập nhật khi bản ghi được thêm mới hoặc cập nhật.
- `DATETIME` lưu trữ ngày giờ không phụ thuộc múi giờ.

## 4. Kiểu dữ liệu không gian (Spatial Data Types)

MySQL hỗ trợ các kiểu dữ liệu không gian tuân theo tiêu chuẩn OpenGIS:

| Kiểu dữ liệu | Mô tả |
|--------------|-------|
| GEOMETRY | Có thể lưu trữ bất kỳ kiểu dữ liệu không gian nào |
| POINT | Một điểm (tọa độ X, Y) |
| LINESTRING | Một đường hoặc đường cong |
| POLYGON | Một đa giác |
| MULTIPOINT | Tập hợp các điểm |
| MULTILINESTRING | Tập hợp các đường |
| MULTIPOLYGON | Tập hợp các đa giác |
| GEOMETRYCOLLECTION | Tập hợp các đối tượng không gian |

**Ví dụ sử dụng:**

```sql
CREATE TABLE dia_ly (
    dia_diem POINT,
    duong_ranh_gioi LINESTRING,
    khu_vuc POLYGON
);
```

**Cách thêm dữ liệu:**

```sql
INSERT INTO dia_ly (dia_diem) VALUES (ST_GeomFromText('POINT(10.762622 106.660172)'));
```

**Lưu ý:**
- MySQL cung cấp nhiều hàm để tạo và xử lý dữ liệu không gian.
- Để sử dụng hiệu quả, nên tạo chỉ mục không gian (SPATIAL INDEX).

## 5. Kiểu dữ liệu JSON

Từ MySQL 5.7.8, MySQL hỗ trợ kiểu dữ liệu gốc cho JSON:

```sql
CREATE TABLE san_pham_json (
    id INT PRIMARY KEY,
    thong_so JSON
);
```

**Ví dụ sử dụng:**

```sql
INSERT INTO san_pham_json VALUES (1, '{"ten": "Máy tính xách tay", "hang": "Dell", "gia": 20000000, "thong_so_ky_thuat": {"cpu": "Intel i7", "ram": 16, "o_cung": "512GB SSD"}}');
```

**Truy vấn dữ liệu JSON:**

```sql
-- Trích xuất giá trị từ JSON
SELECT id, thong_so->'$.ten' AS ten_san_pham FROM san_pham_json;

-- Tìm kiếm theo giá trị trong JSON
SELECT * FROM san_pham_json WHERE thong_so->'$.hang' = '"Dell"';

-- Cập nhật dữ liệu JSON
UPDATE san_pham_json SET thong_so = JSON_SET(thong_so, '$.gia', 22000000) WHERE id = 1;
```

**Lưu ý:**
- JSON được lưu trữ trong định dạng nhị phân tối ưu, không phải dưới dạng văn bản thuần túy.
- MySQL cung cấp nhiều hàm JSON để thao tác với dữ liệu JSON.
- JSON không hỗ trợ tạo chỉ mục trực tiếp cho các trường bên trong, nhưng có thể tạo chỉ mục ảo trên các trường được trích xuất.

## 6. Quy tắc chọn kiểu dữ liệu

### 6.1. Các quy tắc chung

1. **Chọn kiểu dữ liệu nhỏ nhất có thể**: Sử dụng kiểu dữ liệu có kích thước nhỏ nhất mà vẫn đảm bảo lưu trữ được dữ liệu lớn nhất dự kiến.

2. **Chọn kiểu dữ liệu phù hợp với nhu cầu**: Sử dụng kiểu dữ liệu phản ánh đúng bản chất của dữ liệu.
   - Dữ liệu số: Sử dụng kiểu số nguyên (INT) hoặc số thập phân (DECIMAL).
   - Văn bản ngắn có độ dài cố định: CHAR
   - Văn bản ngắn có độ dài thay đổi: VARCHAR
   - Văn bản dài: TEXT hoặc các biến thể của nó
   - Dữ liệu nhị phân: BLOB và các biến thể của nó

3. **Tối ưu hiệu suất**:
   - `CHAR` nhanh hơn `VARCHAR` cho việc đọc, nhưng tốn không gian hơn.
   - `INT` nhanh hơn `VARCHAR` cho lưu trữ số.
   - `TIMESTAMP` tốn ít không gian hơn `DATETIME`.

### 6.2. Ví dụ thực tế

**Ví dụ 1: Hệ thống quản lý học sinh**

```sql
CREATE TABLE hoc_sinh (
    ma_hoc_sinh INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ho_ten VARCHAR(100) NOT NULL,
    ngay_sinh DATE NOT NULL,
    gioi_tinh ENUM('Nam', 'Nữ', 'Khác'),
    dia_chi VARCHAR(255),
    email VARCHAR(100) UNIQUE,
    diem_trung_binh DECIMAL(4,2),
    trang_thai BIT(1) DEFAULT 1,
    hinh_anh MEDIUMBLOB,
    ghi_chu TEXT,
    ngay_tao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ngay_cap_nhat TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    thong_tin_them JSON
);
```

**Ví dụ 2: Hệ thống thương mại điện tử**

```sql
CREATE TABLE san_pham (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ma_san_pham CHAR(10) UNIQUE,
    ten_san_pham VARCHAR(200) NOT NULL,
    mo_ta MEDIUMTEXT,
    gia DECIMAL(12,2) NOT NULL,
    so_luong_ton_kho SMALLINT UNSIGNED DEFAULT 0,
    danh_muc ENUM('Điện tử', 'Thời trang', 'Đồ gia dụng', 'Sách', 'Thể thao'),
    tinh_nang SET('Mới', 'Bán chạy', 'Giảm giá', 'Hết hàng'),
    hinh_anh JSON,  -- Lưu trữ mảng URL hình ảnh
    vi_tri_cua_hang POINT,
    ngay_nhap DATE,
    thong_so_ky_thuat JSON,
    ngay_tao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ngay_cap_nhat TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

## 7. Chuyển đổi kiểu dữ liệu

MySQL sẽ tự động chuyển đổi kiểu dữ liệu trong nhiều ngữ cảnh, nhưng bạn cũng có thể thực hiện chuyển đổi tường minh:

```sql
-- Chuyển đổi chuỗi thành số
SELECT CAST('123' AS SIGNED);
SELECT CONVERT('123', SIGNED);

-- Chuyển đổi số thành chuỗi
SELECT CAST(123 AS CHAR);

-- Chuyển đổi giữa các định dạng ngày giờ
SELECT CAST('2023-05-15' AS DATE);
SELECT CONVERT('2023-05-15', DATE);
```

**Lưu ý:**
- Chuyển đổi kiểu dữ liệu không phù hợp có thể dẫn đến mất dữ liệu hoặc giá trị không mong muốn.
- Nên tránh phụ thuộc vào việc tự động chuyển đổi kiểu trong các ứng dụng quan trọng.

## Tổng kết

Việc lựa chọn kiểu dữ liệu phù hợp trong MySQL có ảnh hưởng lớn đến:
- Hiệu suất của cơ sở dữ liệu
- Không gian lưu trữ sử dụng
- Tính chính xác và toàn vẹn của dữ liệu

Khi thiết kế cơ sở dữ liệu, hãy lựa chọn kiểu dữ liệu cẩn thận dựa trên:
1. Bản chất của dữ liệu
2. Kích thước dự kiến
3. Các thao tác sẽ thực hiện
4. Yêu cầu về hiệu suất

---

**Tài liệu tham khảo:**
- [MySQL Documentation - Data Types](https://dev.mysql.com/doc/refman/8.0/en/data-types.html)
- [MySQL Documentation - JSON Data Type](https://dev.mysql.com/doc/refman/8.0/en/json.html)
- [MySQL Documentation - Spatial Data Types](https://dev.mysql.com/doc/refman/8.0/en/spatial-types.html)
