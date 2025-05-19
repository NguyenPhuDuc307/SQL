# Thiết kế cơ sở dữ liệu Hệ thống Quản lý Sinh viên (Phiên bản đơn giản)

## Giới thiệu
Đây là phiên bản đơn giản hóa của hệ thống quản lý sinh viên, chỉ bao gồm 5 bảng cơ bản nhất để dễ dàng học tập và triển khai.

## 1. Mô hình thực thể mối quan hệ (ERD)

```
+----------------+      +----------------+      +----------------+
|   FACULTIES    |      |     STUDENTS   |      |    SUBJECTS    |
+----------------+      +----------------+      +----------------+
| faculty_id (PK)|----->| student_id (PK)|      | subject_id (PK)|
| faculty_name   |      | student_code   |      | subject_code   |
| description    |      | first_name     |      | subject_name   |
+----------------+      | last_name      |      | credit_hours   |
         |              | gender         |      | description    |
         |              | birth_date     |      +----------------+
         |              | faculty_id (FK)|             |
         v              +----------------+             |
+----------------+             |                       |
|    LECTURERS   |             |                       |
+----------------+             |                       |
| lecturer_id (PK)|            |                       v
| lecturer_code   |            |               +----------------+
| first_name      |            |               |     CLASSES    |
| last_name       |            |               +----------------+
| faculty_id (FK) |----+       +-------------->| class_id (PK)  |
+----------------+    |                        | class_code     |
                      |                        | subject_id (FK)|
                      +----------------------->| lecturer_id(FK)|
                                               | student_id (FK)|
                                               | semester       |
                                               | year           |
                                               | score          |
                                               | grade          |
                                               +----------------+
```

## 2. Chi tiết các bảng

### 2.1. Bảng FACULTIES (Khoa)

| Tên cột      | Kiểu dữ liệu | Mô tả         | Ràng buộc                   |
| ------------ | ------------ | ------------- | --------------------------- |
| faculty_id   | INT          | ID của khoa   | PRIMARY KEY, AUTO_INCREMENT |
| faculty_name | VARCHAR(100) | Tên khoa      | NOT NULL, UNIQUE            |
| description  | TEXT         | Mô tả về khoa | NULL                        |

### 2.2. Bảng STUDENTS (Sinh viên)

| Tên cột      | Kiểu dữ liệu                                          | Mô tả              | Ràng buộc                                              |
| ------------ | ----------------------------------------------------- | ------------------ | ------------------------------------------------------ |
| student_id   | INT                                                   | ID của sinh viên   | PRIMARY KEY, AUTO_INCREMENT                            |
| student_code | VARCHAR(10)                                           | Mã số sinh viên    | NOT NULL, UNIQUE                                       |
| first_name   | VARCHAR(50)                                           | Tên                | NOT NULL                                               |
| last_name    | VARCHAR(50)                                           | Họ và tên đệm      | NOT NULL                                               |
| gender       | ENUM('Male', 'Female', 'Other')                       | Giới tính          | NOT NULL                                               |
| birth_date   | DATE                                                  | Ngày sinh          | NOT NULL                                               |
| email        | VARCHAR(100)                                          | Email              | NOT NULL, UNIQUE                                       |
| phone        | VARCHAR(20)                                           | Số điện thoại      | NULL                                                   |
| faculty_id   | INT                                                   | ID của khoa        | FOREIGN KEY references FACULTIES(faculty_id), NOT NULL |
| status       | ENUM('Studying', 'Graduated', 'Suspended', 'Dropped') | Trạng thái học tập | DEFAULT 'Studying'                                     |

### 2.3. Bảng SUBJECTS (Môn học)

| Tên cột      | Kiểu dữ liệu | Mô tả          | Ràng buộc                   |
| ------------ | ------------ | -------------- | --------------------------- |
| subject_id   | INT          | ID của môn học | PRIMARY KEY, AUTO_INCREMENT |
| subject_code | VARCHAR(10)  | Mã môn học     | NOT NULL, UNIQUE            |
| subject_name | VARCHAR(100) | Tên môn học    | NOT NULL                    |
| credit_hours | INT          | Số tín chỉ     | NOT NULL                    |
| description  | TEXT         | Mô tả môn học  | NULL                        |

### 2.4. Bảng LECTURERS (Giảng viên)

