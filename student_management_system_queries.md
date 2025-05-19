# Danh sách câu hỏi và truy vấn SQL cho hệ thống quản lý sinh viên

Tài liệu này cung cấp một danh sách các câu hỏi truy vấn SQL từ cơ bản đến nâng cao cho cơ sở dữ liệu hệ thống quản lý sinh viên đơn giản. Các truy vấn được phân loại theo mức độ phức tạp và loại truy vấn để giúp người học có thể tiếp cận dần dần.

## Truy vấn cơ bản (Basic Queries)

### 1. Truy vấn chọn đơn giản

#### 1.1. Liệt kê tất cả các khoa trong trường
```sql
SELECT * FROM faculties;
```

#### 1.2. Liệt kê tất cả các sinh viên với thông tin cơ bản
```sql
SELECT student_code, first_name, last_name, gender, email
FROM students;
```

#### 1.3. Hiển thị tất cả các môn học và số tín chỉ
```sql
SELECT subject_code, subject_name, credit_hours 
FROM subjects;
```

#### 1.4. Liệt kê tất cả giảng viên và học vị của họ
```sql
SELECT lecturer_code, first_name, last_name, degree
FROM lecturers;
```

### 2. Truy vấn lọc dữ liệu

#### 2.1. Tìm tất cả sinh viên đang học tại trường
```sql
SELECT student_code, first_name, last_name
FROM students
WHERE status = 'Studying';
```

#### 2.2. Tìm tất cả môn học có số tín chỉ lớn hơn 3
```sql
SELECT subject_code, subject_name, credit_hours
FROM subjects
WHERE credit_hours > 3;
```

#### 2.3. Tìm các giảng viên có học vị Tiến sĩ (PhD)
```sql
SELECT lecturer_code, first_name, last_name
FROM lecturers
WHERE degree = 'PhD';
```

#### 2.4. Hiển thị các lớp học trong học kỳ Fall 2023
```sql
SELECT class_code, registration_date, status
FROM classes
WHERE semester = 'Fall' AND year = 2023;
```

### 3. Truy vấn sắp xếp dữ liệu

#### 3.1. Sắp xếp sinh viên theo họ tên
```sql
SELECT student_id, student_code, first_name, last_name
FROM students
ORDER BY last_name, first_name;
```

#### 3.2. Sắp xếp các lớp học theo điểm số giảm dần
```sql
SELECT class_code, subject_id, score, grade
FROM classes
WHERE score IS NOT NULL
ORDER BY score DESC;
```

#### 3.3. Sắp xếp môn học theo số tín chỉ và tên môn học
```sql
SELECT subject_code, subject_name, credit_hours
FROM subjects
ORDER BY credit_hours DESC, subject_name ASC;
```

## Truy vấn liên kết (JOIN Queries)

### 4. Inner JOIN

#### 4.1. Hiển thị sinh viên và tên khoa họ đang theo học
```sql
SELECT s.student_code, s.first_name, s.last_name, f.faculty_name
FROM students s
INNER JOIN faculties f ON s.faculty_id = f.faculty_id;
```

#### 4.2. Hiển thị thông tin về các lớp học với tên môn học và giảng viên phụ trách
```sql
SELECT c.class_code, s.subject_name, 
       CONCAT(l.first_name, ' ', l.last_name) AS lecturer_name,
       c.semester, c.year
FROM classes c
INNER JOIN subjects s ON c.subject_id = s.subject_id
INNER JOIN lecturers l ON c.lecturer_id = l.lecturer_id;
```

#### 4.3. Hiển thị danh sách sinh viên và các môn học họ đã đăng ký
```sql
SELECT s.student_code, s.first_name, s.last_name, 
       subj.subject_name, c.semester, c.year, c.score, c.grade
FROM students s
INNER JOIN classes c ON s.student_id = c.student_id
INNER JOIN subjects subj ON c.subject_id = subj.subject_id;
```

### 5. LEFT JOIN

