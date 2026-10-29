CREATE DATABASE QuanLyDuAn;
GO
USE QuanLyDuAn;
GO

-- 1/ TẠO CẤU TRÚC
CREATE TABLE NHANVIEN (
    MaNV     CHAR(10)      NOT NULL,
    HoTen    NVARCHAR(50)  NOT NULL,
    NgaySinh DATE,
    GT       NVARCHAR(5),
    CONSTRAINT PK_NHANVIEN PRIMARY KEY (MaNV),
    CONSTRAINT CK_NHANVIEN_GT CHECK (GT IN (N'Nam', N'Nữ'))
);

CREATE TABLE DUAN (
    MaDA      CHAR(10)      NOT NULL,
    TenDA     NVARCHAR(100) NOT NULL,
    NganSach  MONEY,
    CONSTRAINT PK_DUAN PRIMARY KEY (MaDA)
);

CREATE TABLE THAMGIA (
    MaDA  CHAR(10) NOT NULL,
    MaNV  CHAR(10) NOT NULL,
    TGBD  DATE,
    TGKT  DATE,
    CONSTRAINT PK_THAMGIA PRIMARY KEY (MaDA, MaNV),
    CONSTRAINT FK_THAMGIA_DUAN     FOREIGN KEY (MaDA) REFERENCES DUAN(MaDA),
    CONSTRAINT FK_THAMGIA_NHANVIEN FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV),
    CONSTRAINT CK_THAMGIA_TG CHECK (TGKT IS NULL OR TGKT >= TGBD)
);
GO

-- Nhập 5 bộ dữ liệu cho mỗi bảng
INSERT INTO NHANVIEN (MaNV, HoTen, NgaySinh, GT) VALUES
('NV01', N'Nguyễn Văn An',   '1995-03-12', N'Nam'),
('NV02', N'Trần Thị Thanh',  '1997-07-25', N'Nữ'),
('NV03', N'Lê Hoàng Nam',    '1994-11-02', N'Nam'),
('NV04', N'Phạm Minh Thanh', '1998-01-18', N'Nam'),
('NV05', N'Đỗ Thùy Linh',    '1999-09-30', N'Nữ');

INSERT INTO DUAN (MaDA, TenDA, NganSach) VALUES
('DA01', N'Website bán hàng',        150000000),
('DA02', N'Ứng dụng quản lý kho',    200000000),
('DA03', N'Hệ thống điểm danh',       80000000),
('DA04', N'Giám sát an toàn thông tin', 300000000),
('DA05', N'Ứng dụng di động học tập', 120000000);

INSERT INTO THAMGIA (MaDA, MaNV, TGBD, TGKT) VALUES
('DA01', 'NV01', '2026-09-01', '2026-12-31'),
('DA02', 'NV02', '2026-10-02', '2027-03-31'),
('DA03', 'NV03', '2026-10-02', '2027-01-15'),
('DA04', 'NV04', '2026-08-15', '2027-02-28'),
('DA05', 'NV05', '2026-11-01', '2027-04-30');
GO

-- 2/ Danh sách nhân viên có tên là Thanh
-- (tên là từ cuối của HoTen)
SELECT * FROM NHANVIEN
WHERE HoTen LIKE N'% Thanh';

-- 3/ Các dự án có thời gian bắt đầu vào ngày 02/10/2026
SELECT DISTINCT d.*
FROM DUAN d
JOIN THAMGIA t ON t.MaDA = d.MaDA
WHERE t.TGBD = '2026-10-02';
GO
