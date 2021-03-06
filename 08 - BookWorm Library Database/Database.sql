USE [master]
GO
/****** Object:  Database [Bookworm]    Script Date: 6/28/2018 6:59:21 PM ******/
CREATE DATABASE [Bookworm]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Bookworm', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Bookworm.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Bookworm_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Bookworm_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Bookworm] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Bookworm].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Bookworm] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Bookworm] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Bookworm] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Bookworm] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Bookworm] SET ARITHABORT OFF 
GO
ALTER DATABASE [Bookworm] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Bookworm] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Bookworm] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Bookworm] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Bookworm] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Bookworm] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Bookworm] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Bookworm] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Bookworm] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Bookworm] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Bookworm] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Bookworm] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Bookworm] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Bookworm] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Bookworm] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Bookworm] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Bookworm] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Bookworm] SET RECOVERY FULL 
GO
ALTER DATABASE [Bookworm] SET  MULTI_USER 
GO
ALTER DATABASE [Bookworm] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Bookworm] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Bookworm] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Bookworm] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Bookworm] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Bookworm', N'ON'
GO
ALTER DATABASE [Bookworm] SET QUERY_STORE = OFF
GO
USE [Bookworm]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [Bookworm]
GO
/****** Object:  Table [dbo].[Books]    Script Date: 6/28/2018 6:59:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Books](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AuthorId] [int] NOT NULL,
	[GenreId] [int] NOT NULL,
	[Title] [nvarchar](250) NOT NULL,
	[ISBN] [nvarchar](50) NULL,
	[PublishedYear] [int] NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[LatePrice] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Books] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Members]    Script Date: 6/28/2018 6:59:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Members](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[CardNumber] [nvarchar](10) NOT NULL,
	[EmailAddress] [nvarchar](250) NULL,
 CONSTRAINT [PK_Members] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Checkouts]    Script Date: 6/28/2018 6:59:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Checkouts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BookId] [int] NOT NULL,
	[MemberId] [int] NOT NULL,
	[EmployeeId] [int] NULL,
	[CheckOutDate] [datetime2](7) NOT NULL,
	[DueDate] [datetime2](7) NOT NULL,
	[CheckInDate] [datetime2](7) NULL,
 CONSTRAINT [PK_Checkouts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[CheckOutData]    Script Date: 6/28/2018 6:59:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[CheckOutData] as

	select 
		b.Id as 'BookId',
		b.Title,
		b.Price,
		b.LatePrice,
		m.Id as 'MemberId',
		m.FirstName,
		m.LastName,
		m.CardNumber,
		c.Id as 'CheckOutId',
		c.CheckOutDate,
		c.CheckInDate,
		c.DueDate
	from Books b
	inner Join Checkouts c on c.BookId = b.Id
	inner join Members m on m.Id = c.MemberId

GO
/****** Object:  Table [dbo].[AuthorGenres]    Script Date: 6/28/2018 6:59:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuthorGenres](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AuthorId] [int] NOT NULL,
	[GenreId] [int] NOT NULL,
 CONSTRAINT [PK_AuthorGenres] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Authors]    Script Date: 6/28/2018 6:59:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Authors](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_Authors] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 6/28/2018 6:59:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[BadgeNumber] [nvarchar](10) NOT NULL,
	[HourlyWage] [money] NOT NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Floors]    Script Date: 6/28/2018 6:59:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Floors](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[color] [nvarchar](50) NULL,
 CONSTRAINT [PK_Floors] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Genres]    Script Date: 6/28/2018 6:59:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genres](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Genres] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Locations]    Script Date: 6/28/2018 6:59:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Locations](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FloorId] [int] NOT NULL,
	[Shelf] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Authors] ON 

INSERT [dbo].[Authors] ([Id], [Name]) VALUES (1, N'Adam Rubin')
INSERT [dbo].[Authors] ([Id], [Name]) VALUES (2, N'Andre Agassi')
INSERT [dbo].[Authors] ([Id], [Name]) VALUES (3, N'Anne Frank')
INSERT [dbo].[Authors] ([Id], [Name]) VALUES (4, N'Douglas Adams')
INSERT [dbo].[Authors] ([Id], [Name]) VALUES (5, N'Ernest Cline')
INSERT [dbo].[Authors] ([Id], [Name]) VALUES (6, N'Ernest Hemingway')
INSERT [dbo].[Authors] ([Id], [Name]) VALUES (7, N'F. Scott Fitzgerald')
INSERT [dbo].[Authors] ([Id], [Name]) VALUES (8, N'George Orwell')
INSERT [dbo].[Authors] ([Id], [Name]) VALUES (9, N'Guillermo del Toro ')
INSERT [dbo].[Authors] ([Id], [Name]) VALUES (10, N'Hermann Hesse')
INSERT [dbo].[Authors] ([Id], [Name]) VALUES (11, N'John Steinbeck')
INSERT [dbo].[Authors] ([Id], [Name]) VALUES (12, N'Malala Yousafzai')
INSERT [dbo].[Authors] ([Id], [Name]) VALUES (13, N'Orson Scott Card')
INSERT [dbo].[Authors] ([Id], [Name]) VALUES (14, N'Paulo Coelho')
INSERT [dbo].[Authors] ([Id], [Name]) VALUES (15, N'Plato')
INSERT [dbo].[Authors] ([Id], [Name]) VALUES (16, N'Tina Fey')
INSERT [dbo].[Authors] ([Id], [Name]) VALUES (17, N'Voltaire')
INSERT [dbo].[Authors] ([Id], [Name]) VALUES (18, N'Albert Camus')
INSERT [dbo].[Authors] ([Id], [Name]) VALUES (19, N'J.D. Salinger')
SET IDENTITY_INSERT [dbo].[Authors] OFF
SET IDENTITY_INSERT [dbo].[Books] ON 

INSERT [dbo].[Books] ([Id], [AuthorId], [GenreId], [Title], [ISBN], [PublishedYear], [Price], [LatePrice]) VALUES (1, 8, 2, N'Animal Farm', N'0452284244', 1945, CAST(7.72 AS Decimal(18, 2)), CAST(1.45 AS Decimal(18, 2)))
INSERT [dbo].[Books] ([Id], [AuthorId], [GenreId], [Title], [ISBN], [PublishedYear], [Price], [LatePrice]) VALUES (2, 6, 2, N'The Old Man and the Sea', N'0684830493', 1952, CAST(3.16 AS Decimal(18, 2)), CAST(1.55 AS Decimal(18, 2)))
INSERT [dbo].[Books] ([Id], [AuthorId], [GenreId], [Title], [ISBN], [PublishedYear], [Price], [LatePrice]) VALUES (3, 7, 2, N'The Great Gatsby', N'0743273567', 1925, CAST(9.92 AS Decimal(18, 2)), CAST(2.54 AS Decimal(18, 2)))
INSERT [dbo].[Books] ([Id], [AuthorId], [GenreId], [Title], [ISBN], [PublishedYear], [Price], [LatePrice]) VALUES (4, 7, 2, N'This Side of Paradise', N'0684843781', 1920, CAST(1.69 AS Decimal(18, 2)), CAST(0.12 AS Decimal(18, 2)))
INSERT [dbo].[Books] ([Id], [AuthorId], [GenreId], [Title], [ISBN], [PublishedYear], [Price], [LatePrice]) VALUES (5, 11, 2, N'The Grapes of Wrath', N'067001690X', 1939, CAST(9.55 AS Decimal(18, 2)), CAST(0.25 AS Decimal(18, 2)))
INSERT [dbo].[Books] ([Id], [AuthorId], [GenreId], [Title], [ISBN], [PublishedYear], [Price], [LatePrice]) VALUES (6, 11, 2, N'Of Mice and Men', N'0142000671', 1937, CAST(7.83 AS Decimal(18, 2)), CAST(3.17 AS Decimal(18, 2)))
INSERT [dbo].[Books] ([Id], [AuthorId], [GenreId], [Title], [ISBN], [PublishedYear], [Price], [LatePrice]) VALUES (7, 16, 1, N'Bossypants', NULL, 2011, CAST(3.44 AS Decimal(18, 2)), CAST(2.29 AS Decimal(18, 2)))
INSERT [dbo].[Books] ([Id], [AuthorId], [GenreId], [Title], [ISBN], [PublishedYear], [Price], [LatePrice]) VALUES (8, 3, 1, N'The Diary of a Young Girl', N'0553296981', NULL, CAST(9.59 AS Decimal(18, 2)), CAST(2.12 AS Decimal(18, 2)))
INSERT [dbo].[Books] ([Id], [AuthorId], [GenreId], [Title], [ISBN], [PublishedYear], [Price], [LatePrice]) VALUES (9, 2, 1, N'Open', N'0307268195', 2009, CAST(8.46 AS Decimal(18, 2)), CAST(1.35 AS Decimal(18, 2)))
INSERT [dbo].[Books] ([Id], [AuthorId], [GenreId], [Title], [ISBN], [PublishedYear], [Price], [LatePrice]) VALUES (10, 12, 1, N'I Am Malala: The Story of the Girl Who Stood Up fo', N'0316322407', 2013, CAST(4.45 AS Decimal(18, 2)), CAST(2.10 AS Decimal(18, 2)))
INSERT [dbo].[Books] ([Id], [AuthorId], [GenreId], [Title], [ISBN], [PublishedYear], [Price], [LatePrice]) VALUES (11, 4, 4, N'The Hitchhiker''s Guide to the Galaxy', N'0345418913', 1979, CAST(6.92 AS Decimal(18, 2)), CAST(2.74 AS Decimal(18, 2)))
INSERT [dbo].[Books] ([Id], [AuthorId], [GenreId], [Title], [ISBN], [PublishedYear], [Price], [LatePrice]) VALUES (12, 8, 4, N'1984', N'0451524934', 1949, CAST(9.78 AS Decimal(18, 2)), CAST(2.11 AS Decimal(18, 2)))
INSERT [dbo].[Books] ([Id], [AuthorId], [GenreId], [Title], [ISBN], [PublishedYear], [Price], [LatePrice]) VALUES (13, 5, 4, N'Ready Player One', N'030788743X', NULL, CAST(5.02 AS Decimal(18, 2)), CAST(3.93 AS Decimal(18, 2)))
INSERT [dbo].[Books] ([Id], [AuthorId], [GenreId], [Title], [ISBN], [PublishedYear], [Price], [LatePrice]) VALUES (14, 13, 4, N'Ender''s Game', N'0812550706', 1985, CAST(5.36 AS Decimal(18, 2)), CAST(0.71 AS Decimal(18, 2)))
INSERT [dbo].[Books] ([Id], [AuthorId], [GenreId], [Title], [ISBN], [PublishedYear], [Price], [LatePrice]) VALUES (15, 9, 4, N'The Shape of Water', N'1250165342', 2018, CAST(8.82 AS Decimal(18, 2)), CAST(1.40 AS Decimal(18, 2)))
INSERT [dbo].[Books] ([Id], [AuthorId], [GenreId], [Title], [ISBN], [PublishedYear], [Price], [LatePrice]) VALUES (16, 17, 3, N'Candide', N'0486266893', 1759, CAST(9.82 AS Decimal(18, 2)), CAST(3.25 AS Decimal(18, 2)))
INSERT [dbo].[Books] ([Id], [AuthorId], [GenreId], [Title], [ISBN], [PublishedYear], [Price], [LatePrice]) VALUES (17, 14, 3, N'The Alchemist', N'0061122416', 1988, CAST(0.08 AS Decimal(18, 2)), CAST(0.46 AS Decimal(18, 2)))
INSERT [dbo].[Books] ([Id], [AuthorId], [GenreId], [Title], [ISBN], [PublishedYear], [Price], [LatePrice]) VALUES (18, 10, 3, N'Siddhartha', N'0553208845', 1922, CAST(3.44 AS Decimal(18, 2)), CAST(1.99 AS Decimal(18, 2)))
INSERT [dbo].[Books] ([Id], [AuthorId], [GenreId], [Title], [ISBN], [PublishedYear], [Price], [LatePrice]) VALUES (19, 15, 3, N'The Republic', N'0140449140', -380, CAST(4.94 AS Decimal(18, 2)), CAST(3.95 AS Decimal(18, 2)))
INSERT [dbo].[Books] ([Id], [AuthorId], [GenreId], [Title], [ISBN], [PublishedYear], [Price], [LatePrice]) VALUES (20, 15, 3, N'The Symposium', N'0140449272', -385, CAST(1.39 AS Decimal(18, 2)), CAST(0.80 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[Books] OFF
SET IDENTITY_INSERT [dbo].[Checkouts] ON 

INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (1, 17, 1, NULL, CAST(N'2017-01-23T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-06T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-23T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (2, 4, 1, NULL, CAST(N'2017-01-16T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-30T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (3, 15, 1, NULL, CAST(N'2017-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-26T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-14T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (4, 8, 1, NULL, CAST(N'2017-01-08T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-22T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-10T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (5, 18, 1, NULL, CAST(N'2017-02-24T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-10T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (6, 16, 1, NULL, CAST(N'2017-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-15T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-05T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (7, 13, 1, NULL, CAST(N'2017-01-24T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-07T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-26T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (8, 7, 1, NULL, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-16T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-06T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (9, 6, 1, NULL, CAST(N'2017-01-23T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-06T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (10, 5, 1, NULL, CAST(N'2017-01-26T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-09T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (11, 14, 1, NULL, CAST(N'2017-01-17T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-31T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-17T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (12, 12, 2, NULL, CAST(N'2017-02-05T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-19T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (13, 6, 2, NULL, CAST(N'2017-01-07T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-21T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-08T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (14, 11, 2, NULL, CAST(N'2017-01-17T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-31T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (15, 9, 2, NULL, CAST(N'2017-01-19T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-12T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (16, 2, 2, NULL, CAST(N'2017-01-07T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-21T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-31T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (17, 8, 2, NULL, CAST(N'2017-01-28T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-11T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-31T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (18, 20, 2, NULL, CAST(N'2017-01-23T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-06T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-26T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (19, 14, 2, NULL, CAST(N'2017-02-21T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-07T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-22T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (20, 17, 2, NULL, CAST(N'2017-01-23T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-06T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-26T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (21, 7, 2, NULL, CAST(N'2017-01-19T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-23T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (22, 18, 2, NULL, CAST(N'2017-01-08T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-22T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-08T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (23, 4, 2, NULL, CAST(N'2017-02-05T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-19T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-09T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (24, 15, 2, NULL, CAST(N'2017-01-03T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-17T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-06T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (25, 3, 2, NULL, CAST(N'2017-01-06T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-20T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-06T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (26, 10, 2, NULL, CAST(N'2017-02-13T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-27T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-15T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (27, 5, 3, NULL, CAST(N'2017-02-18T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-04T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (28, 7, 3, NULL, CAST(N'2017-02-08T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-22T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-12T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (29, 12, 3, NULL, CAST(N'2017-02-16T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-19T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (30, 2, 3, NULL, CAST(N'2017-01-25T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-08T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (31, 3, 3, NULL, CAST(N'2017-02-03T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-17T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-06T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (32, 15, 3, NULL, CAST(N'2017-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-26T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (33, 17, 3, NULL, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-16T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-06T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (34, 20, 3, NULL, CAST(N'2017-01-21T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-04T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-24T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (35, 11, 3, NULL, CAST(N'2017-02-20T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-06T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (36, 16, 3, NULL, CAST(N'2017-02-27T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-13T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-28T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (37, 1, 3, NULL, CAST(N'2017-02-27T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-13T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (38, 9, 3, NULL, CAST(N'2017-01-12T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-26T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-15T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (39, 4, 3, NULL, CAST(N'2017-02-10T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-24T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-13T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (40, 6, 3, NULL, CAST(N'2017-02-03T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-17T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-07T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (41, 14, 3, NULL, CAST(N'2017-01-15T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-29T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-15T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (42, 18, 3, NULL, CAST(N'2017-02-18T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-04T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-19T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (43, 13, 3, NULL, CAST(N'2017-01-22T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-05T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-22T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (44, 20, 4, NULL, CAST(N'2017-02-14T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-28T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-18T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (45, 11, 4, NULL, CAST(N'2017-01-28T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-11T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-30T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (46, 13, 4, NULL, CAST(N'2017-02-21T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-07T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-25T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (47, 18, 4, NULL, CAST(N'2017-01-21T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-04T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-25T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (48, 9, 4, NULL, CAST(N'2017-01-08T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-22T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-12T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (49, 3, 4, NULL, CAST(N'2017-02-24T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-10T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-24T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (50, 1, 4, NULL, CAST(N'2017-01-22T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-05T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-22T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (51, 17, 4, NULL, CAST(N'2017-02-13T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-27T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-16T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (52, 15, 4, NULL, CAST(N'2017-02-20T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-06T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-23T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (53, 16, 4, NULL, CAST(N'2017-02-28T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-14T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-24T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (54, 8, 4, NULL, CAST(N'2017-02-20T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-06T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-16T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (55, 19, 4, NULL, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-16T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-04T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (56, 12, 4, NULL, CAST(N'2017-02-08T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-22T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-08T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (57, 10, 4, NULL, CAST(N'2017-01-26T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-09T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-30T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (58, 5, 4, NULL, CAST(N'2017-01-21T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-04T00:00:00.0000000' AS DateTime2), CAST(N'2017-01-24T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (59, 4, 4, NULL, CAST(N'2017-02-10T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-24T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-14T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (61, 7, 1, NULL, CAST(N'2017-04-11T00:00:00.0000000' AS DateTime2), CAST(N'2017-04-25T00:00:00.0000000' AS DateTime2), CAST(N'2017-04-12T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (62, 3, 1, NULL, CAST(N'2017-04-19T00:00:00.0000000' AS DateTime2), CAST(N'2017-05-03T00:00:00.0000000' AS DateTime2), CAST(N'2017-05-13T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (63, 1, 1, NULL, CAST(N'2017-04-26T00:00:00.0000000' AS DateTime2), CAST(N'2017-05-10T00:00:00.0000000' AS DateTime2), CAST(N'2017-04-30T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (64, 9, 1, NULL, CAST(N'2017-03-23T00:00:00.0000000' AS DateTime2), CAST(N'2017-04-06T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-25T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (65, 16, 1, NULL, CAST(N'2017-04-30T00:00:00.0000000' AS DateTime2), CAST(N'2017-05-14T00:00:00.0000000' AS DateTime2), CAST(N'2017-04-30T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (66, 4, 1, NULL, CAST(N'2017-04-22T00:00:00.0000000' AS DateTime2), CAST(N'2017-05-06T00:00:00.0000000' AS DateTime2), CAST(N'2017-05-16T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (67, 17, 1, NULL, CAST(N'2017-04-22T00:00:00.0000000' AS DateTime2), CAST(N'2017-05-06T00:00:00.0000000' AS DateTime2), CAST(N'2017-04-23T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (68, 15, 1, NULL, CAST(N'2017-03-18T00:00:00.0000000' AS DateTime2), CAST(N'2017-04-01T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-19T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (69, 17, 2, NULL, CAST(N'2017-03-22T00:00:00.0000000' AS DateTime2), CAST(N'2017-04-05T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-26T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (70, 19, 2, NULL, CAST(N'2017-03-28T00:00:00.0000000' AS DateTime2), CAST(N'2017-04-11T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-30T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (71, 16, 2, NULL, CAST(N'2017-04-24T00:00:00.0000000' AS DateTime2), CAST(N'2017-05-08T00:00:00.0000000' AS DateTime2), CAST(N'2017-05-18T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (72, 6, 2, NULL, CAST(N'2017-04-12T00:00:00.0000000' AS DateTime2), CAST(N'2017-04-26T00:00:00.0000000' AS DateTime2), CAST(N'2017-04-15T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (73, 15, 2, NULL, CAST(N'2017-03-14T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-28T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-18T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (74, 3, 2, NULL, CAST(N'2017-04-04T00:00:00.0000000' AS DateTime2), CAST(N'2017-04-18T00:00:00.0000000' AS DateTime2), CAST(N'2017-04-06T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (75, 3, 3, NULL, CAST(N'2017-03-16T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-30T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-16T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (76, 6, 3, NULL, CAST(N'2017-03-18T00:00:00.0000000' AS DateTime2), CAST(N'2017-04-01T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (77, 8, 3, NULL, CAST(N'2017-03-27T00:00:00.0000000' AS DateTime2), CAST(N'2017-04-10T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-28T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (78, 17, 3, NULL, CAST(N'2017-04-16T00:00:00.0000000' AS DateTime2), CAST(N'2017-04-30T00:00:00.0000000' AS DateTime2), CAST(N'2017-04-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (79, 15, 3, NULL, CAST(N'2017-03-18T00:00:00.0000000' AS DateTime2), CAST(N'2017-04-01T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (80, 20, 3, NULL, CAST(N'2017-03-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-16T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-05T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (81, 11, 3, NULL, CAST(N'2017-03-07T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-21T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-08T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (82, 9, 3, NULL, CAST(N'2017-03-13T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-27T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-17T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (83, 4, 3, NULL, CAST(N'2017-03-28T00:00:00.0000000' AS DateTime2), CAST(N'2017-04-11T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-28T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (84, 7, 4, NULL, CAST(N'2017-04-30T00:00:00.0000000' AS DateTime2), CAST(N'2017-05-14T00:00:00.0000000' AS DateTime2), CAST(N'2017-05-04T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (85, 6, 4, NULL, CAST(N'2017-04-07T00:00:00.0000000' AS DateTime2), CAST(N'2017-04-21T00:00:00.0000000' AS DateTime2), CAST(N'2017-04-07T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (86, 15, 4, NULL, CAST(N'2017-04-16T00:00:00.0000000' AS DateTime2), CAST(N'2017-04-30T00:00:00.0000000' AS DateTime2), CAST(N'2017-04-16T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (87, 3, 4, NULL, CAST(N'2017-03-18T00:00:00.0000000' AS DateTime2), CAST(N'2017-04-01T00:00:00.0000000' AS DateTime2), CAST(N'2017-03-19T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (88, 9, 4, NULL, CAST(N'2017-12-14T00:00:00.0000000' AS DateTime2), CAST(N'2017-12-28T00:00:00.0000000' AS DateTime2), CAST(N'2017-12-17T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (89, 4, 4, NULL, CAST(N'2017-11-25T00:00:00.0000000' AS DateTime2), CAST(N'2017-12-09T00:00:00.0000000' AS DateTime2), CAST(N'2017-11-29T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (90, 18, 4, NULL, CAST(N'2017-07-14T00:00:00.0000000' AS DateTime2), CAST(N'2017-07-28T00:00:00.0000000' AS DateTime2), CAST(N'2017-07-15T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (91, 20, 4, NULL, CAST(N'2017-10-05T00:00:00.0000000' AS DateTime2), CAST(N'2017-10-19T00:00:00.0000000' AS DateTime2), CAST(N'2017-10-05T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (92, 13, 4, NULL, CAST(N'2017-10-23T00:00:00.0000000' AS DateTime2), CAST(N'2017-11-06T00:00:00.0000000' AS DateTime2), CAST(N'2017-10-24T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (93, 12, 4, NULL, CAST(N'2017-06-24T00:00:00.0000000' AS DateTime2), CAST(N'2017-07-08T00:00:00.0000000' AS DateTime2), CAST(N'2017-06-26T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (94, 8, 4, NULL, CAST(N'2017-10-22T00:00:00.0000000' AS DateTime2), CAST(N'2017-11-05T00:00:00.0000000' AS DateTime2), CAST(N'2017-10-22T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (95, 15, 4, NULL, CAST(N'2017-09-05T00:00:00.0000000' AS DateTime2), CAST(N'2017-09-19T00:00:00.0000000' AS DateTime2), CAST(N'2017-09-06T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (96, 7, 4, NULL, CAST(N'2017-09-08T00:00:00.0000000' AS DateTime2), CAST(N'2017-09-22T00:00:00.0000000' AS DateTime2), CAST(N'2017-09-11T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (97, 10, 4, NULL, CAST(N'2017-11-01T00:00:00.0000000' AS DateTime2), CAST(N'2017-11-15T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (98, 1, 4, NULL, CAST(N'2017-09-04T00:00:00.0000000' AS DateTime2), CAST(N'2017-09-18T00:00:00.0000000' AS DateTime2), CAST(N'2017-09-07T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (99, 17, 4, NULL, CAST(N'2017-12-30T00:00:00.0000000' AS DateTime2), CAST(N'2018-01-13T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (100, 11, 4, NULL, CAST(N'2017-06-13T00:00:00.0000000' AS DateTime2), CAST(N'2017-06-27T00:00:00.0000000' AS DateTime2), CAST(N'2017-06-15T00:00:00.0000000' AS DateTime2))
GO
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (101, 3, 4, NULL, CAST(N'2017-08-09T00:00:00.0000000' AS DateTime2), CAST(N'2017-08-23T00:00:00.0000000' AS DateTime2), CAST(N'2017-08-09T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (102, 5, 4, NULL, CAST(N'2017-11-10T00:00:00.0000000' AS DateTime2), CAST(N'2017-11-24T00:00:00.0000000' AS DateTime2), CAST(N'2017-11-13T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (103, 6, 4, NULL, CAST(N'2017-12-17T00:00:00.0000000' AS DateTime2), CAST(N'2017-12-31T00:00:00.0000000' AS DateTime2), CAST(N'2017-12-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (104, 19, 4, NULL, CAST(N'2017-06-21T00:00:00.0000000' AS DateTime2), CAST(N'2017-07-05T00:00:00.0000000' AS DateTime2), CAST(N'2017-06-21T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (105, 16, 4, NULL, CAST(N'2017-06-25T00:00:00.0000000' AS DateTime2), CAST(N'2017-07-09T00:00:00.0000000' AS DateTime2), CAST(N'2017-06-26T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (106, 2, 4, NULL, CAST(N'2017-08-13T00:00:00.0000000' AS DateTime2), CAST(N'2017-08-27T00:00:00.0000000' AS DateTime2), CAST(N'2017-08-15T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (107, 14, 4, NULL, CAST(N'2017-08-23T00:00:00.0000000' AS DateTime2), CAST(N'2017-09-06T00:00:00.0000000' AS DateTime2), CAST(N'2017-08-25T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (108, 3, 3, NULL, CAST(N'2017-09-01T00:00:00.0000000' AS DateTime2), CAST(N'2017-09-15T00:00:00.0000000' AS DateTime2), CAST(N'2017-09-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (109, 1, 3, NULL, CAST(N'2017-07-12T00:00:00.0000000' AS DateTime2), CAST(N'2017-07-26T00:00:00.0000000' AS DateTime2), CAST(N'2017-07-12T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (110, 18, 3, NULL, CAST(N'2017-07-05T00:00:00.0000000' AS DateTime2), CAST(N'2017-07-19T00:00:00.0000000' AS DateTime2), CAST(N'2017-07-06T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (111, 7, 3, NULL, CAST(N'2017-08-13T00:00:00.0000000' AS DateTime2), CAST(N'2017-08-27T00:00:00.0000000' AS DateTime2), CAST(N'2017-08-15T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (112, 14, 3, NULL, CAST(N'2017-07-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-07-16T00:00:00.0000000' AS DateTime2), CAST(N'2017-07-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (113, 11, 3, NULL, CAST(N'2017-06-08T00:00:00.0000000' AS DateTime2), CAST(N'2017-06-22T00:00:00.0000000' AS DateTime2), CAST(N'2017-06-12T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (114, 9, 3, NULL, CAST(N'2017-06-01T00:00:00.0000000' AS DateTime2), CAST(N'2017-06-15T00:00:00.0000000' AS DateTime2), CAST(N'2017-06-04T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (115, 16, 3, NULL, CAST(N'2017-08-01T00:00:00.0000000' AS DateTime2), CAST(N'2017-08-15T00:00:00.0000000' AS DateTime2), CAST(N'2017-08-05T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (116, 6, 3, NULL, CAST(N'2017-09-29T00:00:00.0000000' AS DateTime2), CAST(N'2017-10-13T00:00:00.0000000' AS DateTime2), CAST(N'2017-10-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (117, 15, 3, NULL, CAST(N'2017-05-01T00:00:00.0000000' AS DateTime2), CAST(N'2017-05-15T00:00:00.0000000' AS DateTime2), CAST(N'2017-05-25T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (118, 4, 3, NULL, CAST(N'2017-12-29T00:00:00.0000000' AS DateTime2), CAST(N'2018-01-12T00:00:00.0000000' AS DateTime2), CAST(N'2017-12-29T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (119, 13, 3, NULL, CAST(N'2017-06-22T00:00:00.0000000' AS DateTime2), CAST(N'2017-07-06T00:00:00.0000000' AS DateTime2), CAST(N'2017-06-24T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (120, 10, 3, NULL, CAST(N'2017-10-15T00:00:00.0000000' AS DateTime2), CAST(N'2017-10-29T00:00:00.0000000' AS DateTime2), CAST(N'2017-10-18T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (121, 2, 3, NULL, CAST(N'2017-06-27T00:00:00.0000000' AS DateTime2), CAST(N'2017-07-11T00:00:00.0000000' AS DateTime2), CAST(N'2017-06-27T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (122, 19, 3, NULL, CAST(N'2017-11-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-11-16T00:00:00.0000000' AS DateTime2), CAST(N'2017-11-03T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (123, 20, 3, NULL, CAST(N'2017-05-16T00:00:00.0000000' AS DateTime2), CAST(N'2017-05-30T00:00:00.0000000' AS DateTime2), CAST(N'2017-05-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (124, 5, 3, NULL, CAST(N'2017-08-19T00:00:00.0000000' AS DateTime2), CAST(N'2017-09-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-08-19T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (125, 17, 3, NULL, CAST(N'2017-12-30T00:00:00.0000000' AS DateTime2), CAST(N'2018-01-13T00:00:00.0000000' AS DateTime2), CAST(N'2017-12-30T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (126, 13, 4, NULL, CAST(N'2017-07-25T00:00:00.0000000' AS DateTime2), CAST(N'2017-08-08T00:00:00.0000000' AS DateTime2), CAST(N'2017-07-28T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (127, 18, 4, NULL, CAST(N'2017-12-22T00:00:00.0000000' AS DateTime2), CAST(N'2018-01-05T00:00:00.0000000' AS DateTime2), CAST(N'2017-12-26T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (128, 3, 4, NULL, CAST(N'2017-08-12T00:00:00.0000000' AS DateTime2), CAST(N'2017-08-26T00:00:00.0000000' AS DateTime2), CAST(N'2017-08-12T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (129, 16, 4, NULL, CAST(N'2017-09-25T00:00:00.0000000' AS DateTime2), CAST(N'2017-10-09T00:00:00.0000000' AS DateTime2), CAST(N'2017-09-25T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (130, 14, 4, NULL, CAST(N'2017-10-31T00:00:00.0000000' AS DateTime2), CAST(N'2017-11-14T00:00:00.0000000' AS DateTime2), CAST(N'2017-11-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (131, 10, 4, NULL, CAST(N'2017-08-15T00:00:00.0000000' AS DateTime2), CAST(N'2017-08-29T00:00:00.0000000' AS DateTime2), CAST(N'2017-09-08T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (132, 11, 4, NULL, CAST(N'2017-05-03T00:00:00.0000000' AS DateTime2), CAST(N'2017-05-17T00:00:00.0000000' AS DateTime2), CAST(N'2017-05-27T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (133, 2, 4, NULL, CAST(N'2017-08-15T00:00:00.0000000' AS DateTime2), CAST(N'2017-08-29T00:00:00.0000000' AS DateTime2), CAST(N'2017-08-19T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (134, 5, 4, NULL, CAST(N'2017-10-19T00:00:00.0000000' AS DateTime2), CAST(N'2017-11-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-10-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (135, 20, 4, NULL, CAST(N'2017-05-03T00:00:00.0000000' AS DateTime2), CAST(N'2017-05-17T00:00:00.0000000' AS DateTime2), CAST(N'2017-05-04T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (136, 1, 4, NULL, CAST(N'2017-07-18T00:00:00.0000000' AS DateTime2), CAST(N'2017-08-01T00:00:00.0000000' AS DateTime2), CAST(N'2017-08-11T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (137, 17, 4, NULL, CAST(N'2017-05-24T00:00:00.0000000' AS DateTime2), CAST(N'2017-06-07T00:00:00.0000000' AS DateTime2), CAST(N'2017-05-27T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (138, 9, 4, NULL, CAST(N'2017-12-06T00:00:00.0000000' AS DateTime2), CAST(N'2017-12-20T00:00:00.0000000' AS DateTime2), CAST(N'2017-12-07T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (139, 8, 4, NULL, CAST(N'2017-08-07T00:00:00.0000000' AS DateTime2), CAST(N'2017-08-21T00:00:00.0000000' AS DateTime2), CAST(N'2017-08-07T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (140, 15, 4, NULL, CAST(N'2017-10-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-10-16T00:00:00.0000000' AS DateTime2), CAST(N'2017-10-04T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (141, 19, 4, NULL, CAST(N'2017-09-06T00:00:00.0000000' AS DateTime2), CAST(N'2017-09-20T00:00:00.0000000' AS DateTime2), CAST(N'2017-09-07T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (142, 7, 4, NULL, CAST(N'2017-05-07T00:00:00.0000000' AS DateTime2), CAST(N'2017-05-21T00:00:00.0000000' AS DateTime2), CAST(N'2017-05-11T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (143, 12, 2, NULL, CAST(N'2017-10-27T00:00:00.0000000' AS DateTime2), CAST(N'2017-11-10T00:00:00.0000000' AS DateTime2), CAST(N'2017-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (144, 5, 2, NULL, CAST(N'2017-10-20T00:00:00.0000000' AS DateTime2), CAST(N'2017-11-03T00:00:00.0000000' AS DateTime2), CAST(N'2017-10-21T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (145, 13, 2, NULL, CAST(N'2017-11-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-11-16T00:00:00.0000000' AS DateTime2), CAST(N'2017-11-04T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (146, 10, 2, NULL, CAST(N'2017-10-06T00:00:00.0000000' AS DateTime2), CAST(N'2017-10-20T00:00:00.0000000' AS DateTime2), CAST(N'2017-10-06T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (147, 7, 2, NULL, CAST(N'2017-09-23T00:00:00.0000000' AS DateTime2), CAST(N'2017-10-07T00:00:00.0000000' AS DateTime2), CAST(N'2017-09-26T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (148, 8, 2, NULL, CAST(N'2017-11-18T00:00:00.0000000' AS DateTime2), CAST(N'2017-12-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-12-12T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (149, 6, 2, NULL, CAST(N'2017-06-17T00:00:00.0000000' AS DateTime2), CAST(N'2017-07-01T00:00:00.0000000' AS DateTime2), CAST(N'2017-06-18T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (150, 15, 2, NULL, CAST(N'2017-10-28T00:00:00.0000000' AS DateTime2), CAST(N'2017-11-11T00:00:00.0000000' AS DateTime2), CAST(N'2017-11-21T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (151, 17, 2, NULL, CAST(N'2017-11-25T00:00:00.0000000' AS DateTime2), CAST(N'2017-12-09T00:00:00.0000000' AS DateTime2), CAST(N'2017-11-25T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (152, 18, 2, NULL, CAST(N'2017-10-16T00:00:00.0000000' AS DateTime2), CAST(N'2017-10-30T00:00:00.0000000' AS DateTime2), CAST(N'2017-10-19T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (153, 9, 2, NULL, CAST(N'2017-07-11T00:00:00.0000000' AS DateTime2), CAST(N'2017-07-25T00:00:00.0000000' AS DateTime2), CAST(N'2017-07-15T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (154, 20, 2, NULL, CAST(N'2017-12-22T00:00:00.0000000' AS DateTime2), CAST(N'2018-01-05T00:00:00.0000000' AS DateTime2), CAST(N'2017-12-24T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (155, 3, 2, NULL, CAST(N'2017-06-15T00:00:00.0000000' AS DateTime2), CAST(N'2017-06-29T00:00:00.0000000' AS DateTime2), CAST(N'2017-06-16T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (156, 1, 1, NULL, CAST(N'2017-12-14T00:00:00.0000000' AS DateTime2), CAST(N'2017-12-28T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (157, 5, 1, NULL, CAST(N'2017-07-01T00:00:00.0000000' AS DateTime2), CAST(N'2017-07-15T00:00:00.0000000' AS DateTime2), CAST(N'2017-07-04T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (158, 17, 1, NULL, CAST(N'2017-10-11T00:00:00.0000000' AS DateTime2), CAST(N'2017-10-25T00:00:00.0000000' AS DateTime2), CAST(N'2017-10-11T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (159, 9, 1, NULL, CAST(N'2017-08-16T00:00:00.0000000' AS DateTime2), CAST(N'2017-08-30T00:00:00.0000000' AS DateTime2), CAST(N'2017-08-19T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (160, 12, 1, NULL, CAST(N'2017-05-30T00:00:00.0000000' AS DateTime2), CAST(N'2017-06-13T00:00:00.0000000' AS DateTime2), CAST(N'2017-06-23T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (161, 18, 1, NULL, CAST(N'2017-12-28T00:00:00.0000000' AS DateTime2), CAST(N'2018-01-11T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (162, 8, 1, NULL, CAST(N'2017-05-20T00:00:00.0000000' AS DateTime2), CAST(N'2017-06-03T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (163, 4, 1, NULL, CAST(N'2017-11-03T00:00:00.0000000' AS DateTime2), CAST(N'2017-11-17T00:00:00.0000000' AS DateTime2), CAST(N'2017-11-04T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (164, 13, 1, NULL, CAST(N'2017-06-22T00:00:00.0000000' AS DateTime2), CAST(N'2017-07-06T00:00:00.0000000' AS DateTime2), CAST(N'2017-06-22T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (165, 20, 1, NULL, CAST(N'2017-09-30T00:00:00.0000000' AS DateTime2), CAST(N'2017-10-14T00:00:00.0000000' AS DateTime2), CAST(N'2017-10-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Checkouts] ([Id], [BookId], [MemberId], [EmployeeId], [CheckOutDate], [DueDate], [CheckInDate]) VALUES (166, 14, 1, NULL, CAST(N'2017-11-20T00:00:00.0000000' AS DateTime2), CAST(N'2017-12-04T00:00:00.0000000' AS DateTime2), CAST(N'2017-11-22T00:00:00.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Checkouts] OFF
SET IDENTITY_INSERT [dbo].[Genres] ON 

INSERT [dbo].[Genres] ([Id], [Name]) VALUES (1, N'Biography')
INSERT [dbo].[Genres] ([Id], [Name]) VALUES (2, N'Classics')
INSERT [dbo].[Genres] ([Id], [Name]) VALUES (3, N'Philosophy')
INSERT [dbo].[Genres] ([Id], [Name]) VALUES (4, N'Science Fiction')
INSERT [dbo].[Genres] ([Id], [Name]) VALUES (5, N'Poetry')
INSERT [dbo].[Genres] ([Id], [Name]) VALUES (6, N'Cookbooks')
INSERT [dbo].[Genres] ([Id], [Name]) VALUES (7, N'Young Adult')
INSERT [dbo].[Genres] ([Id], [Name]) VALUES (8, N'Engineering')
SET IDENTITY_INSERT [dbo].[Genres] OFF
SET IDENTITY_INSERT [dbo].[Members] ON 

INSERT [dbo].[Members] ([Id], [FirstName], [LastName], [CardNumber], [EmailAddress]) VALUES (1, N'Phillip', N'Scholtes', N'1000001', N'phil.scholtes@gmail.com')
INSERT [dbo].[Members] ([Id], [FirstName], [LastName], [CardNumber], [EmailAddress]) VALUES (2, N'Paul', N'Hohnbaum', N'1000002', NULL)
INSERT [dbo].[Members] ([Id], [FirstName], [LastName], [CardNumber], [EmailAddress]) VALUES (3, N'Gauri', N'Bansal', N'1000003', N'reach2gauri@gmail.com')
INSERT [dbo].[Members] ([Id], [FirstName], [LastName], [CardNumber], [EmailAddress]) VALUES (4, N'Chris', N'McDonald', N'1000004', NULL)
SET IDENTITY_INSERT [dbo].[Members] OFF
/****** Object:  Index [UX_AuthorGenres]    Script Date: 6/28/2018 6:59:25 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_AuthorGenres] ON [dbo].[AuthorGenres]
(
	[AuthorId] ASC,
	[GenreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AuthorGenres]  WITH CHECK ADD  CONSTRAINT [FK_AuthorGenres_Authors] FOREIGN KEY([AuthorId])
REFERENCES [dbo].[Authors] ([Id])
GO
ALTER TABLE [dbo].[AuthorGenres] CHECK CONSTRAINT [FK_AuthorGenres_Authors]
GO
ALTER TABLE [dbo].[AuthorGenres]  WITH CHECK ADD  CONSTRAINT [FK_AuthorGenres_Genres] FOREIGN KEY([GenreId])
REFERENCES [dbo].[Genres] ([Id])
GO
ALTER TABLE [dbo].[AuthorGenres] CHECK CONSTRAINT [FK_AuthorGenres_Genres]
GO
ALTER TABLE [dbo].[Books]  WITH CHECK ADD  CONSTRAINT [FK_Books_Authors] FOREIGN KEY([AuthorId])
REFERENCES [dbo].[Authors] ([Id])
GO
ALTER TABLE [dbo].[Books] CHECK CONSTRAINT [FK_Books_Authors]
GO
ALTER TABLE [dbo].[Books]  WITH CHECK ADD  CONSTRAINT [FK_Books_Genres] FOREIGN KEY([GenreId])
REFERENCES [dbo].[Genres] ([Id])
GO
ALTER TABLE [dbo].[Books] CHECK CONSTRAINT [FK_Books_Genres]
GO
ALTER TABLE [dbo].[Checkouts]  WITH CHECK ADD  CONSTRAINT [FK_Checkouts_Books] FOREIGN KEY([BookId])
REFERENCES [dbo].[Books] ([Id])
GO
ALTER TABLE [dbo].[Checkouts] CHECK CONSTRAINT [FK_Checkouts_Books]
GO
ALTER TABLE [dbo].[Checkouts]  WITH CHECK ADD  CONSTRAINT [FK_Checkouts_Employees] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([Id])
GO
ALTER TABLE [dbo].[Checkouts] CHECK CONSTRAINT [FK_Checkouts_Employees]
GO
ALTER TABLE [dbo].[Checkouts]  WITH CHECK ADD  CONSTRAINT [FK_Checkouts_Members] FOREIGN KEY([MemberId])
REFERENCES [dbo].[Members] ([Id])
GO
ALTER TABLE [dbo].[Checkouts] CHECK CONSTRAINT [FK_Checkouts_Members]
GO
ALTER TABLE [dbo].[Locations]  WITH CHECK ADD  CONSTRAINT [FK_Location_Floors] FOREIGN KEY([FloorId])
REFERENCES [dbo].[Floors] ([Id])
GO
ALTER TABLE [dbo].[Locations] CHECK CONSTRAINT [FK_Location_Floors]
GO
/****** Object:  StoredProcedure [dbo].[CreateGenre]    Script Date: 6/28/2018 6:59:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[CreateGenre] 
	@GenreName nvarchar(50)
as
begin
	set nocount on;

	if not exists (select Id from Genres where Name = @GenreName)
		begin
			insert into Genres values (@GenreName)		
		end
	end
GO
/****** Object:  StoredProcedure [dbo].[GetBookById]    Script Date: 6/28/2018 6:59:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetBookById] 
	@bookId int
as
begin

	set nocount on;

	select *
	from Books
	where Id = @bookId


end
GO
/****** Object:  StoredProcedure [dbo].[GetFirstBookCheckoutByMember]    Script Date: 6/28/2018 6:59:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetFirstBookCheckoutByMember]
	@MemberId int
as
begin

select top 1 m.FirstName, b.Title, cast(min(c.CheckOutDate) as date) as 'OldestCheckouts', Count(*) as 'NumberOfTimesCheckedOut'
from Checkouts c
join Books b on b.Id = c.BookId
join Members m on m.Id = c.MemberId
where m.Id = @MemberId
group by m.FirstName, b.Title
order by OldestCheckouts

end
GO
/****** Object:  StoredProcedure [dbo].[GetPopularAuthorByMember]    Script Date: 6/28/2018 6:59:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetPopularAuthorByMember] 
	@MemberId int
as
begin
	set nocount on;

	select top 1 m.FirstName, a.[Name] as 'FavouriteAuthor', count(*) as 'FavouriteAuthorBookCount'
	from books b
	join Authors a on a.Id = b.AuthorId
	join Checkouts c on c.BookId = b.Id
	join Members m on m.Id = c.MemberId
	where m.Id = @MemberId
	group by m.FirstName, a.[Name]
	order by FavouriteAuthorBookCount desc
end
GO
/****** Object:  StoredProcedure [dbo].[GetPopularGenreByMember]    Script Date: 6/28/2018 6:59:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetPopularGenreByMember] 
	@MemberId int
as
begin
	set nocount on;

	select top 1 m.FirstName, g.[Name] as 'FavouriteGenre', count(*) as 'FavouriteGenresBookCount'
	from books b
	join Genres g on g.Id = b.GenreId
	join Checkouts c on c.BookId = b.Id
	join Members m on m.Id = c.MemberId
	where m.Id = @MemberId
	group by m.FirstName, g.[Name]
	order by FavouriteGenresBookCount desc
end
GO
/****** Object:  StoredProcedure [dbo].[GetRecentBookCheckoutByMember]    Script Date: 6/28/2018 6:59:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetRecentBookCheckoutByMember] 
	@MemberId int
as
begin
	set nocount on;

	select top 1 b.Title, max(c.CheckOutDate) as 'RecentCheckedOutDate'
	from Checkouts c
	join Books b on b.Id = c.BookId
	join Members m on m.Id = c.MemberId
	where m.Id = @MemberId
	group by b.Title
	order by RecentCheckedOutDate desc
	
end
GO
USE [master]
GO
ALTER DATABASE [Bookworm] SET  READ_WRITE 
GO
