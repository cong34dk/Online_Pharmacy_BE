USE [master]
GO
CREATE DATABASE [OnlinePharmacy]
USE [OnlinePharmacy]

GO
---
CREATE TABLE [dbo].[CATEGORY](
	[id] [uniqueidentifier] NOT NULL,
	[slug] [nvarchar](255) NULL,
	[name] [nvarchar](255) NULL,
	[createAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

---
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCT](
	[id] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[detail] [nvarchar](255) NULL,
	[quantity] [int] NULL,
	[price] [decimal](18, 0) NULL,
	[type] [nvarchar](255) NULL,
	[createAt] [datetime] NULL,
	[idUser] [uniqueidentifier] NULL,
	[pathImg] [nvarchar](max) NULL,
	[idCategory] [uniqueidentifier] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

---
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ORDER](
	[id] [uniqueidentifier] NOT NULL,
	[status] [int] NULL,
	[total] [decimal](38, 2) NULL,
	[createAt] [datetime] NOT NULL,
	[idUser] [uniqueidentifier] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

---
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DETAILORDERS](
	[id] [uniqueidentifier] NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [decimal](38, 2) NOT NULL,
	[idOrder] [uniqueidentifier] NULL,
	[idProduct] [uniqueidentifier] NULL,
	[createAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

---
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ROLE](
	[id] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](20) NULL,
	[createAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

---
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USER](
	[id] [uniqueidentifier] NOT NULL,
	[email] [nvarchar](40) NOT NULL,
	[name] [nvarchar](40) NULL,
	[password] [nvarchar](max) NOT NULL,
	[address] [nvarchar](max) NULL,
	[phone] [nvarchar](max) NULL,
	[pathImg] [nvarchar](max) NULL,
	[idRole] [uniqueidentifier] NULL,
	[createAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
INSERT [dbo].[ROLE] ([id], [name], [createAt]) VALUES (N'3eca9f6f-84b8-42da-8a58-bcdb6b64f823', N'Admin', CAST(N'2024-06-24T13:25:12.770' AS DateTime))
INSERT [dbo].[ROLE] ([id], [name], [createAt]) VALUES (N'd6803cd2-3459-4401-890a-d9ec65c46f72', N'Guest', CAST(N'2024-06-24T13:25:12.770' AS DateTime))
GO
INSERT [dbo].[USER] ([id], [email], [name], [password], [address], [phone], [pathImg], [idRole], [createAt]) VALUES (N'32fa5441-9c59-4518-bf11-5d9bb0dab94f', N'admin@gmail.com', N'Admin', N'admin', N'Hoàng Mai - Hà Nội', N'0386594999', N'https://res.cloudinary.com/df6mryfkp/image/upload/v1691680093/banthuoclac/kfpol3rt2xvsf4zuducw.png', N'3eca9f6f-84b8-42da-8a58-bcdb6b64f823', NULL)
INSERT [dbo].[USER] ([id], [email], [name], [password], [address], [phone], [pathImg], [idRole], [createAt]) VALUES (N'7efb44ec-2891-4342-8856-e2801a296099', N'cong@gmail.com', N'Nguyễn Đình Công', N'123456', N'Hoàng Mai - Hà Nội', N'0386786422', NULL, N'd6803cd2-3459-4401-890a-d9ec65c46f72', CAST(N'2024-06-24T13:32:24.520' AS DateTime))
GO
INSERT [dbo].[CATEGORY] ([id], [slug], [name], [createAt]) VALUES (N'4dfe78c2-4efa-4a72-a9cd-6b700390ad01', N'duoc-pham', N'Dược phẩm', CAST(N'2024-06-24T13:30:45.687' AS DateTime))
INSERT [dbo].[CATEGORY] ([id], [slug], [name], [createAt]) VALUES (N'5007207d-ed82-4f50-af26-b42635230538', N'cham-soc-suc-khoe', N'Chăm sóc sức khỏe', CAST(N'2024-06-24T13:30:45.687' AS DateTime))
INSERT [dbo].[CATEGORY] ([id], [slug], [name], [createAt]) VALUES (N'be314ffd-208e-4bdb-915d-b74358abdfe8', N'cham-soc-sac-dep', N'Chăm sóc sắc đẹp', CAST(N'2024-06-24T13:30:45.687' AS DateTime))
INSERT [dbo].[CATEGORY] ([id], [slug], [name], [createAt]) VALUES (N'598ca132-60e0-414a-be8c-ce5f84fa8665', N'thuc-pham-chuc-nang', N'Thực phẩm chức năng', CAST(N'2024-06-24T13:30:45.687' AS DateTime))
GO
INSERT [dbo].[ORDER] ([id], [status], [total], [createAt], [idUser]) VALUES (N'20a2981e-a533-4c29-a56d-10b20cc9aebe', 1, CAST(810000.00 AS Decimal(38, 2)), CAST(N'2024-08-13T11:32:24.317' AS DateTime), N'4218ade4-d4e6-425e-b937-dd7a5f7695fe')
INSERT [dbo].[ORDER] ([id], [status], [total], [createAt], [idUser]) VALUES (N'ade5e9ef-2c48-41c7-9fb7-311f4c43e811', 2, CAST(1770000.00 AS Decimal(38, 2)), CAST(N'2024-06-24T13:34:03.653' AS DateTime), N'7efb44ec-2891-4342-8856-e2801a296099')
INSERT [dbo].[ORDER] ([id], [status], [total], [createAt], [idUser]) VALUES (N'041a9ff9-4dee-4df2-a8c7-35d65795e3f0', 1, CAST(30000.00 AS Decimal(38, 2)), CAST(N'2024-08-13T11:22:53.620' AS DateTime), N'32fa5441-9c59-4518-bf11-5d9bb0dab94f')
INSERT [dbo].[ORDER] ([id], [status], [total], [createAt], [idUser]) VALUES (N'd743c4ee-3ba4-4bb2-a4fb-7fec458a7208', 1, CAST(205000.00 AS Decimal(38, 2)), CAST(N'2024-08-13T11:29:55.843' AS DateTime), N'4218ade4-d4e6-425e-b937-dd7a5f7695fe')
INSERT [dbo].[ORDER] ([id], [status], [total], [createAt], [idUser]) VALUES (N'ab02293b-965b-44a9-a651-bcb53f28712a', 1, CAST(205000.00 AS Decimal(38, 2)), CAST(N'2024-08-10T23:04:21.070' AS DateTime), N'32fa5441-9c59-4518-bf11-5d9bb0dab94f')
INSERT [dbo].[ORDER] ([id], [status], [total], [createAt], [idUser]) VALUES (N'c0e12d75-6196-4415-94c0-cb3b88fee1c5', 1, CAST(1208000.00 AS Decimal(38, 2)), CAST(N'2024-08-10T23:12:30.647' AS DateTime), N'32fa5441-9c59-4518-bf11-5d9bb0dab94f')
INSERT [dbo].[ORDER] ([id], [status], [total], [createAt], [idUser]) VALUES (N'4c23940a-4452-4e1d-8eb6-cdc8e436c0af', 1, CAST(610000.00 AS Decimal(38, 2)), CAST(N'2024-08-10T23:11:49.247' AS DateTime), N'32fa5441-9c59-4518-bf11-5d9bb0dab94f')
INSERT [dbo].[ORDER] ([id], [status], [total], [createAt], [idUser]) VALUES (N'3a484e2e-4867-4504-b71f-d36059124933', 1, CAST(205000.00 AS Decimal(38, 2)), CAST(N'2024-08-10T23:04:43.600' AS DateTime), N'32fa5441-9c59-4518-bf11-5d9bb0dab94f')
GO
INSERT [dbo].[PRODUCT] ([id], [name], [detail], [quantity], [price], [type], [createAt], [idUser], [pathImg], [idCategory]) VALUES (N'a9b094fa-a6ab-439b-be4c-02952c1e512e', N' Nước tẩy trang chiết xuất từ hoa hồng hữu cơ Calliderm Miscellaire 3In1 (Chai 250ml)', N'', 185, CAST(179000 AS Decimal(18, 0)), N'Chai', CAST(N'2024-06-24T13:30:46.547' AS DateTime), NULL, N'https://data-service.pharmacity.io/pmc-upload-media/production/pmc-ecm-core/__sized__/products/P23700_1-thumbnail-255x255-70.jpg', N'be314ffd-208e-4bdb-915d-b74358abdfe8')
INSERT [dbo].[PRODUCT] ([id], [name], [detail], [quantity], [price], [type], [createAt], [idUser], [pathImg], [idCategory]) VALUES (N'335c1ecc-844c-40bd-b1ae-02987530c878', N'Bông y tế thấm nước Bạch Tuyết (100g)', N'Sản phẩm được sản xuất từ 100% bông xơ tự nhiên, không lẫn tạp chất và không pha poly. Công nghệ châu Âu giúp bông mịn, chắc. Công nghệ tiệt trùng E.O.Gas đối với những sản phẩm dùng trong phẫu thuật.', 301, CAST(22000 AS Decimal(18, 0)), N'Gói', CAST(N'2024-06-24T13:30:46.763' AS DateTime), NULL, N'https://data-service.pharmacity.io/pmc-upload-media/production/pmc-ecm-core/__sized__/products/P01255_1-thumbnail-255x255-70.jpg', N'5007207d-ed82-4f50-af26-b42635230538')
INSERT [dbo].[PRODUCT] ([id], [name], [detail], [quantity], [price], [type], [createAt], [idUser], [pathImg], [idCategory]) VALUES (N'c89a7738-3702-4f16-8132-0314eccc54f8', N'Thực phẩm bảo vệ sức khỏe phòng ngừa biến chứng tiểu đường Boni Diabet (60 viên/hộp)', N'', 263, CAST(405000 AS Decimal(18, 0)), N'Hộp', CAST(N'2024-06-24T13:30:48.323' AS DateTime), NULL, N'https://data-service.pharmacity.io/pmc-upload-media/production/pmc-ecm-core/__sized__/products/P24936_1-thumbnail-255x255-70.jpg', N'598ca132-60e0-414a-be8c-ce5f84fa8665')
INSERT [dbo].[PRODUCT] ([id], [name], [detail], [quantity], [price], [type], [createAt], [idUser], [pathImg], [idCategory]) VALUES (N'd4eb3b2e-2e99-4b17-ab4f-033a0024c769', N'Thực phẩm bảo vệ sức khỏe Boni Sleep cải thiện giấc ngủ (Chai 30 viên)', N'', 301, CAST(405000 AS Decimal(18, 0)), N'Chai', CAST(N'2024-06-24T13:30:48.353' AS DateTime), NULL, N'https://data-service.pharmacity.io/pmc-upload-media/production/pmc-ecm-core/__sized__/products/P11592_1_l-thumbnail-255x255.webp', N'598ca132-60e0-414a-be8c-ce5f84fa8665')
INSERT [dbo].[PRODUCT] ([id], [name], [detail], [quantity], [price], [type], [createAt], [idUser], [pathImg], [idCategory]) VALUES (N'4fc8450b-4a73-46c9-878f-0bdfa692c744', N'Salonsip Gel-Patch (2 miếng x 10 gói/hộp)', N'Hoạt tính: Glycol salicylate 1.25g; I-Menthol 1.00g; dl-Camphor 0.30g; Tocopherol acetate 1.00g…Công dụng: Giúp giảm đau, kháng viêm,…Đối tượng sử dụng: Người lớn và trẻ emHình thức: Miếng dánThương hiệu: Hisamitsu (Nhật Bản)', 301, CAST(190000 AS Decimal(18, 0)), N'Hộp', CAST(N'2024-06-24T13:30:47.677' AS DateTime), NULL, N'https://data-service.pharmacity.io/pmc-upload-media/production/pmc-ecm-core/__sized__/products/P00345_1-thumbnail-255x255-70.jpg', N'4dfe78c2-4efa-4a72-a9cd-6b700390ad01')
INSERT [dbo].[PRODUCT] ([id], [name], [detail], [quantity], [price], [type], [createAt], [idUser], [pathImg], [idCategory]) VALUES (N'2835315c-18db-4549-b111-0bf2c738e57f', N'Hỗ trợ não ABIPHA Ginkgo 360 Natto Q10 (Hộp 10 vỉ x 10 viên)', N'', 137, CAST(89000 AS Decimal(18, 0)), N'Hộp', CAST(N'2024-06-24T13:30:47.633' AS DateTime), NULL, N'https://data-service.pharmacity.io/pmc-upload-media/production/pmc-ecm-core/__sized__/products/P25864_1-thumbnail-255x255-70.jpg', N'598ca132-60e0-414a-be8c-ce5f84fa8665')
INSERT [dbo].[PRODUCT] ([id], [name], [detail], [quantity], [price], [type], [createAt], [idUser], [pathImg], [idCategory]) VALUES (N'a7d3568e-43e1-4685-b4f3-0fe8400ffee5', N' Mặt nạ Banobagi Vita Genic Jelly Mask Whitening & Melasma (30ml)', N'', 301, CAST(25000 AS Decimal(18, 0)), N'Miếng', CAST(N'2024-06-24T13:30:46.603' AS DateTime), NULL, N'https://data-service.pharmacity.io/pmc-upload-media/production/pmc-ecm-core/__sized__/products/P23435_1-thumbnail-255x255-70.jpg', N'be314ffd-208e-4bdb-915d-b74358abdfe8')
INSERT [dbo].[PRODUCT] ([id], [name], [detail], [quantity], [price], [type], [createAt], [idUser], [pathImg], [idCategory]) VALUES (N'5bbf34e6-bea8-4b3a-b322-15da04449762', N'Băng cá nhân ít thấm nước Urgo Washproof Large (30 miếng/hộp)', N'Băng cá nhân ít thấm nước Urgo Washproof Large gồm 30 miếng bản lớn, giúp bảo vệ các vết thương nhỏ, vết trầy xước, rách da. Thiết kế nhỏ gọn, tiện lợi khi sử dụng và có thể mang theo mọi nơi.', 301, CAST(52000 AS Decimal(18, 0)), N'Hộp', CAST(N'2024-06-24T13:30:46.763' AS DateTime), NULL, N'https://data-service.pharmacity.io/pmc-upload-media/production/pmc-ecm-core/__sized__/products/P00529_36-thumbnail-255x255.png', N'5007207d-ed82-4f50-af26-b42635230538')
INSERT [dbo].[PRODUCT] ([id], [name], [detail], [quantity], [price], [type], [createAt], [idUser], [pathImg], [idCategory]) VALUES (N'b7e8aea8-af27-466c-ab2e-1813d776ed91', N'Băng dán cá nhân Pharmacity không thấm nước (10 miếng/gói)', N'Băng dán cá nhân Pharmacity không thấm nước giúp bảo vệ vết thương ngoài da. Với khả năng chống thấm nước và có độ dính cao, băng cá nhân Pharmacity giúp bảo vệ các vết trầy xước, vết thương hiệu quả.', 301, CAST(18000 AS Decimal(18, 0)), N'Hộp', CAST(N'2024-06-24T13:30:46.770' AS DateTime), NULL, N'https://data-service.pharmacity.io/pmc-upload-media/production/pmc-ecm-core/__sized__/products/P09771_4-thumbnail-255x255-70.jpg', N'5007207d-ed82-4f50-af26-b42635230538')
INSERT [dbo].[PRODUCT] ([id], [name], [detail], [quantity], [price], [type], [createAt], [idUser], [pathImg], [idCategory]) VALUES (N'249681b0-712b-4908-9227-1aba376f4f51', N'Thực phẩm chức năng làm đẹp da Acnacare (3 vỉ x 10 viên/hộp)', N'Thực phẩm chức năng Acnacare là bổ sung các chất chống Oxy hóa, giúp ngăn ngừa, hỗ trợ điều trị mụn và viêm các tuyến bã nhờn trên da.', 301, CAST(130000 AS Decimal(18, 0)), N'Hộp', CAST(N'2024-06-24T13:30:47.680' AS DateTime), NULL, N'https://data-service.pharmacity.io/pmc-upload-media/production/pmc-ecm-core/__sized__/products/P01045_1_l-thumbnail-255x255.webp', N'598ca132-60e0-414a-be8c-ce5f84fa8665')
INSERT [dbo].[PRODUCT] ([id], [name], [detail], [quantity], [price], [type], [createAt], [idUser], [pathImg], [idCategory]) VALUES (N'32684a77-77d4-41f5-9273-1caecb20b57a', N'Băng cá nhân màu da Pharmacity (100 cái/hộp)', N'Băng cá nhân màu da với thành phần từ vải không dệt, băng keo thông thoáng, độ dính cao, ít thấm nước, giúp bảo vệ các vết thương nhỏ, vết cắt, trầy, xước.', 301, CAST(60000 AS Decimal(18, 0)), N'Hộp', CAST(N'2024-06-24T13:30:46.763' AS DateTime), NULL, N'https://data-service.pharmacity.io/pmc-upload-media/production/pmc-ecm-core/__sized__/products/P10341_1_l-thumbnail-255x255.webp', N'5007207d-ed82-4f50-af26-b42635230538')
INSERT [dbo].[PRODUCT] ([id], [name], [detail], [quantity], [price], [type], [createAt], [idUser], [pathImg], [idCategory]) VALUES (N'45c28603-7d9e-409c-ad94-1ff4ce0b96fd', N'Thực phẩm hỗ trợ giảm thoái hóa khớp An Huy Nakomin Extra (Hộp 60 viên)', N'', 158, CAST(269000 AS Decimal(18, 0)), N'Hộp', CAST(N'2024-06-24T13:30:48.037' AS DateTime), NULL, N'https://data-service.pharmacity.io/pmc-upload-media/production/pmc-ecm-core/__sized__/products/P25534_1-thumbnail-255x255-70.jpg', N'598ca132-60e0-414a-be8c-ce5f84fa8665')
INSERT [dbo].[PRODUCT] ([id], [name], [detail], [quantity], [price], [type], [createAt], [idUser], [pathImg], [idCategory]) VALUES (N'35319f09-e2e4-4047-a485-211ff8e0cdbf', N'Sữa chống nắng Cancer Council Face Day Wear Fluid Matte SPF50+ (Chai 50ml)', N'', 301, CAST(495000 AS Decimal(18, 0)), N'Chai', CAST(N'2024-06-24T13:30:46.607' AS DateTime), NULL, N'https://data-service.pharmacity.io/pmc-upload-media/production/pmc-ecm-core/__sized__/products/P25519_5-thumbnail-255x255-70.jpg', N'be314ffd-208e-4bdb-915d-b74358abdfe8')
INSERT [dbo].[PRODUCT] ([id], [name], [detail], [quantity], [price], [type], [createAt], [idUser], [pathImg], [idCategory]) VALUES (N'b62bb65f-3514-4fea-bbd8-23c9974ba372', N'Tiger Balm Red 19.4g (Hộp 1 lọ)', N'Tiger Balm Redvới hỗn chất từ tự nhiên giúp giảm các chứng đau đầu, ngạt mũi, đau do côn trùng cắn, ngứa, đau nhức cơ, bong gân và đầy hơi.', 301, CAST(40000 AS Decimal(18, 0)), N'Hộp', CAST(N'2024-06-24T13:30:47.680' AS DateTime), NULL, N'https://data-service.pharmacity.io/pmc-upload-media/production/pmc-ecm-core/__sized__/products/P01292_1_l-thumbnail-255x255.webp', N'4dfe78c2-4efa-4a72-a9cd-6b700390ad01')
INSERT [dbo].[PRODUCT] ([id], [name], [detail], [quantity], [price], [type], [createAt], [idUser], [pathImg], [idCategory]) VALUES (N'12341ea4-d72a-4027-9e69-28b9663c7e86', N'Xịt mũi họng Khiết Thanh Á Âu (30ml)', N'', 301, CAST(115000 AS Decimal(18, 0)), N'Chai', CAST(N'2024-06-24T13:30:47.680' AS DateTime), NULL, N'https://data-service.pharmacity.io/pmc-upload-media/production/pmc-ecm-core/__sized__/products/P22919_1-thumbnail-255x255-70.jpg', N'598ca132-60e0-414a-be8c-ce5f84fa8665')
INSERT [dbo].[PRODUCT] ([id], [name], [detail], [quantity], [price], [type], [createAt], [idUser], [pathImg], [idCategory]) VALUES (N'cf306e0b-6f8a-4fb7-87d3-312485053f0b', N'Băng cá nhân trong suốt Urgo Transparent (Hộp 100 miếng)', N'Băng cá nhân Urgo Transparent được làm từ chất liệu vải co giãn tốt, gạc mềm phủ lưới Polyethylene không gây dính hoặc đau khi gỡ băng, giúp bảo vệ hoàn hảo các vết thương nhỏ, vết trầy xước, rách da.', 301, CAST(75000 AS Decimal(18, 0)), N'Hộp', CAST(N'2024-06-24T13:30:46.763' AS DateTime), NULL, N'https://data-service.pharmacity.io/pmc-upload-media/production/pmc-ecm-core/__sized__/products/P00045_36-thumbnail-255x255.png', N'5007207d-ed82-4f50-af26-b42635230538')
INSERT [dbo].[PRODUCT] ([id], [name], [detail], [quantity], [price], [type], [createAt], [idUser], [pathImg], [idCategory]) VALUES (N'db3542e6-0c84-47d1-8ef9-32f132810546', N'Xịt hỗ trợ ngăn ngừa viêm xoang Bảo Tín Xoang (Chai 15ml)', N'', 301, CAST(150000 AS Decimal(18, 0)), N'Chai', CAST(N'2024-06-24T13:30:47.820' AS DateTime), NULL, N'https://data-service.pharmacity.io/pmc-upload-media/production/pmc-ecm-core/__sized__/products/P24163_1-thumbnail-255x255-70.jpg', N'598ca132-60e0-414a-be8c-ce5f84fa8665')
INSERT [dbo].[PRODUCT] ([id], [name], [detail], [quantity], [price], [type], [createAt], [idUser], [pathImg], [idCategory]) VALUES (N'87bed8fa-a900-484b-80be-3781b7b9bfd7', N'Băng cá nhân vải độ dính cao Urgo Durable (102 miếng/hộp)', N'Băng cá nhân vải độ dính cao Urgo Durable giúp bảo vệ các vết thương nhỏ, vết trầy xước, rách da. Độ dính cao, co giãn tốt. Thiết kế nhỏ gọn, tiện lợi khi sử dụng và có thể mang theo mọi nơi.', 301, CAST(75000 AS Decimal(18, 0)), N'Hộp', CAST(N'2024-06-24T13:30:46.767' AS DateTime), NULL, N'https://data-service.pharmacity.io/pmc-upload-media/production/pmc-ecm-core/__sized__/products/P00524_1_l-thumbnail-255x255.webp', N'5007207d-ed82-4f50-af26-b42635230538')
INSERT [dbo].[PRODUCT] ([id], [name], [detail], [quantity], [price], [type], [createAt], [idUser], [pathImg], [idCategory]) VALUES (N'2c645314-4fed-439b-8847-39b657df9770', N'Băng dán cá nhân Pharmacity trong suốt (10 miếng/gói)', N'Băng dán cá nhân Pharmacity trong suốt giúp bảo vệ vết thương ngoài da. Với khả năng chống thấm nước và có độ dính cao, băng cá nhân Pharmacity giúp bảo vệ các vết trầy xước, vết thương hiệu quả.', 301, CAST(10000 AS Decimal(18, 0)), N'Hộp', CAST(N'2024-06-24T13:30:46.773' AS DateTime), NULL, N'https://data-service.pharmacity.io/pmc-upload-media/production/pmc-ecm-core/__sized__/products/P09770_4-thumbnail-255x255-70.jpg', N'5007207d-ed82-4f50-af26-b42635230538')
INSERT [dbo].[PRODUCT] ([id], [name], [detail], [quantity], [price], [type], [createAt], [idUser], [pathImg], [idCategory]) VALUES (N'6d0b17ba-abea-4d11-b1e0-3aa5ab887969', N'Băng cá nhân trong suốt Ace Band-S (10 miếng/hộp)', N'Băng cá nhân trong suốt Ace Band-S có chất kết dính không gây dị ứng, an toàn sử dụng cho da nhạy cảm. Chất liệu mềm mại, ít thấm nước, độ bám dính cao giúp băng dán được lâu hơn.', 301, CAST(11000 AS Decimal(18, 0)), N'Hộp', CAST(N'2024-06-24T13:30:46.763' AS DateTime), NULL, N'https://data-service.pharmacity.io/pmc-upload-media/production/pmc-ecm-core/__sized__/products/P06154_1_l-thumbnail-255x255.webp', N'5007207d-ed82-4f50-af26-b42635230538')
INSERT [dbo].[PRODUCT] ([id], [name], [detail], [quantity], [price], [type], [createAt], [idUser], [pathImg], [idCategory]) VALUES (N'912cc7e3-23c7-4a50-b01d-3c6107c4bb8c', N'Serum giúp làm sáng da Balance Active Formula Niacinamide Blemish Recovery Serum (30ml)', N'Serum Balance Active Formula Niacinamide 15% Blemish Recovery Ngừa Mụn Mờ Thâm 30ml chứa 15% Niacinamide giúp giảm nhược điểm trên làn da, mụn đỏ và cải thiện sắc tố của da.', 301, CAST(190000 AS Decimal(18, 0)), N'Hộp', CAST(N'2024-06-24T13:30:46.560' AS DateTime), NULL, N'https://data-service.pharmacity.io/pmc-upload-media/production/pmc-ecm-core/__sized__/products/P22097_1-thumbnail-255x255-70.jpg', N'be314ffd-208e-4bdb-915d-b74358abdfe8')
INSERT [dbo].[PRODUCT] ([id], [name], [detail], [quantity], [price], [type], [createAt], [idUser], [pathImg], [idCategory]) VALUES (N'9ebe4843-5249-4f47-a151-4033e14372d6', N' Miếng dán giảm đau xương khớp Bách Linh Diệu 10 miếng/hộp', N'', 301, CAST(88000 AS Decimal(18, 0)), N'Hộp', CAST(N'2024-06-24T13:30:46.650' AS DateTime), NULL, N'https://data-service.pharmacity.io/pmc-upload-media/production/pmc-ecm-core/__sized__/products/P22985_1-thumbnail-255x255-70.jpg', N'5007207d-ed82-4f50-af26-b42635230538')
INSERT [dbo].[PRODUCT] ([id], [name], [detail], [quantity], [price], [type], [createAt], [idUser], [pathImg], [idCategory]) VALUES (N'b5c8ba7b-9293-415b-8725-412e3062dba4', N'Thực phẩm hỗ trợ giảm ho An Huy Promax New Siro (Chai 100ml)', N'', 301, CAST(65000 AS Decimal(18, 0)), N'Hộp', CAST(N'2024-06-24T13:30:48.110' AS DateTime), NULL, N'https://data-service.pharmacity.io/pmc-upload-media/production/pmc-ecm-core/__sized__/products/P25475_1-thumbnail-255x255-70.jpg', N'598ca132-60e0-414a-be8c-ce5f84fa8665')
GO
INSERT [dbo].[DETAILORDERS] ([id], [quantity], [price], [idOrder], [idProduct], [createAt]) VALUES (N'84d5a44a-83b0-43d7-8859-0f67814ab116', 1, CAST(662000.00 AS Decimal(38, 2)), N'c0e12d75-6196-4415-94c0-cb3b88fee1c5', N'a9b094fa-a6ab-439b-be4c-02952c1e512e', CAST(N'2024-08-10T23:12:12.897' AS DateTime))
INSERT [dbo].[DETAILORDERS] ([id], [quantity], [price], [idOrder], [idProduct], [createAt]) VALUES (N'cc3b7db6-0ac4-4f6f-a14e-16f9fe404e02', 1, CAST(405000.00 AS Decimal(38, 2)), N'20a2981e-a533-4c29-a56d-10b20cc9aebe', N'a9b094fa-a6ab-439b-be4c-02952c1e512e', CAST(N'2024-08-13T11:32:15.983' AS DateTime))
INSERT [dbo].[DETAILORDERS] ([id], [quantity], [price], [idOrder], [idProduct], [createAt]) VALUES (N'b60b00e9-609d-44a2-bb25-278bf2b7a3cd', 3, CAST(175000.00 AS Decimal(38, 2)), N'ade5e9ef-2c48-41c7-9fb7-311f4c43e811', N'a9b094fa-a6ab-439b-be4c-02952c1e512e', CAST(N'2024-06-24T13:32:46.463' AS DateTime))
INSERT [dbo].[DETAILORDERS] ([id], [quantity], [price], [idOrder], [idProduct], [createAt]) VALUES (N'bcfa4215-0db7-4a51-913e-35b0d54db156', 1, CAST(175000.00 AS Decimal(38, 2)), N'3a484e2e-4867-4504-b71f-d36059124933', N'32684a77-77d4-41f5-9273-1caecb20b57a', CAST(N'2024-08-10T23:04:37.197' AS DateTime))
INSERT [dbo].[DETAILORDERS] ([id], [quantity], [price], [idOrder], [idProduct], [createAt]) VALUES (N'34a29a6f-3d41-47db-8136-38a7a0a332b5', 1, CAST(175000.00 AS Decimal(38, 2)), N'4c23940a-4452-4e1d-8eb6-cdc8e436c0af', N'32684a77-77d4-41f5-9273-1caecb20b57a', CAST(N'2024-08-10T23:11:38.760' AS DateTime))
INSERT [dbo].[DETAILORDERS] ([id], [quantity], [price], [idOrder], [idProduct], [createAt]) VALUES (N'1ae314de-e33d-454d-ad7c-483f4526d024', 1, CAST(175000.00 AS Decimal(38, 2)), N'ab02293b-965b-44a9-a651-bcb53f28712a', N'32684a77-77d4-41f5-9273-1caecb20b57a', CAST(N'2024-08-10T22:55:48.397' AS DateTime))
INSERT [dbo].[DETAILORDERS] ([id], [quantity], [price], [idOrder], [idProduct], [createAt]) VALUES (N'c5670d13-0599-4312-a47b-51eb356681ed', 0, CAST(0.00 AS Decimal(38, 2)), N'ab02293b-965b-44a9-a651-bcb53f28712a', NULL, CAST(N'2024-08-10T22:09:45.707' AS DateTime))
INSERT [dbo].[DETAILORDERS] ([id], [quantity], [price], [idOrder], [idProduct], [createAt]) VALUES (N'2633efc3-47ea-4110-b329-5ce971abbe17', 1, CAST(405000.00 AS Decimal(38, 2)), N'20a2981e-a533-4c29-a56d-10b20cc9aebe', N'9ebe4843-5249-4f47-a151-4033e14372d6', CAST(N'2024-08-13T11:32:18.383' AS DateTime))
INSERT [dbo].[DETAILORDERS] ([id], [quantity], [price], [idOrder], [idProduct], [createAt]) VALUES (N'b99a0e4c-d267-4e26-9ff1-846af629c496', 0, CAST(0.00 AS Decimal(38, 2)), N'041a9ff9-4dee-4df2-a8c7-35d65795e3f0', NULL, CAST(N'2024-08-10T23:17:17.703' AS DateTime))
INSERT [dbo].[DETAILORDERS] ([id], [quantity], [price], [idOrder], [idProduct], [createAt]) VALUES (N'887ad31a-8c30-4c23-a1b3-904701aae776', 1, CAST(120000.00 AS Decimal(38, 2)), N'c0e12d75-6196-4415-94c0-cb3b88fee1c5', N'9ebe4843-5249-4f47-a151-4033e14372d6', CAST(N'2024-08-10T23:12:14.567' AS DateTime))
GO

ALTER TABLE [dbo].[CATEGORY] ADD  DEFAULT (newid()) FOR [id]
GO
ALTER TABLE [dbo].[CATEGORY] ADD  DEFAULT (getdate()) FOR [createAt]
GO
ALTER TABLE [dbo].[DETAILORDERS] ADD  DEFAULT (newid()) FOR [id]
GO
ALTER TABLE [dbo].[DETAILORDERS] ADD  DEFAULT (getdate()) FOR [createAt]
GO
ALTER TABLE [dbo].[ORDER] ADD  DEFAULT (newid()) FOR [id]
GO
ALTER TABLE [dbo].[ORDER] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[ORDER] ADD  DEFAULT ((0)) FOR [total]
GO
ALTER TABLE [dbo].[ORDER] ADD  DEFAULT (getdate()) FOR [createAt]
GO
ALTER TABLE [dbo].[PRODUCT] ADD  DEFAULT (newid()) FOR [id]
GO
ALTER TABLE [dbo].[PRODUCT] ADD  DEFAULT (getdate()) FOR [createAt]
GO
ALTER TABLE [dbo].[ROLE] ADD  DEFAULT (newid()) FOR [id]
GO
ALTER TABLE [dbo].[ROLE] ADD  DEFAULT (getdate()) FOR [createAt]
GO
ALTER TABLE [dbo].[USER] ADD  DEFAULT (newid()) FOR [id]
GO
ALTER TABLE [dbo].[USER] ADD  DEFAULT (getdate()) FOR [createAt]
GO
ALTER TABLE [dbo].[DETAILORDERS]  WITH CHECK ADD FOREIGN KEY([idOrder])
REFERENCES [dbo].[ORDER] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DETAILORDERS]  WITH CHECK ADD FOREIGN KEY([idProduct])
REFERENCES [dbo].[PRODUCT] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PRODUCT]  WITH CHECK ADD FOREIGN KEY([idCategory])
REFERENCES [dbo].[CATEGORY] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PRODUCT]  WITH CHECK ADD FOREIGN KEY([idUser])
REFERENCES [dbo].[USER] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[USER]  WITH CHECK ADD FOREIGN KEY([idRole])
REFERENCES [dbo].[ROLE] ([id])
ON DELETE CASCADE