| Tên cột       | Kiểu dữ liệu                                   | Mô tả                  | Ràng buộc                                              |
| ------------- | ---------------------------------------------- | ---------------------- | ------------------------------------------------------ |
| lecturer_id   | INT                                            | ID của giảng viên      | PRIMARY KEY, AUTO_INCREMENT                            |
| lecturer_code | VARCHAR(10)                                    | Mã giảng viên          | NOT NULL, UNIQUE                                       |
| first_name    | VARCHAR(50)                                    | Tên                    | NOT NULL                                               |
| last_name     | VARCHAR(50)                                    | Họ và tên đệm          | NOT NULL                                               |
| email         | VARCHAR(100)                                   | Email                  | NOT NULL, UNIQUE                                       |
| phone         | VARCHAR(20)                                    | Số điện thoại          | NULL                                                   |
| faculty_id    | INT                                            | ID của khoa trực thuộc | FOREIGN KEY references FACULTIES(faculty_id), NOT NULL |
| degree        | ENUM('Bachelor', 'Master', 'PhD', 'Professor') | Học vị                 | NOT NULL                                               |

### 2.5. Bảng CLASSES (Lớp học và điểm số)

| Tên cột           | Kiểu dữ liệu                                           | Mô tả                       | Ràng buộc                                               |
| ----------------- | ------------------------------------------------------ | --------------------------- | ------------------------------------------------------- |
| class_id          | INT                                                    | ID của lớp học              | PRIMARY KEY, AUTO_INCREMENT                             |
| class_code        | VARCHAR(20)                                            | Mã lớp học                  | NOT NULL, UNIQUE                                        |
| subject_id        | INT                                                    | ID của môn học              | FOREIGN KEY references SUBJECTS(subject_id), NOT NULL   |
| lecturer_id       | INT                                                    | ID của giảng viên phụ trách | FOREIGN KEY references LECTURERS(lecturer_id), NOT NULL |
| student_id        | INT                                                    | ID của sinh viên            | FOREIGN KEY references STUDENTS(student_id), NOT NULL   |
| semester          | ENUM('Spring', 'Summer', 'Fall')                       | Học kỳ                      | NOT NULL                                                |
| year              | YEAR                                                   | Năm học                     | NOT NULL                                                |
| registration_date | DATETIME                                               | Ngày giờ đăng ký            | NOT NULL                                                |
| score             | DECIMAL(5,2)                                           | Điểm số                     | DEFAULT NULL                                            |
| grade             | VARCHAR(2)                                             | Điểm chữ                    | DEFAULT NULL                                            |
| status            | ENUM('Registered', 'Completed', 'Cancelled', 'Failed') | Trạng thái                  | DEFAULT 'Registered'                                    |

## 3. Ràng buộc và quan hệ

1. **Khóa ngoại:**
   - STUDENTS.faculty_id -> FACULTIES.faculty_id
   - LECTURERS.faculty_id -> FACULTIES.faculty_id
   - CLASSES.subject_id -> SUBJECTS.subject_id
   - CLASSES.lecturer_id -> LECTURERS.lecturer_id
   - CLASSES.student_id -> STUDENTS.student_id

2. **Các ràng buộc khác:**
   - Một sinh viên không được đăng ký trùng lớp trong cùng học kỳ
   - Điểm số và điểm chữ phải tuân theo quy định của trường
   - Mã sinh viên, mã giảng viên, mã môn học và mã lớp học phải là duy nhất

## 4. Script tạo cơ sở dữ liệu

