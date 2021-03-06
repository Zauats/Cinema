USE [master]
GO
/****** Object:  Database [VirtualCinema]    Script Date: 29.06.2020 20:25:53 ******/
CREATE DATABASE [VirtualCinema]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'VirtualCinema', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\VirtualCinema.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'VirtualCinema_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\VirtualCinema_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [VirtualCinema] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [VirtualCinema].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [VirtualCinema] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [VirtualCinema] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [VirtualCinema] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [VirtualCinema] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [VirtualCinema] SET ARITHABORT OFF 
GO
ALTER DATABASE [VirtualCinema] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [VirtualCinema] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [VirtualCinema] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [VirtualCinema] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [VirtualCinema] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [VirtualCinema] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [VirtualCinema] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [VirtualCinema] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [VirtualCinema] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [VirtualCinema] SET  DISABLE_BROKER 
GO
ALTER DATABASE [VirtualCinema] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [VirtualCinema] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [VirtualCinema] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [VirtualCinema] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [VirtualCinema] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [VirtualCinema] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [VirtualCinema] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [VirtualCinema] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [VirtualCinema] SET  MULTI_USER 
GO
ALTER DATABASE [VirtualCinema] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [VirtualCinema] SET DB_CHAINING OFF 
GO
ALTER DATABASE [VirtualCinema] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [VirtualCinema] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [VirtualCinema] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [VirtualCinema] SET QUERY_STORE = OFF
GO
USE [VirtualCinema]
GO
/****** Object:  Table [dbo].[Cinemas]    Script Date: 29.06.2020 20:25:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cinemas](
	[id] [int] NOT NULL,
	[adress] [nvarchar](150) NOT NULL,
	[stars_quantity] [int] NOT NULL,
	[nearest_metro] [nvarchar](50) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Cinemas] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Films]    Script Date: 29.06.2020 20:25:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Films](
	[id] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[duration] [float] NOT NULL,
	[age_limit] [int] NULL,
	[rating] [int] NULL,
 CONSTRAINT [PK_Films] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Halls]    Script Date: 29.06.2020 20:25:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Halls](
	[id] [int] NOT NULL,
	[row_quantity] [int] NOT NULL,
	[column_quantity] [int] NOT NULL,
	[cinema_id] [int] NOT NULL,
	[name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Halls] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Places]    Script Date: 29.06.2020 20:25:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Places](
	[id] [int] NOT NULL,
	[row_number] [int] NOT NULL,
	[column_number] [int] NOT NULL,
	[hall_id] [int] NOT NULL,
 CONSTRAINT [PK_Place] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Session_types]    Script Date: 29.06.2020 20:25:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Session_types](
	[id] [int] NOT NULL,
	[session_type] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Session_types] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sessions]    Script Date: 29.06.2020 20:25:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sessions](
	[id] [int] NOT NULL,
	[hall_id] [int] NOT NULL,
	[data] [date] NOT NULL,
	[film_id] [int] NOT NULL,
	[session_type] [int] NOT NULL,
	[minutes] [int] NULL,
	[hour] [int] NULL,
 CONSTRAINT [PK_Sessions] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tickets]    Script Date: 29.06.2020 20:25:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tickets](
	[id] [int] NOT NULL,
	[session_id] [int] NOT NULL,
	[place_id] [int] NOT NULL,
	[state] [bit] NOT NULL,
	[price] [float] NOT NULL,
	[user_id] [int] NULL,
 CONSTRAINT [PK_Tickets] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 29.06.2020 20:25:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[id] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[surname] [nvarchar](50) NOT NULL,
	[email] [nvarchar](50) NOT NULL,
	[sex] [nvarchar](30) NOT NULL,
	[login] [nvarchar](50) NOT NULL,
	[password] [nvarchar](50) NOT NULL,
	[is admin] [bit] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Cinemas] ([id], [adress], [stars_quantity], [nearest_metro], [name]) VALUES (0, N'Зелоново, 15', 5, N'Зеленово', N'Киношка')
INSERT [dbo].[Cinemas] ([id], [adress], [stars_quantity], [nearest_metro], [name]) VALUES (1, N'Зелоново, 15', 5, N'Зеленово', N'Кинотеатр театр')
INSERT [dbo].[Cinemas] ([id], [adress], [stars_quantity], [nearest_metro], [name]) VALUES (2, N'Красноречиво, 14', 6, N'Армения', N'Киношка у Гагика')
INSERT [dbo].[Cinemas] ([id], [adress], [stars_quantity], [nearest_metro], [name]) VALUES (3, N'Дом Ледяной королевы', 10, N'Нарния', N'Антифантазия')
INSERT [dbo].[Films] ([id], [name], [duration], [age_limit], [rating]) VALUES (0, N'Властелин колец', 123, 16, 10)
INSERT [dbo].[Films] ([id], [name], [duration], [age_limit], [rating]) VALUES (1, N'Я - легенда', 115, 16, 9)
INSERT [dbo].[Films] ([id], [name], [duration], [age_limit], [rating]) VALUES (2, N'Троя', 180, 16, 7)
INSERT [dbo].[Films] ([id], [name], [duration], [age_limit], [rating]) VALUES (3, N'История одного Саши', 15, 18, 3)
INSERT [dbo].[Films] ([id], [name], [duration], [age_limit], [rating]) VALUES (4, N'Мой брат монстр', 300, 6, 2)
INSERT [dbo].[Films] ([id], [name], [duration], [age_limit], [rating]) VALUES (5, N'Федя докопался', 180, 16, 7)
INSERT [dbo].[Halls] ([id], [row_quantity], [column_quantity], [cinema_id], [name]) VALUES (0, 3, 3, 2, N'Зал 1')
INSERT [dbo].[Halls] ([id], [row_quantity], [column_quantity], [cinema_id], [name]) VALUES (1, 3, 3, 2, N'Зал 2')
INSERT [dbo].[Halls] ([id], [row_quantity], [column_quantity], [cinema_id], [name]) VALUES (2, 4, 4, 3, N'Зал 1')
INSERT [dbo].[Halls] ([id], [row_quantity], [column_quantity], [cinema_id], [name]) VALUES (3, 3, 4, 3, N'Зал 2')
INSERT [dbo].[Halls] ([id], [row_quantity], [column_quantity], [cinema_id], [name]) VALUES (4, 3, 3, 0, N'Зал 1')
INSERT [dbo].[Halls] ([id], [row_quantity], [column_quantity], [cinema_id], [name]) VALUES (5, 3, 6, 0, N'Зал 2')
INSERT [dbo].[Halls] ([id], [row_quantity], [column_quantity], [cinema_id], [name]) VALUES (6, 100, 100, 0, N'зал')
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (0, 0, 0, 0)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (1, 0, 1, 0)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (2, 0, 2, 0)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (3, 1, 0, 0)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (4, 1, 1, 0)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (5, 1, 2, 0)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (6, 2, 0, 0)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (7, 2, 1, 0)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (8, 2, 2, 0)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (9, 0, 1, 1)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (10, 1, 0, 1)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (11, 1, 1, 1)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (12, 1, 2, 1)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (13, 2, 1, 1)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (14, 0, 1, 2)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (15, 0, 2, 2)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (16, 1, 0, 2)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (17, 1, 1, 2)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (18, 1, 2, 2)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (19, 1, 3, 2)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (20, 2, 1, 2)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (21, 2, 2, 2)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (22, 3, 0, 2)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (23, 3, 1, 2)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (24, 3, 2, 2)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (25, 3, 3, 2)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (26, 0, 2, 3)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (27, 1, 0, 3)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (28, 1, 1, 3)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (29, 1, 2, 3)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (30, 1, 3, 3)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (31, 2, 2, 3)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (32, 0, 0, 4)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (33, 0, 1, 4)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (34, 0, 2, 4)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (35, 1, 0, 4)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (36, 1, 1, 4)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (37, 1, 2, 4)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (38, 2, 0, 4)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (39, 2, 1, 4)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (40, 2, 2, 4)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (41, 0, 2, 5)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (42, 0, 3, 5)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (43, 1, 0, 5)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (44, 1, 1, 5)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (45, 1, 2, 5)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (46, 1, 3, 5)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (47, 1, 4, 5)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (48, 1, 5, 5)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (49, 2, 2, 5)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (50, 2, 3, 5)
INSERT [dbo].[Places] ([id], [row_number], [column_number], [hall_id]) VALUES (51, 2, 4, 5)
INSERT [dbo].[Session_types] ([id], [session_type]) VALUES (0, N'3D')
INSERT [dbo].[Session_types] ([id], [session_type]) VALUES (1, N'2D')
INSERT [dbo].[Session_types] ([id], [session_type]) VALUES (2, N'Дома')
INSERT [dbo].[Session_types] ([id], [session_type]) VALUES (3, N'3D IMAX')
INSERT [dbo].[Session_types] ([id], [session_type]) VALUES (4, N'144p')
INSERT [dbo].[Sessions] ([id], [hall_id], [data], [film_id], [session_type], [minutes], [hour]) VALUES (0, 2, CAST(N'2020-05-11' AS Date), 3, 4, 0, 16)
INSERT [dbo].[Sessions] ([id], [hall_id], [data], [film_id], [session_type], [minutes], [hour]) VALUES (1, 1, CAST(N'2020-05-10' AS Date), 0, 0, 15, 9)
INSERT [dbo].[Sessions] ([id], [hall_id], [data], [film_id], [session_type], [minutes], [hour]) VALUES (2, 2, CAST(N'2020-05-11' AS Date), 3, 4, 15, 16)
INSERT [dbo].[Sessions] ([id], [hall_id], [data], [film_id], [session_type], [minutes], [hour]) VALUES (3, 2, CAST(N'2020-05-11' AS Date), 3, 2, 15, 16)
INSERT [dbo].[Sessions] ([id], [hall_id], [data], [film_id], [session_type], [minutes], [hour]) VALUES (4, 2, CAST(N'2020-05-11' AS Date), 3, 2, 30, 16)
INSERT [dbo].[Sessions] ([id], [hall_id], [data], [film_id], [session_type], [minutes], [hour]) VALUES (5, 2, CAST(N'2020-05-11' AS Date), 3, 2, 30, 17)
INSERT [dbo].[Sessions] ([id], [hall_id], [data], [film_id], [session_type], [minutes], [hour]) VALUES (6, 3, CAST(N'2020-05-11' AS Date), 3, 2, 30, 17)
INSERT [dbo].[Sessions] ([id], [hall_id], [data], [film_id], [session_type], [minutes], [hour]) VALUES (7, 3, CAST(N'2020-05-11' AS Date), 3, 2, 30, 18)
INSERT [dbo].[Sessions] ([id], [hall_id], [data], [film_id], [session_type], [minutes], [hour]) VALUES (8, 3, CAST(N'2020-05-12' AS Date), 3, 3, 30, 18)
INSERT [dbo].[Sessions] ([id], [hall_id], [data], [film_id], [session_type], [minutes], [hour]) VALUES (9, 3, CAST(N'2020-05-12' AS Date), 4, 3, 30, 19)
INSERT [dbo].[Sessions] ([id], [hall_id], [data], [film_id], [session_type], [minutes], [hour]) VALUES (10, 3, CAST(N'2020-05-12' AS Date), 4, 3, 30, 23)
INSERT [dbo].[Sessions] ([id], [hall_id], [data], [film_id], [session_type], [minutes], [hour]) VALUES (11, 0, CAST(N'2020-05-15' AS Date), 0, 2, 56, 13)
INSERT [dbo].[Sessions] ([id], [hall_id], [data], [film_id], [session_type], [minutes], [hour]) VALUES (12, 4, CAST(N'2020-05-17' AS Date), 0, 2, 15, 1)
INSERT [dbo].[Sessions] ([id], [hall_id], [data], [film_id], [session_type], [minutes], [hour]) VALUES (13, 4, CAST(N'2020-05-19' AS Date), 0, 1, 56, 20)
INSERT [dbo].[Sessions] ([id], [hall_id], [data], [film_id], [session_type], [minutes], [hour]) VALUES (14, 4, CAST(N'2020-05-19' AS Date), 1, 1, 56, 20)
INSERT [dbo].[Sessions] ([id], [hall_id], [data], [film_id], [session_type], [minutes], [hour]) VALUES (15, 4, CAST(N'2020-05-19' AS Date), 2, 1, 56, 20)
INSERT [dbo].[Sessions] ([id], [hall_id], [data], [film_id], [session_type], [minutes], [hour]) VALUES (16, 4, CAST(N'2020-05-19' AS Date), 3, 1, 56, 20)
INSERT [dbo].[Sessions] ([id], [hall_id], [data], [film_id], [session_type], [minutes], [hour]) VALUES (17, 4, CAST(N'2020-05-19' AS Date), 4, 1, 56, 20)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (0, 0, 14, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (1, 0, 15, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (2, 0, 16, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (3, 0, 17, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (4, 0, 18, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (5, 1, 9, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (6, 1, 10, 1, 300, 4)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (7, 1, 11, 1, 300, 4)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (8, 1, 12, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (9, 1, 13, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (10, 0, 19, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (11, 0, 20, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (12, 0, 21, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (13, 0, 22, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (14, 0, 23, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (15, 0, 24, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (16, 0, 25, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (17, 2, 14, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (18, 2, 15, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (19, 2, 16, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (20, 2, 17, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (21, 2, 18, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (22, 2, 19, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (23, 2, 20, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (24, 2, 21, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (25, 2, 22, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (26, 2, 23, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (27, 2, 24, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (28, 2, 25, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (29, 3, 14, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (30, 3, 15, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (31, 3, 16, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (32, 3, 17, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (33, 3, 18, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (34, 3, 19, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (35, 3, 20, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (36, 3, 21, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (37, 3, 22, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (38, 3, 23, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (39, 3, 24, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (40, 3, 25, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (41, 4, 14, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (42, 4, 15, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (43, 4, 16, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (44, 4, 17, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (45, 4, 18, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (46, 4, 19, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (47, 4, 20, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (48, 4, 21, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (49, 4, 22, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (50, 4, 23, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (51, 4, 24, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (52, 4, 25, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (53, 5, 14, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (54, 5, 15, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (55, 5, 16, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (56, 5, 17, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (57, 5, 18, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (58, 5, 19, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (59, 5, 20, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (60, 5, 21, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (61, 5, 22, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (62, 5, 23, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (63, 5, 24, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (64, 5, 25, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (65, 6, 26, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (66, 6, 27, 1, 15, 4)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (67, 6, 28, 1, 15, 4)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (68, 6, 29, 1, 15, 4)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (69, 6, 30, 1, 15, 4)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (70, 6, 31, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (71, 7, 26, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (72, 7, 27, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (73, 7, 28, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (74, 7, 29, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (75, 7, 30, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (76, 7, 31, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (77, 8, 26, 1, 15, 4)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (78, 8, 27, 1, 15, 4)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (79, 8, 28, 1, 15, 4)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (80, 8, 29, 1, 15, 4)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (81, 8, 30, 1, 15, 4)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (82, 8, 31, 1, 15, 4)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (83, 9, 26, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (84, 9, 27, 1, 15, 3)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (85, 9, 28, 1, 15, 3)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (86, 9, 29, 1, 15, 3)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (87, 9, 30, 1, 15, 3)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (88, 9, 31, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (89, 10, 26, 0, 400, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (90, 10, 27, 0, 400, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (91, 10, 28, 1, 400, 7)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (92, 10, 29, 1, 400, 7)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (93, 10, 30, 0, 400, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (94, 10, 31, 0, 400, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (95, 11, 0, 0, 500, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (96, 11, 1, 0, 500, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (97, 11, 2, 0, 500, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (98, 11, 3, 0, 500, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (99, 11, 4, 0, 500, NULL)
GO
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (100, 11, 5, 0, 500, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (101, 11, 6, 0, 500, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (102, 11, 7, 0, 500, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (103, 11, 8, 0, 500, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (104, 12, 32, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (105, 12, 33, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (106, 12, 34, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (107, 12, 35, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (108, 12, 36, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (109, 12, 37, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (110, 12, 38, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (111, 12, 39, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (112, 12, 40, 0, 15, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (113, 13, 32, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (114, 13, 33, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (115, 13, 34, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (116, 13, 35, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (117, 13, 36, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (118, 13, 37, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (119, 13, 38, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (120, 13, 39, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (121, 13, 40, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (122, 14, 32, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (123, 14, 33, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (124, 14, 34, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (125, 14, 35, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (126, 14, 36, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (127, 14, 37, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (128, 14, 38, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (129, 14, 39, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (130, 14, 40, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (131, 15, 32, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (132, 15, 33, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (133, 15, 34, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (134, 15, 35, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (135, 15, 36, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (136, 15, 37, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (137, 15, 38, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (138, 15, 39, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (139, 15, 40, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (140, 16, 32, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (141, 16, 33, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (142, 16, 34, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (143, 16, 35, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (144, 16, 36, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (145, 16, 37, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (146, 16, 38, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (147, 16, 39, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (148, 16, 40, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (149, 17, 32, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (150, 17, 33, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (151, 17, 34, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (152, 17, 35, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (153, 17, 36, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (154, 17, 37, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (155, 17, 38, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (156, 17, 39, 0, 300, NULL)
INSERT [dbo].[Tickets] ([id], [session_id], [place_id], [state], [price], [user_id]) VALUES (157, 17, 40, 0, 300, NULL)
INSERT [dbo].[Users] ([id], [name], [surname], [email], [sex], [login], [password], [is admin]) VALUES (0, N'Александр', N'Зайцев', N'cfif6734@gmail.com', N'не определено', N'cfif6734@gmail.com', N'zxcmnbv12.', NULL)
INSERT [dbo].[Users] ([id], [name], [surname], [email], [sex], [login], [password], [is admin]) VALUES (1, N'Имя', N'Фамилия', N'cfif6734@gmail.com', N'не определено', N'cfif6734@gmail.com', N'1234', NULL)
INSERT [dbo].[Users] ([id], [name], [surname], [email], [sex], [login], [password], [is admin]) VALUES (2, N'Александр', N'Зайцев', N'cfif6734@gmail.com', N'не определено', N'cfif6734@gmail.com', N'123456', NULL)
INSERT [dbo].[Users] ([id], [name], [surname], [email], [sex], [login], [password], [is admin]) VALUES (3, N'Алексундаетр', N'Зайцев', N'cfif6734@gmail.com', N'мужской', N'cfif6734@gmail.com', N'2', NULL)
INSERT [dbo].[Users] ([id], [name], [surname], [email], [sex], [login], [password], [is admin]) VALUES (4, N'Хозяин', N'Просто хозяин', N'admin', N'мужской', N'admin', N'admin', 1)
INSERT [dbo].[Users] ([id], [name], [surname], [email], [sex], [login], [password], [is admin]) VALUES (5, N'Ванечек', N'Тренечек', N'cfif6734@gmail.com', N'не выбрано', N'cfif6734@gmail.com', N'0987', 0)
INSERT [dbo].[Users] ([id], [name], [surname], [email], [sex], [login], [password], [is admin]) VALUES (6, N'Федя', N'Федотов', N'cfif6734@gmail.com', N'не выбрано', N'cfif6734@gmail.com', N'12345678', 0)
INSERT [dbo].[Users] ([id], [name], [surname], [email], [sex], [login], [password], [is admin]) VALUES (7, N'Александр', N'Зайцев', N'cfif6734@gmail.com', N'не выбрано', N'cfif6734@gmail.com', N'zxcv', 0)
ALTER TABLE [dbo].[Tickets] ADD  CONSTRAINT [DF_Tickets_state]  DEFAULT ((0)) FOR [state]
GO
ALTER TABLE [dbo].[Halls]  WITH CHECK ADD  CONSTRAINT [FK_Halls_Cinemas] FOREIGN KEY([cinema_id])
REFERENCES [dbo].[Cinemas] ([id])
GO
ALTER TABLE [dbo].[Halls] CHECK CONSTRAINT [FK_Halls_Cinemas]
GO
ALTER TABLE [dbo].[Places]  WITH CHECK ADD  CONSTRAINT [FK_Place_Halls] FOREIGN KEY([hall_id])
REFERENCES [dbo].[Halls] ([id])
GO
ALTER TABLE [dbo].[Places] CHECK CONSTRAINT [FK_Place_Halls]
GO
ALTER TABLE [dbo].[Sessions]  WITH CHECK ADD  CONSTRAINT [FK_Sessions_Films] FOREIGN KEY([film_id])
REFERENCES [dbo].[Films] ([id])
GO
ALTER TABLE [dbo].[Sessions] CHECK CONSTRAINT [FK_Sessions_Films]
GO
ALTER TABLE [dbo].[Sessions]  WITH CHECK ADD  CONSTRAINT [FK_Sessions_Halls] FOREIGN KEY([hall_id])
REFERENCES [dbo].[Halls] ([id])
GO
ALTER TABLE [dbo].[Sessions] CHECK CONSTRAINT [FK_Sessions_Halls]
GO
ALTER TABLE [dbo].[Sessions]  WITH CHECK ADD  CONSTRAINT [FK_Sessions_Session_types] FOREIGN KEY([session_type])
REFERENCES [dbo].[Session_types] ([id])
GO
ALTER TABLE [dbo].[Sessions] CHECK CONSTRAINT [FK_Sessions_Session_types]
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD  CONSTRAINT [FK_Tickets_Place] FOREIGN KEY([place_id])
REFERENCES [dbo].[Places] ([id])
GO
ALTER TABLE [dbo].[Tickets] CHECK CONSTRAINT [FK_Tickets_Place]
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD  CONSTRAINT [FK_Tickets_Sessions] FOREIGN KEY([session_id])
REFERENCES [dbo].[Sessions] ([id])
GO
ALTER TABLE [dbo].[Tickets] CHECK CONSTRAINT [FK_Tickets_Sessions]
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD  CONSTRAINT [FK_Tickets_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Tickets] CHECK CONSTRAINT [FK_Tickets_Users]
GO
USE [master]
GO
ALTER DATABASE [VirtualCinema] SET  READ_WRITE 
GO
