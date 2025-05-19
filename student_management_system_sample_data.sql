-- Student Management System Sample Data
-- This script inserts sample data into the database tables for testing and demonstration purposes
CREATE DATABASE student_management;

USE student_management;

-- Create FACULTIES table
CREATE TABLE faculties (
    faculty_id INT AUTO_INCREMENT PRIMARY KEY,
    faculty_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- Create STUDENTS table
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

-- Create SUBJECTS table
CREATE TABLE subjects (
    subject_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_code VARCHAR(10) NOT NULL UNIQUE,
    subject_name VARCHAR(100) NOT NULL,
    credit_hours INT NOT NULL,
    description TEXT
);

-- Create LECTURERS table
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

-- Create CLASSES table
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
    UNIQUE KEY (student_id, subject_id, semester, year)
);

-- Insert data into FACULTIES
INSERT INTO faculties (faculty_name, description) VALUES 
('Công nghệ thông tin', 'Khoa đào tạo các chuyên ngành về công nghệ thông tin'),
('Quản trị kinh doanh', 'Khoa đào tạo về quản trị và kinh doanh'),
('Ngôn ngữ Anh', 'Khoa đào tạo ngôn ngữ và văn hóa Anh');

-- Insert data into STUDENTS
INSERT INTO students (student_code, first_name, last_name, gender, birth_date, email, phone, faculty_id, status) VALUES 
('SV001', 'An', 'Trần', 'Male', '2000-05-10', 'an.tran@example.com', '0945678901', 1, 'Studying'),
('SV002', 'Bình', 'Nguyễn', 'Female', '2001-02-15', 'binh.nguyen@example.com', '0956789012', 1, 'Studying'),
('SV003', 'Cường', 'Lê', 'Male', '2000-08-20', 'cuong.le@example.com', '0967890123', 2, 'Studying'),
('SV004', 'Dung', 'Phạm', 'Female', '2001-11-25', 'dung.pham@example.com', '0978901234', 3, 'Studying');

-- Insert data into SUBJECTS
INSERT INTO subjects (subject_code, subject_name, credit_hours, description) VALUES 
('COMP101', 'Nhập môn lập trình', 3, 'Môn học cơ bản về lập trình'),
('COMP201', 'Cấu trúc dữ liệu và giải thuật', 4, 'Môn học về các cấu trúc dữ liệu và giải thuật'),
('BUSS101', 'Nguyên lý marketing', 3, 'Những nguyên lý cơ bản của marketing'),
('ENGL101', 'Tiếng Anh cơ bản', 3, 'Môn học tiếng Anh dành cho người mới bắt đầu');

-- Insert data into LECTURERS
INSERT INTO lecturers (lecturer_code, first_name, last_name, email, phone, faculty_id, degree) VALUES 
('GV001', 'Minh', 'Nguyễn', 'minh.nguyen@example.com', '0901234567', 1, 'PhD'),
('GV002', 'Hoa', 'Trần', 'hoa.tran@example.com', '0912345678', 1, 'Master'),
('GV003', 'Tuấn', 'Lê', 'tuan.le@example.com', '0923456789', 2, 'Professor'),
('GV004', 'Mai', 'Phạm', 'mai.pham@example.com', '0934567890', 3, 'PhD');

-- Insert data into CLASSES
INSERT INTO classes (class_code, subject_id, lecturer_id, student_id, semester, year, registration_date, score, grade, status) VALUES 
('COMP101-01', 1, 1, 1, 'Fall', 2023, '2023-08-15 10:30:00', 8.5, 'A', 'Completed'),
('COMP201-01', 2, 2, 1, 'Fall', 2023, '2023-08-15 10:35:00', NULL, NULL, 'Registered'),
('COMP101-02', 1, 1, 2, 'Fall', 2023, '2023-08-16 09:00:00', 7.5, 'B', 'Completed'),
('BUSS101-01', 3, 3, 3, 'Fall', 2023, '2023-08-17 14:20:00', NULL, NULL, 'Registered'),
('ENGL101-01', 4, 4, 4, 'Fall', 2023, '2023-08-18 11:15:00', 9.0, 'A', 'Completed');