```sql
CREATE DATABASE student_management;
USE student_management;

-- Tạo bảng FACULTIES (Khoa)
CREATE TABLE faculties (
    faculty_id INT AUTO_INCREMENT PRIMARY KEY,
    faculty_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- Tạo bảng STUDENTS (Sinh viên)
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    student_code VARCHAR(10) NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    birth_date DATE NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    faculty_id INT NOT NULL,
    status ENUM('Studying', 'Graduated', 'Suspended', 'Dropped') DEFAULT 'Studying',
    FOREIGN KEY (faculty_id) REFERENCES faculties(faculty_id)
);

-- Tạo bảng SUBJECTS (Môn học)
CREATE TABLE subjects (
    subject_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_code VARCHAR(10) NOT NULL UNIQUE,
    subject_name VARCHAR(100) NOT NULL,
    credit_hours INT NOT NULL,
    description TEXT
);

-- Tạo bảng LECTURERS (Giảng viên)
CREATE TABLE lecturers (
    lecturer_id INT AUTO_INCREMENT PRIMARY KEY,
    lecturer_code VARCHAR(10) NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    faculty_id INT NOT NULL,
    degree ENUM('Bachelor', 'Master', 'PhD', 'Professor') NOT NULL,
    FOREIGN KEY (faculty_id) REFERENCES faculties(faculty_id)
);

-- Tạo bảng CLASSES (Lớp học và đăng ký)
CREATE TABLE classes (
    class_id INT AUTO_INCREMENT PRIMARY KEY,
    class_code VARCHAR(20) NOT NULL UNIQUE,
    subject_id INT NOT NULL,
    lecturer_id INT NOT NULL,
    student_id INT NOT NULL,
    semester ENUM('Spring', 'Summer', 'Fall') NOT NULL,
    year YEAR NOT NULL,
    registration_date DATETIME NOT NULL,
    score DECIMAL(5,2) DEFAULT NULL,
    grade VARCHAR(2) DEFAULT NULL,
    status ENUM('Registered', 'Completed', 'Cancelled', 'Failed') DEFAULT 'Registered',
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id),
    FOREIGN KEY (lecturer_id) REFERENCES lecturers(lecturer_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    -- Đảm bảo một sinh viên không đăng ký cùng môn học nhiều lần trong cùng học kỳ
    UNIQUE KEY (student_id, subject_id, semester, year)
);
```

## 5. Dữ liệu mẫu

```sql
-- Thêm dữ liệu vào bảng FACULTIES
INSERT INTO faculties (faculty_name, description) VALUES
('Công nghệ thông tin', 'Khoa đào tạo các chuyên ngành về công nghệ thông tin'),
('Quản trị kinh doanh', 'Khoa đào tạo về quản trị và kinh doanh'),
('Ngôn ngữ Anh', 'Khoa đào tạo ngôn ngữ và văn hóa Anh');

-- Thêm dữ liệu vào bảng STUDENTS
INSERT INTO students (student_code, first_name, last_name, gender, birth_date, email, phone, faculty_id, status) VALUES
('SV001', 'An', 'Trần', 'Male', '2000-05-10', 'an.tran@example.com', '0945678901', 1, 'Studying'),
('SV002', 'Bình', 'Nguyễn', 'Female', '2001-02-15', 'binh.nguyen@example.com', '0956789012', 1, 'Studying'),
('SV003', 'Cường', 'Lê', 'Male', '2000-08-20', 'cuong.le@example.com', '0967890123', 2, 'Studying'),
('SV004', 'Dung', 'Phạm', 'Female', '2001-11-25', 'dung.pham@example.com', '0978901234', 3, 'Studying');

-- Thêm dữ liệu vào bảng SUBJECTS
INSERT INTO subjects (subject_code, subject_name, credit_hours, description) VALUES
('COMP101', 'Nhập môn lập trình', 3, 'Môn học cơ bản về lập trình'),
('COMP201', 'Cấu trúc dữ liệu và giải thuật', 4, 'Môn học về các cấu trúc dữ liệu và giải thuật'),
('BUSS101', 'Nguyên lý marketing', 3, 'Những nguyên lý cơ bản của marketing'),
('ENGL101', 'Tiếng Anh cơ bản', 3, 'Môn học tiếng Anh dành cho người mới bắt đầu');

-- Thêm dữ liệu vào bảng LECTURERS
INSERT INTO lecturers (lecturer_code, first_name, last_name, email, phone, faculty_id, degree) VALUES
('GV001', 'Minh', 'Nguyễn', 'minh.nguyen@example.com', '0901234567', 1, 'PhD'),
('GV002', 'Hoa', 'Trần', 'hoa.tran@example.com', '0912345678', 1, 'Master'),
('GV003', 'Tuấn', 'Lê', 'tuan.le@example.com', '0923456789', 2, 'Professor'),
('GV004', 'Mai', 'Phạm', 'mai.pham@example.com', '0934567890', 3, 'PhD');

-- Thêm dữ liệu vào bảng CLASSES
INSERT INTO classes (class_code, subject_id, lecturer_id, student_id, semester, year, registration_date, score, grade, status) VALUES
('COMP101-01', 1, 1, 1, 'Fall', 2023, '2023-08-15 10:30:00', 8.5, 'A', 'Completed'),
('COMP201-01', 2, 2, 1, 'Fall', 2023, '2023-08-15 10:35:00', NULL, NULL, 'Registered'),
('COMP101-02', 1, 1, 2, 'Fall', 2023, '2023-08-16 09:00:00', 7.5, 'B', 'Completed'),
('BUSS101-01', 3, 3, 3, 'Fall', 2023, '2023-08-17 14:20:00', NULL, NULL, 'Registered'),
('ENGL101-01', 4, 4, 4, 'Fall', 2023, '2023-08-18 11:15:00', 9.0, 'A', 'Completed');
```

