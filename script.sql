USE [master]
GO
/****** Object:  Database [VirtualCinema]    Script Date: 16.05.2020 21:06:55 ******/
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
/****** Object:  Table [dbo].[Cinemas]    Script Date: 16.05.2020 21:06:55 ******/
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
/****** Object:  Table [dbo].[Films]    Script Date: 16.05.2020 21:06:55 ******/
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
/****** Object:  Table [dbo].[Halls]    Script Date: 16.05.2020 21:06:55 ******/
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
/****** Object:  Table [dbo].[Places]    Script Date: 16.05.2020 21:06:55 ******/
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
/****** Object:  Table [dbo].[Session_types]    Script Date: 16.05.2020 21:06:55 ******/
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
/****** Object:  Table [dbo].[Sessions]    Script Date: 16.05.2020 21:06:55 ******/
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
/****** Object:  Table [dbo].[Tickets]    Script Date: 16.05.2020 21:06:55 ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 16.05.2020 21:06:55 ******/
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