#### 5.1. Hiển thị tất cả sinh viên và các môn học họ đã đăng ký (nếu có)
```sql
SELECT s.student_code, s.first_name, s.last_name, 
       subj.subject_name, c.score, c.grade
FROM students s
LEFT JOIN classes c ON s.student_id = c.student_id
LEFT JOIN subjects subj ON c.subject_id = subj.subject_id;
```

#### 5.2. Hiển thị tất cả các môn học và số lượng sinh viên đã đăng ký (nếu có)
```sql
SELECT s.subject_code, s.subject_name, COUNT(c.class_id) AS enrollment_count
FROM subjects s
LEFT JOIN classes c ON s.subject_id = c.subject_id
GROUP BY s.subject_id, s.subject_code, s.subject_name;
```

## Truy vấn nhóm và tổng hợp (Grouping and Aggregation)

### 6. Các hàm tổng hợp 

#### 6.1. Tính số lượng sinh viên trong mỗi khoa
```sql
SELECT f.faculty_name, COUNT(s.student_id) AS student_count
FROM faculties f
LEFT JOIN students s ON f.faculty_id = s.faculty_id
GROUP BY f.faculty_id, f.faculty_name;
```

#### 6.2. Tính điểm trung bình của từng sinh viên
```sql
SELECT s.student_code, s.first_name, s.last_name, 
       AVG(c.score) AS average_score
FROM students s
LEFT JOIN classes c ON s.student_id = c.student_id
WHERE c.score IS NOT NULL
GROUP BY s.student_id, s.student_code, s.first_name, s.last_name;
```

#### 6.3. Đếm số lượng giảng viên theo học vị
```sql
SELECT degree, COUNT(*) AS lecturer_count
FROM lecturers
GROUP BY degree
ORDER BY lecturer_count DESC;
```

#### 6.4. Tìm điểm cao nhất, thấp nhất và trung bình cho mỗi môn học
```sql
SELECT s.subject_code, s.subject_name, 
       MAX(c.score) AS max_score,
       MIN(c.score) AS min_score,
       AVG(c.score) AS avg_score,
       COUNT(c.class_id) AS student_count
FROM subjects s
LEFT JOIN classes c ON s.subject_id = c.subject_id
WHERE c.score IS NOT NULL
GROUP BY s.subject_id, s.subject_code, s.subject_name;
```

### 7. HAVING

#### 7.1. Tìm các môn học có điểm trung bình lớn hơn 8.0
```sql
SELECT s.subject_code, s.subject_name, AVG(c.score) AS avg_score
FROM subjects s
JOIN classes c ON s.subject_id = c.subject_id
WHERE c.score IS NOT NULL
GROUP BY s.subject_id, s.subject_code, s.subject_name
HAVING AVG(c.score) > 8.0;
```

#### 7.2. Tìm các khoa có ít nhất 2 sinh viên
```sql
SELECT f.faculty_name, COUNT(s.student_id) AS student_count
FROM faculties f
JOIN students s ON f.faculty_id = s.faculty_id
GROUP BY f.faculty_id, f.faculty_name
HAVING COUNT(s.student_id) >= 2;
```

## Truy vấn nâng cao (Advanced Queries)

### 8. Subqueries

#### 8.1. Tìm các sinh viên có điểm số cao nhất trong môn "Nhập môn lập trình"
```sql
SELECT s.student_code, s.first_name, s.last_name, c.score
FROM students s
JOIN classes c ON s.student_id = c.student_id
JOIN subjects subj ON c.subject_id = subj.subject_id
WHERE subj.subject_name = 'Nhập môn lập trình'
AND c.score = (
    SELECT MAX(c2.score)
    FROM classes c2
    JOIN subjects subj2 ON c2.subject_id = subj2.subject_id
    WHERE subj2.subject_name = 'Nhập môn lập trình'
);
```

#### 8.2. Tìm các giảng viên chưa được phân công dạy lớp nào
```sql
SELECT l.lecturer_code, l.first_name, l.last_name
FROM lecturers l
WHERE l.lecturer_id NOT IN (
    SELECT DISTINCT c.lecturer_id
    FROM classes c
);
```

