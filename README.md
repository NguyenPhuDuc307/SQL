# Dự án Quản lý Sinh viên SQL

## Giới thiệu

Đây là một dự án học tập về thiết kế và xây dựng cơ sở dữ liệu quản lý sinh viên sử dụng SQL/MySQL. Dự án bao gồm các tài liệu thiết kế, mã SQL để tạo cơ sở dữ liệu và dữ liệu mẫu, cùng với các tài liệu hướng dẫn về SQL và MySQL.

## Cấu trúc dự án

Dự án bao gồm các tập tin sau:

### Tài liệu thiết kế và yêu cầu

- **student_management_system_requirements.md**: Phân tích yêu cầu chi tiết của hệ thống quản lý sinh viên, mô tả các chức năng và yêu cầu phi chức năng.
- **student_management_system_simplified.md**: Thiết kế cơ sở dữ liệu đơn giản hóa với 5 bảng cơ bản, bao gồm ERD, mô tả bảng và mối quan hệ, các script SQL để tạo cơ sở dữ liệu và các ví dụ truy vấn.

### Mã SQL

- **student_management_system_sample_data.sql**: Script SQL để tạo cơ sở dữ liệu và các bảng theo thiết kế đơn giản hóa, đồng thời chèn dữ liệu mẫu cho mục đích kiểm thử.

### Tài liệu tham khảo SQL

- **mysql_datatypes.md**: Tài liệu chi tiết về các kiểu dữ liệu trong MySQL, cách sử dụng và ví dụ.
- **mysql_join_relationships.md**: Tài liệu đầy đủ về các loại quan hệ trong cơ sở dữ liệu và các loại JOIN trong SQL, kèm ví dụ minh họa chi tiết.
- **mysql_join_relationships_simple.md**: Phiên bản đơn giản hơn của tài liệu về quan hệ và JOIN, tập trung vào các khái niệm cơ bản.
- **mysql_knowledge.md**: Tổng hợp kiến thức cơ bản về SQL và MySQL, bao gồm các lệnh thường dùng và thủ thuật hay.

## Làm thế nào để sử dụng

### Thiết lập cơ sở dữ liệu

1. Cài đặt MySQL Server trên máy tính của bạn.
2. Mở MySQL Command Line Client hoặc bất kỳ công cụ quản lý MySQL nào (như MySQL Workbench, phpMyAdmin, v.v.).
3. Thực thi script `student_management_system_sample_data.sql` để tạo cơ sở dữ liệu và các bảng, đồng thời chèn dữ liệu mẫu.

```bash
mysql -u username -p < student_management_system_sample_data.sql
```

### Học và thực hành SQL

1. Bắt đầu với tài liệu `mysql_knowledge.md` để hiểu về các khái niệm cơ bản của SQL và MySQL.
2. Nghiên cứu `mysql_datatypes.md` để nắm vững các kiểu dữ liệu trong MySQL.
3. Học về các mối quan hệ trong cơ sở dữ liệu và các loại JOIN thông qua `mysql_join_relationships_simple.md` (đối với người mới bắt đầu) hoặc `mysql_join_relationships.md` (đối với người dùng nâng cao).
4. Xem thiết kế cơ sở dữ liệu trong `student_management_system_simplified.md` và thử nghiệm các ví dụ truy vấn được cung cấp.

## Mô hình dữ liệu

Hệ thống Quản lý Sinh viên (phiên bản đơn giản) bao gồm 5 bảng chính:

1. **FACULTIES (Khoa)**: Lưu trữ thông tin về các khoa trong trường.
2. **STUDENTS (Sinh viên)**: Quản lý thông tin về sinh viên và khoa mà họ theo học.
3. **LECTURERS (Giảng viên)**: Quản lý thông tin về giảng viên và khoa mà họ trực thuộc.
4. **SUBJECTS (Môn học)**: Lưu trữ thông tin về các môn học được giảng dạy.
5. **CLASSES (Lớp học)**: Kết nối sinh viên, giảng viên và môn học, đồng thời lưu trữ thông tin về điểm số và tình trạng học tập.

## Đóng góp

Nếu bạn muốn đóng góp cho dự án này, hãy tạo pull request hoặc liên hệ với chúng tôi để được hướng dẫn thêm.

## Giấy phép

Dự án này được phân phối dưới Giấy phép MIT. Xem tệp `LICENSE` để biết thêm chi tiết.

## Liên hệ

Nếu bạn có bất kỳ câu hỏi nào về dự án này, vui lòng liên hệ qua email hoặc tạo một issue trong repository.
