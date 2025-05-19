# Hệ thống Quản lý Sinh viên

## Phần 1: Phân tích yêu cầu và thiết kế hệ thống

### 1. Mục tiêu của hệ thống

Hệ thống Quản lý Sinh viên được xây dựng nhằm mục đích:
- Quản lý thông tin sinh viên, giảng viên, khoa, ngành học
- Quản lý kết quả học tập của sinh viên (điểm số, học bổng)
- Quản lý lịch học, lớp học và phòng học
- Hỗ trợ việc đăng ký môn học và thanh toán học phí
- Tạo báo cáo thống kê về tình hình học tập

### 2. Yêu cầu chức năng

#### 2.1. Quản lý sinh viên
- Thêm, sửa, xóa, tìm kiếm thông tin sinh viên
- Quản lý thông tin cá nhân: họ tên, ngày sinh, giới tính, địa chỉ, email, số điện thoại
- Quản lý mã số sinh viên, khóa học, ngành học, lớp
- Quản lý tình trạng học tập: đang học, bảo lưu, tốt nghiệp, đã nghỉ học
- Quản lý ảnh đại diện và hồ sơ sinh viên

#### 2.2. Quản lý giảng viên
- Thêm, sửa, xóa, tìm kiếm thông tin giảng viên
- Quản lý thông tin cá nhân: họ tên, ngày sinh, giới tính, địa chỉ, email, số điện thoại
- Quản lý chức vụ, học vị, chuyên ngành, khoa trực thuộc
- Quản lý lịch giảng dạy và môn học phụ trách

#### 2.3. Quản lý khoa và ngành học
- Thêm, sửa, xóa, tìm kiếm thông tin khoa và ngành học
- Quản lý mối quan hệ giữa khoa và ngành học
- Quản lý thông tin trưởng khoa, phó khoa
- Quản lý thông tin về chương trình đào tạo và số tín chỉ tối thiểu

#### 2.4. Quản lý môn học
- Thêm, sửa, xóa, tìm kiếm thông tin môn học
- Quản lý mã môn học, tên môn học, số tín chỉ, khoa quản lý
- Quản lý môn học tiên quyết, môn học song hành
- Quản lý thông tin về học phần lý thuyết, thực hành

#### 2.5. Quản lý lớp học và lịch học
- Thêm, sửa, xóa, tìm kiếm thông tin lớp học
- Quản lý lịch học: thời gian, địa điểm, giảng viên phụ trách
- Quản lý sĩ số lớp và danh sách sinh viên trong lớp
- Quản lý phòng học và cơ sở vật chất

#### 2.6. Quản lý điểm và kết quả học tập
- Nhập, sửa, xóa, tìm kiếm điểm các môn học
- Tính điểm trung bình học kỳ, điểm trung bình tích lũy
- Quản lý học bổng, khen thưởng, kỷ luật
- Quản lý xếp loại học tập và tốt nghiệp

#### 2.7. Quản lý đăng ký học phần
- Quản lý thời gian đăng ký học phần
- Cho phép sinh viên đăng ký, hủy đăng ký môn học
- Kiểm tra điều kiện đăng ký: môn tiên quyết, môn song hành, trùng lịch
- Thống kê số lượng sinh viên đăng ký theo môn học

#### 2.8. Quản lý học phí
- Tính học phí theo số tín chỉ đăng ký
- Quản lý thông tin thanh toán học phí
- Quản lý các khoản miễn giảm học phí
- Thống kê tình hình thu học phí theo học kỳ, năm học

#### 2.9. Báo cáo và thống kê
- Thống kê sinh viên theo khoa, ngành, lớp
- Thống kê điểm trung bình theo lớp, khoa, ngành
- Báo cáo tình hình học tập, tỷ lệ đậu/rớt theo môn học
- Thống kê học bổng và khen thưởng

### 3. Yêu cầu phi chức năng

#### 3.1. Hiệu năng
- Hệ thống phải đáp ứng đủ nhanh cho nhiều người dùng đồng thời
- Thời gian phản hồi truy vấn không quá 3 giây
- Khả năng xử lý đồng thời ít nhất 500 người dùng

#### 3.2. Bảo mật
- Phân quyền người dùng: admin, giảng viên, sinh viên
- Mã hóa mật khẩu và thông tin nhạy cảm
- Ghi nhật ký hoạt động người dùng
- Bảo vệ dữ liệu cá nhân theo quy định pháp luật

#### 3.3. Độ tin cậy
- Sao lưu dữ liệu định kỳ
- Khôi phục dữ liệu trong trường hợp sự cố
- Thời gian hoạt động (uptime) tối thiểu 99.5%

#### 3.4. Khả năng mở rộng
- Thiết kế cho phép mở rộng quy mô người dùng và dữ liệu
- Hỗ trợ thêm các tính năng mới trong tương lai
- Tích hợp được với các hệ thống khác như thư viện, ký túc xá

#### 3.5. Giao diện người dùng
- Giao diện thân thiện, dễ sử dụng
- Tương thích với các thiết bị máy tính và thiết bị di động
- Hỗ trợ tiếng Việt và tiếng Anh

### 4. Phân tích đối tượng

Từ yêu cầu trên, chúng ta có thể xác định các đối tượng chính trong hệ thống:

1. **Sinh viên (Students)**
2. **Giảng viên (Lecturers)**
3. **Khoa (Faculties)**
4. **Ngành học (Majors)**
5. **Môn học (Subjects)**
6. **Lớp học (Classes)** 
7. **Phòng học (Classrooms)**
8. **Lịch học (Schedules)**
9. **Điểm số (Grades)**
10. **Đăng ký học phần (Course Registrations)**
11. **Học phí (Tuition Fees)**
12. **Học kỳ và năm học (Semesters)**
13. **Học bổng và khen thưởng (Scholarships and Awards)**

### 5. Mối quan hệ giữa các đối tượng

1. Một **Khoa** có nhiều **Ngành học** và nhiều **Giảng viên**
2. Một **Ngành học** có nhiều **Sinh viên** và nhiều **Môn học**
3. Một **Môn học** có nhiều **Lớp học**
4. Một **Lớp học** có một **Giảng viên** phụ trách, diễn ra tại một **Phòng học** và theo **Lịch học** cụ thể
5. Một **Sinh viên** có thể **Đăng ký** nhiều **Lớp học**
6. Một **Sinh viên** có nhiều **Điểm số** cho các **Môn học** đã học
7. **Học phí** được tính dựa trên số **Môn học** mà **Sinh viên** đăng ký
8. **Học bổng** được cấp cho **Sinh viên** dựa trên **Điểm số**
9. Mỗi **Lớp học** thuộc một **Học kỳ** cụ thể

Trong phần tiếp theo, chúng ta sẽ thiết kế cơ sở dữ liệu dựa trên phân tích trên.