#### 8.3. Tìm các sinh viên có điểm trung bình cao hơn điểm trung bình của toàn trường
```sql
SELECT s.student_code, s.first_name, s.last_name, AVG(c.score) AS avg_score
FROM students s
JOIN classes c ON s.student_id = c.student_id
WHERE c.score IS NOT NULL
GROUP BY s.student_id, s.student_code, s.first_name, s.last_name
HAVING AVG(c.score) > (
    SELECT AVG(score)
    FROM classes
    WHERE score IS NOT NULL
);
```

### 9. Common Table Expressions (CTE)

#### 9.1. Sử dụng CTE để tính điểm trung bình và xếp hạng sinh viên
```sql
WITH StudentAverages AS (
    SELECT s.student_id, s.student_code, s.first_name, s.last_name,
           AVG(c.score) AS avg_score
    FROM students s
    JOIN classes c ON s.student_id = c.student_id
    WHERE c.score IS NOT NULL
    GROUP BY s.student_id, s.student_code, s.first_name, s.last_name
)
SELECT student_code, first_name, last_name, avg_score,
       RANK() OVER (ORDER BY avg_score DESC) AS rank_position
FROM StudentAverages
ORDER BY rank_position;
```

#### 9.2. Sử dụng CTE để tìm môn học có nhiều sinh viên đăng ký nhất
```sql
WITH SubjectEnrollments AS (
    SELECT s.subject_id, s.subject_name, COUNT(c.class_id) AS enrollment_count
    FROM subjects s
    LEFT JOIN classes c ON s.subject_id = c.subject_id
    GROUP BY s.subject_id, s.subject_name
)
SELECT subject_name, enrollment_count
FROM SubjectEnrollments
WHERE enrollment_count = (SELECT MAX(enrollment_count) FROM SubjectEnrollments);
```

### 10. Truy vấn phân tích (Analytical Queries)

#### 10.1. Phân tích thống kê về điểm số theo khoa
```sql
SELECT f.faculty_name,
       COUNT(c.class_id) AS total_grades,
       AVG(c.score) AS avg_score,
       MIN(c.score) AS min_score,
       MAX(c.score) AS max_score,
       STDDEV(c.score) AS std_dev
FROM faculties f
JOIN students s ON f.faculty_id = s.faculty_id
JOIN classes c ON s.student_id = c.student_id
WHERE c.score IS NOT NULL
GROUP BY f.faculty_id, f.faculty_name
ORDER BY avg_score DESC;
```

#### 10.2. Phân tích tỷ lệ đạt/không đạt theo môn học
```sql
SELECT s.subject_name,
       COUNT(c.class_id) AS total_students,
       SUM(CASE WHEN c.score >= 5.0 THEN 1 ELSE 0 END) AS passed,
       SUM(CASE WHEN c.score < 5.0 THEN 1 ELSE 0 END) AS failed,
       ROUND(SUM(CASE WHEN c.score >= 5.0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS pass_rate
FROM subjects s
JOIN classes c ON s.subject_id = c.subject_id
WHERE c.score IS NOT NULL
GROUP BY s.subject_id, s.subject_name;
```

### 11. Truy vấn tùy chỉnh và kết hợp

#### 11.1. Tìm những sinh viên đã đăng ký tất cả các môn học
```sql
SELECT s.student_code, s.first_name, s.last_name
FROM students s
WHERE NOT EXISTS (
    SELECT * FROM subjects subj
    WHERE NOT EXISTS (
        SELECT * FROM classes c
        WHERE c.student_id = s.student_id
        AND c.subject_id = subj.subject_id
    )
);
```

#### 11.2. Tạo báo cáo thành tích học tập của sinh viên
```sql
SELECT s.student_code, s.first_name, s.last_name, 
       f.faculty_name,
       COUNT(DISTINCT c.subject_id) AS subjects_taken,
       SUM(subj.credit_hours) AS total_credits,
       AVG(c.score) AS average_score,
       CASE 
           WHEN AVG(c.score) >= 9.0 THEN 'Xuất sắc'
           WHEN AVG(c.score) >= 8.0 THEN 'Giỏi'
           WHEN AVG(c.score) >= 7.0 THEN 'Khá'
           WHEN AVG(c.score) >= 5.0 THEN 'Trung bình'
           ELSE 'Yếu'
       END AS performance
FROM students s
JOIN faculties f ON s.faculty_id = f.faculty_id
LEFT JOIN classes c ON s.student_id = c.student_id
LEFT JOIN subjects subj ON c.subject_id = subj.subject_id
WHERE c.score IS NOT NULL
GROUP BY s.student_id, s.student_code, s.first_name, s.last_name, f.faculty_name;
```