## 6. Ví dụ truy vấn SQL

### 6.1. Truy vấn cơ bản

```sql
-- Danh sách sinh viên của khoa Công nghệ thông tin
SELECT s.student_id, s.student_code, s.last_name, s.first_name
FROM students s
JOIN faculties f ON s.faculty_id = f.faculty_id
WHERE f.faculty_name = 'Công nghệ thông tin';

-- Danh sách các lớp học của một giảng viên
SELECT c.class_code, s.subject_name, c.semester, c.year
FROM classes c
JOIN subjects s ON c.subject_id = s.subject_id
JOIN lecturers l ON c.lecturer_id = l.lecturer_id
WHERE l.lecturer_code = 'GV001';

-- Danh sách môn học và điểm số của một sinh viên
SELECT s.subject_name, c.semester, c.year, c.score, c.grade
FROM classes c
JOIN subjects s ON c.subject_id = s.subject_id
JOIN students st ON c.student_id = st.student_id
WHERE st.student_code = 'SV001';
```

### 6.2. Truy vấn thống kê

```sql
-- Thống kê số lượng sinh viên theo khoa
SELECT f.faculty_name, COUNT(s.student_id) AS total_students
FROM students s
JOIN faculties f ON s.faculty_id = f.faculty_id
GROUP BY f.faculty_name;

-- Tính điểm trung bình của sinh viên theo từng môn học
SELECT st.student_code, CONCAT(st.last_name, ' ', st.first_name) AS student_name, 
       s.subject_name, AVG(c.score) AS average_score
FROM classes c
JOIN students st ON c.student_id = st.student_id
JOIN subjects s ON c.subject_id = s.subject_id
WHERE c.status = 'Completed'
GROUP BY st.student_id, s.subject_id;

-- Thống kê số lượng sinh viên đạt từng loại điểm chữ
SELECT c.grade, COUNT(*) AS total
FROM classes c
WHERE c.status = 'Completed'
GROUP BY c.grade
ORDER BY c.grade;
```

### 6.3. Truy vấn phức tạp

```sql
-- Tìm các sinh viên chưa đăng ký môn học nào
SELECT s.student_id, s.student_code, s.last_name, s.first_name
FROM students s
LEFT JOIN classes c ON s.student_id = c.student_id
WHERE c.class_id IS NULL;

-- Tìm top 3 môn học có điểm trung bình cao nhất
SELECT s.subject_name, AVG(c.score) AS average_score
FROM classes c
JOIN subjects s ON c.subject_id = s.subject_id
WHERE c.status = 'Completed' AND c.score IS NOT NULL
GROUP BY c.subject_id
ORDER BY average_score DESC
LIMIT 3;

-- Tìm giảng viên có nhiều sinh viên đạt điểm A nhất
SELECT l.lecturer_code, CONCAT(l.last_name, ' ', l.first_name) AS lecturer_name, 
       COUNT(*) AS total_a_grades
FROM classes c
JOIN lecturers l ON c.lecturer_id = l.lecturer_id
WHERE c.grade = 'A'
GROUP BY l.lecturer_id
ORDER BY total_a_grades DESC
LIMIT 1;
```

## Kết luận

Thiết kế cơ sở dữ liệu đơn giản hóa này giúp người học dễ dàng nắm bắt được các khái niệm cơ bản về thiết kế và sử dụng cơ sở dữ liệu quan hệ. Với 5 bảng cơ bản bao gồm các thực thể chính và mối quan hệ giữa chúng, mô hình này đủ để triển khai các chức năng cơ bản của một hệ thống quản lý sinh viên.

Thiết kế này có thể được sử dụng làm nền tảng để học các khái niệm về cơ sở dữ liệu và SQL, sau đó có thể mở rộng thêm khi người học đã nắm vững các khái niệm cơ bản.
