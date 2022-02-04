USE [master]
GO
/****** Object:  Database [HighSchool]    Script Date: 2022-02-03 15:04:46 ******/
CREATE DATABASE [HighSchool]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HighSchool', FILENAME = N'D:\Hämtade filer\MSSQL15.MSSQLSERVER\MSSQL\DATA\HighSchool.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'HighSchool_log', FILENAME = N'D:\Hämtade filer\MSSQL15.MSSQLSERVER\MSSQL\DATA\HighSchool_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [HighSchool] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HighSchool].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HighSchool] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HighSchool] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HighSchool] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HighSchool] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HighSchool] SET ARITHABORT OFF 
GO
ALTER DATABASE [HighSchool] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [HighSchool] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HighSchool] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HighSchool] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HighSchool] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HighSchool] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HighSchool] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HighSchool] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HighSchool] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HighSchool] SET  DISABLE_BROKER 
GO
ALTER DATABASE [HighSchool] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HighSchool] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HighSchool] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HighSchool] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HighSchool] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HighSchool] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HighSchool] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HighSchool] SET RECOVERY FULL 
GO
ALTER DATABASE [HighSchool] SET  MULTI_USER 
GO
ALTER DATABASE [HighSchool] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HighSchool] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HighSchool] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HighSchool] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [HighSchool] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [HighSchool] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'HighSchool', N'ON'
GO
ALTER DATABASE [HighSchool] SET QUERY_STORE = OFF
GO
USE [HighSchool]
GO
/****** Object:  Table [dbo].[tblPersonal_]    Script Date: 2022-02-03 15:04:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPersonal_](
	[P_ID] [float] NOT NULL,
	[P_Förnamn] [nvarchar](255) NULL,
	[P_Efternamn] [nvarchar](255) NULL,
	[P_Arbete] [nvarchar](255) NULL,
	[P_ÅrAvArbete] [int] NULL,
	[P_Lön] [decimal](18, 0) NULL,
 CONSTRAINT [PK_tblPersonal_] PRIMARY KEY CLUSTERED 
(
	[P_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwPersonalMedellön]    Script Date: 2022-02-03 15:04:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vwPersonalMedellön]
as
select P_Arbete as 'Avdelning', AVG(P_Lön) as 'Medellön' from tblPersonal_
group by P_Arbete 
GO
/****** Object:  View [dbo].[vwPersonalInfo]    Script Date: 2022-02-03 15:04:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vwPersonalInfo] 
as
select (P_Förnamn + ' '+ P_Efternamn) as 'Personal', P_Arbete as 'Arbete', P_ÅrAvArbete as 'År på skolan' from tblPersonal_
GO
/****** Object:  Table [dbo].[tblKurser]    Script Date: 2022-02-03 15:04:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblKurser](
	[K_ID] [float] NOT NULL,
	[K_Namn] [nvarchar](255) NOT NULL,
	[K_Poäng] [int] NULL,
 CONSTRAINT [PK_tblKurser] PRIMARY KEY CLUSTERED 
(
	[K_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblElever]    Script Date: 2022-02-03 15:04:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblElever](
	[E_ID] [float] NOT NULL,
	[E_Förnamn] [nvarchar](255) NULL,
	[E_Efternamn] [nvarchar](255) NULL,
	[E_Personnummer] [nvarchar](255) NULL,
	[E_Klass_ID] [float] NULL,
 CONSTRAINT [PK_tblElever] PRIMARY KEY CLUSTERED 
(
	[E_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblEleverKurser]    Script Date: 2022-02-03 15:04:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblEleverKurser](
	[EK_ID] [float] NOT NULL,
	[EK_ElevID] [float] NULL,
	[EK_KursID] [float] NULL,
	[EK_Betyg] [nvarchar](255) NULL,
	[EK_BetygDatum] [nvarchar](255) NULL,
 CONSTRAINT [PK_tblEleverKurser] PRIMARY KEY CLUSTERED 
(
	[EK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblBetyg]    Script Date: 2022-02-03 15:04:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblBetyg](
	[B_Bokstav] [nvarchar](255) NOT NULL,
	[B_Värde] [float] NULL,
 CONSTRAINT [PK_tblBetyg] PRIMARY KEY CLUSTERED 
(
	[B_Bokstav] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwMånadensBetyg]    Script Date: 2022-02-03 15:04:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vwMånadensBetyg]
as
select (E_Förnamn + char(9) + E_Efternamn) as 'Elev',  (K_Namn) as 'Kurs', (B_Bokstav) as 'Betyg' from tblEleverKurser
join tblElever on E_ID = EK_ElevID
join tblKurser on K_ID = EK_KursID
join tblBetyg on B_Bokstav = EK_Betyg
where DATEDIFF(DAY, EK_BetygDatum, GETDATE()) <= 31
GO
/****** Object:  View [dbo].[vwBetygStatistik]    Script Date: 2022-02-03 15:04:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vwBetygStatistik]
as
select (K_Namn) as Kurs,
CASE 
WHEN AVG(B_Värde) = 20 THEN 'A' WHEN AVG(B_Värde) >= 19.25 THEN 'A-'
WHEN AVG(B_Värde) >= 18.75 THEN 'B+' WHEN AVG(B_Värde) >= 17.5 THEN 'B' WHEN AVG(B_Värde) >= 17 THEN 'B-'
WHEN AVG(B_Värde) >= 16.5 THEN 'C+' WHEN AVG(B_Värde) >= 15 THEN 'C' WHEN AVG(B_Värde) >= 14.5 THEN 'C-'
WHEN AVG(B_Värde) >= 13.75 THEN 'D+' WHEN AVG(B_Värde) >= 12.5 THEN 'D' WHEN AVG(B_Värde) >= 12 THEN 'D-'
WHEN AVG(B_Värde) >= 11.5 THEN 'E+' WHEN AVG(B_Värde) >= 10 THEN 'E'
WHEN AVG(B_Värde) >= 0 THEN 'F'
ELSE '-'
END AS 'Medelbetyg',
CASE 
WHEN MIN(B_Värde) = 20 THEN 'A'
WHEN MIN(B_Värde) = 17.5 THEN 'B'
WHEN MIN(B_Värde) = 15 THEN 'C'
WHEN MIN(B_Värde) = 12.5 THEN 'D'
WHEN MIN(B_Värde) = 10 THEN 'E'
WHEN MIN(B_Värde) = 0 THEN 'F'
ELSE '-'
END AS 'Lägsta betyg',
CASE 
WHEN MAX(B_Värde) = 20 THEN 'A'
WHEN MAX(B_Värde) = 17.5 THEN 'B'
WHEN MAX(B_Värde) = 15 THEN 'C'
WHEN MAX(B_Värde) = 12.5 THEN 'D'
WHEN MAX(B_Värde) = 10 THEN 'E'
WHEN MAX(B_Värde) = 0 THEN 'F'
ELSE '-'
END AS 'Högsta betyg' from tblEleverKurser
join tblBetyg on B_Bokstav = EK_Betyg or B_Bokstav = null
join tblKurser on K_ID = EK_KursID
group by K_Namn
GO
/****** Object:  View [dbo].[MedelBetyg]    Script Date: 2022-02-03 15:04:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[MedelBetyg]
as
select AVG(B_BetygVärde) as 'Medelbetyg' from tblEleverKurser
join baseGiltigaBetyg on B_BetygBokstav = EK_Betyg
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 2022-02-03 15:04:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblKlasser]    Script Date: 2022-02-03 15:04:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblKlasser](
	[Kl_ID] [float] NOT NULL,
	[Kl_KlassNamn] [nvarchar](255) NULL,
 CONSTRAINT [PK_tblKlasser] PRIMARY KEY CLUSTERED 
(
	[Kl_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblKurserPersonal]    Script Date: 2022-02-03 15:04:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblKurserPersonal](
	[KP_ID] [float] NOT NULL,
	[KP_KursID] [float] NULL,
	[KP_PersonalID] [float] NULL,
 CONSTRAINT [PK_tblKurserPersonal] PRIMARY KEY CLUSTERED 
(
	[KP_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblLärare]    Script Date: 2022-02-03 15:04:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLärare](
	[L_ID] [float] NOT NULL,
	[L_KlassID] [float] NULL,
 CONSTRAINT [PK_tblLärare] PRIMARY KEY CLUSTERED 
(
	[L_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblElever]  WITH CHECK ADD  CONSTRAINT [FK_tblElever_tblKlasser] FOREIGN KEY([E_Klass_ID])
REFERENCES [dbo].[tblKlasser] ([Kl_ID])
GO
ALTER TABLE [dbo].[tblElever] CHECK CONSTRAINT [FK_tblElever_tblKlasser]
GO
ALTER TABLE [dbo].[tblEleverKurser]  WITH CHECK ADD  CONSTRAINT [FK_EK_Betyg] FOREIGN KEY([EK_Betyg])
REFERENCES [dbo].[tblBetyg] ([B_Bokstav])
GO
ALTER TABLE [dbo].[tblEleverKurser] CHECK CONSTRAINT [FK_EK_Betyg]
GO
ALTER TABLE [dbo].[tblEleverKurser]  WITH CHECK ADD  CONSTRAINT [FK_tblEleverKurser_tblElever] FOREIGN KEY([EK_ElevID])
REFERENCES [dbo].[tblElever] ([E_ID])
GO
ALTER TABLE [dbo].[tblEleverKurser] CHECK CONSTRAINT [FK_tblEleverKurser_tblElever]
GO
ALTER TABLE [dbo].[tblEleverKurser]  WITH CHECK ADD  CONSTRAINT [FK_tblEleverKurser_tblKurser] FOREIGN KEY([EK_KursID])
REFERENCES [dbo].[tblKurser] ([K_ID])
GO
ALTER TABLE [dbo].[tblEleverKurser] CHECK CONSTRAINT [FK_tblEleverKurser_tblKurser]
GO
ALTER TABLE [dbo].[tblKurserPersonal]  WITH CHECK ADD  CONSTRAINT [FK_tblKurserPersonal_tblKurser] FOREIGN KEY([KP_KursID])
REFERENCES [dbo].[tblKurser] ([K_ID])
GO
ALTER TABLE [dbo].[tblKurserPersonal] CHECK CONSTRAINT [FK_tblKurserPersonal_tblKurser]
GO
ALTER TABLE [dbo].[tblKurserPersonal]  WITH CHECK ADD  CONSTRAINT [FK_tblKurserPersonal_tblLärare] FOREIGN KEY([KP_PersonalID])
REFERENCES [dbo].[tblLärare] ([L_ID])
GO
ALTER TABLE [dbo].[tblKurserPersonal] CHECK CONSTRAINT [FK_tblKurserPersonal_tblLärare]
GO
ALTER TABLE [dbo].[tblLärare]  WITH CHECK ADD  CONSTRAINT [FK_tblLärare_tblKlasser] FOREIGN KEY([L_KlassID])
REFERENCES [dbo].[tblKlasser] ([Kl_ID])
GO
ALTER TABLE [dbo].[tblLärare] CHECK CONSTRAINT [FK_tblLärare_tblKlasser]
GO
ALTER TABLE [dbo].[tblLärare]  WITH CHECK ADD  CONSTRAINT [FK_tblLärare_tblPersonal_] FOREIGN KEY([L_ID])
REFERENCES [dbo].[tblPersonal_] ([P_ID])
GO
ALTER TABLE [dbo].[tblLärare] CHECK CONSTRAINT [FK_tblLärare_tblPersonal_]
GO
/****** Object:  StoredProcedure [dbo].[spElevsAvslutadeKurser]    Script Date: 2022-02-03 15:04:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spElevsAvslutadeKurser]
@ElevID int
as begin
select (K_Namn) as 'Kurs', (EK_Betyg) as 'Betyg',
(P_Förnamn + char(9) + P_Efternamn) as 'Lärare', (EK_BetygDatum) as 'Datum'  from tblEleverKurser
join tblElever on EK_ElevID = E_ID 
join tblKurser on EK_KursID = K_ID
join tblKurserPersonal on EK_KursID = KP_KursID
join  tblPersonal_ on KP_PersonalID = P_ID
where EK_Betyg != '-' and
E_ID = @ElevID
order by K_Namn
end 
GO
/****** Object:  StoredProcedure [dbo].[spSkapaElever]    Script Date: 2022-02-03 15:04:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spSkapaElever]
@ElevID int, @ElevFörnamn varchar(20), @ElevEfternamn varchar(20), @ElevPersonnummer varchar(20), @ElevKlassID int
as begin
insert into tblElever
(E_ID, E_Förnamn, E_Efternamn, E_Personnummer, E_Klass_ID)
values
(@ElevID, @ElevFörnamn, @ElevEfternamn, @ElevPersonnummer, @ElevKlassID)
END
GO