#### 11.3. Tìm 3 giảng viên có điểm trung bình của sinh viên cao nhất
```sql
SELECT l.lecturer_code, l.first_name, l.last_name, l.degree,
       AVG(c.score) AS avg_student_score,
       COUNT(DISTINCT c.student_id) AS student_count
FROM lecturers l
JOIN classes c ON l.lecturer_id = c.lecturer_id
WHERE c.score IS NOT NULL
GROUP BY l.lecturer_id, l.lecturer_code, l.first_name, l.last_name, l.degree
ORDER BY avg_student_score DESC
LIMIT 3;
```

## Truy vấn thực tế (Real-world Queries)

### 12. Truy vấn cho báo cáo và phân tích

#### 12.1. Báo cáo tổng hợp về tình hình học tập của sinh viên theo từng học kỳ
```sql
SELECT c.semester, c.year,
       COUNT(DISTINCT c.student_id) AS total_students,
       COUNT(DISTINCT c.subject_id) AS total_subjects,
       AVG(c.score) AS avg_score,
       SUM(CASE WHEN c.grade = 'A' THEN 1 ELSE 0 END) AS grade_a_count,
       SUM(CASE WHEN c.grade = 'B' THEN 1 ELSE 0 END) AS grade_b_count,
       SUM(CASE WHEN c.grade = 'C' THEN 1 ELSE 0 END) AS grade_c_count,
       SUM(CASE WHEN c.grade = 'D' THEN 1 ELSE 0 END) AS grade_d_count,
       SUM(CASE WHEN c.grade = 'F' THEN 1 ELSE 0 END) AS grade_f_count
FROM classes c
WHERE c.score IS NOT NULL
GROUP BY c.semester, c.year
ORDER BY c.year, 
      CASE c.semester
         WHEN 'Spring' THEN 1
         WHEN 'Summer' THEN 2
         WHEN 'Fall' THEN 3
      END;
```

#### 12.2. Phân tích xu hướng điểm số qua các học kỳ với biến động
```sql
WITH SemesterScores AS (
    SELECT c.semester, c.year, 
           AVG(c.score) AS avg_score
    FROM classes c
    WHERE c.score IS NOT NULL
    GROUP BY c.semester, c.year
)
SELECT s1.semester, s1.year, s1.avg_score,
       LAG(s1.avg_score) OVER (ORDER BY s1.year, 
                           CASE s1.semester
                               WHEN 'Spring' THEN 1
                               WHEN 'Summer' THEN 2
                               WHEN 'Fall' THEN 3
                           END) AS prev_semester_avg,
       s1.avg_score - LAG(s1.avg_score) OVER (ORDER BY s1.year, 
                                        CASE s1.semester
                                            WHEN 'Spring' THEN 1
                                            WHEN 'Summer' THEN 2
                                            WHEN 'Fall' THEN 3
                                        END) AS score_change,
       CASE 
           WHEN s1.avg_score - LAG(s1.avg_score) OVER (ORDER BY s1.year, 
                                                 CASE s1.semester
                                                     WHEN 'Spring' THEN 1
                                                     WHEN 'Summer' THEN 2
                                                     WHEN 'Fall' THEN 3
                                                 END) > 0 THEN 'Tăng'
           WHEN s1.avg_score - LAG(s1.avg_score) OVER (ORDER BY s1.year, 
                                                 CASE s1.semester
                                                     WHEN 'Spring' THEN 1
                                                     WHEN 'Summer' THEN 2
                                                     WHEN 'Fall' THEN 3
                                                 END) < 0 THEN 'Giảm'
           ELSE 'Không đổi'
       END AS trend
FROM SemesterScores s1;
```

#### 12.3. Phân tích hiệu suất của giảng viên qua các môn học khác nhau
```sql
SELECT l.lecturer_code, 
       CONCAT(l.first_name, ' ', l.last_name) AS lecturer_name,
       s.subject_name,
       COUNT(c.class_id) AS classes_taught,
       AVG(c.score) AS avg_score,
       MIN(c.score) AS min_score,
       MAX(c.score) AS max_score,
       STDDEV(c.score) AS score_stddev
FROM lecturers l
JOIN classes c ON l.lecturer_id = c.lecturer_id
JOIN subjects s ON c.subject_id = s.subject_id
WHERE c.score IS NOT NULL
GROUP BY l.lecturer_id, l.lecturer_code, l.first_name, l.last_name, s.subject_name
ORDER BY l.lecturer_code, avg_score DESC;
```

### 13. Truy vấn tìm kiếm và phát hiện vấn đề

#### 13.1. Phát hiện các sinh viên có nguy cơ học tập yếu (điểm trung bình dưới 5)
```sql
SELECT s.student_code, s.first_name, s.last_name, 
       f.faculty_name,
       AVG(c.score) AS avg_score,
       COUNT(CASE WHEN c.score < 5 THEN 1 END) AS failed_subjects,
       COUNT(c.class_id) AS total_subjects,
       ROUND(COUNT(CASE WHEN c.score < 5 THEN 1 END) * 100.0 / COUNT(c.class_id), 2) AS failure_rate
FROM students s
JOIN faculties f ON s.faculty_id = f.faculty_id
JOIN classes c ON s.student_id = c.student_id
WHERE c.score IS NOT NULL
GROUP BY s.student_id, s.student_code, s.first_name, s.last_name, f.faculty_name
HAVING AVG(c.score) < 5
ORDER BY avg_score;
```

#### 13.2. Tìm các môn học có tỷ lệ không đạt cao (trên 30%)
```sql
SELECT s.subject_code, s.subject_name,
       COUNT(c.class_id) AS total_students,
       SUM(CASE WHEN c.score < 5 THEN 1 ELSE 0 END) AS failed_students,
       ROUND(SUM(CASE WHEN c.score < 5 THEN 1 ELSE 0 END) * 100.0 / COUNT(c.class_id), 2) AS failure_rate
FROM subjects s
JOIN classes c ON s.subject_id = c.subject_id
WHERE c.score IS NOT NULL
GROUP BY s.subject_id, s.subject_code, s.subject_name
HAVING SUM(CASE WHEN c.score < 5 THEN 1 ELSE 0 END) * 100.0 / COUNT(c.class_id) > 30
ORDER BY failure_rate DESC;
```

## Bài tập thực hành (Practice Exercises)

1. Hiển thị danh sách 3 sinh viên có điểm trung bình cao nhất.
2. Tìm môn học có điểm trung bình cao nhất và thấp nhất.
3. Tìm những sinh viên chưa đăng ký lớp học nào.
4. Tính số lượng sinh viên nam và nữ trong mỗi khoa.
5. Tìm những sinh viên đã đăng ký tất cả các môn học của khoa họ.
6. Tạo báo cáo phân phối điểm (A, B, C, D, F) cho mỗi khoa.
7. Tìm các cặp sinh viên có điểm trung bình giống nhau (trong phạm vi chênh lệch 0.1).
8. Tính tỷ lệ đạt/không đạt của mỗi giảng viên trong các lớp họ dạy.
9. Phân tích sự thay đổi điểm trung bình của sinh viên qua các học kỳ.
10. Tạo một báo cáo về tỷ lệ nam/nữ trong mỗi môn học.

## Lời kết

Danh sách các truy vấn và bài tập này được thiết kế để giúp người học hiểu sâu về SQL và áp dụng vào một trường hợp thực tế là hệ thống quản lý sinh viên. Bạn có thể bắt đầu với các truy vấn cơ bản và dần dần tiến đến các truy vấn phức tạp hơn để nâng cao kỹ năng SQL của mình.
