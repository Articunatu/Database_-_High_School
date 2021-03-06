USE [master]
GO
/****** Object:  Database [HighSchoolDB]    Script Date: 2022-02-11 11:04:04 ******/
CREATE DATABASE [HighSchoolDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HighSchool', FILENAME = N'D:\Hämtade filer\MSSQL15.MSSQLSERVER\MSSQL\DATA\HighSchool.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'HighSchool_log', FILENAME = N'D:\Hämtade filer\MSSQL15.MSSQLSERVER\MSSQL\DATA\HighSchool_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [HighSchoolDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HighSchoolDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HighSchoolDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HighSchoolDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HighSchoolDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HighSchoolDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HighSchoolDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [HighSchoolDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [HighSchoolDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HighSchoolDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HighSchoolDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HighSchoolDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HighSchoolDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HighSchoolDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HighSchoolDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HighSchoolDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HighSchoolDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [HighSchoolDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HighSchoolDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HighSchoolDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HighSchoolDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HighSchoolDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HighSchoolDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HighSchoolDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HighSchoolDB] SET RECOVERY FULL 
GO
ALTER DATABASE [HighSchoolDB] SET  MULTI_USER 
GO
ALTER DATABASE [HighSchoolDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HighSchoolDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HighSchoolDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HighSchoolDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [HighSchoolDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [HighSchoolDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'HighSchoolDB', N'ON'
GO
ALTER DATABASE [HighSchoolDB] SET QUERY_STORE = OFF
GO
USE [HighSchoolDB]
GO
/****** Object:  Table [dbo].[tblStudents]    Script Date: 2022-02-11 11:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblStudents](
	[S_ID] [int] NOT NULL,
	[S_FirstName] [varchar](20) NULL,
	[S_LastName] [varchar](20) NULL,
	[S_SecurityNumber] [varchar](20) NOT NULL,
	[S_ClassID] [int] NULL,
 CONSTRAINT [PK_tblElever] PRIMARY KEY CLUSTERED 
(
	[S_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCourses]    Script Date: 2022-02-11 11:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCourses](
	[C_ID] [int] NOT NULL,
	[C_Name] [varchar](20) NOT NULL,
	[C_Points] [int] NOT NULL,
 CONSTRAINT [PK_tblKurser] PRIMARY KEY CLUSTERED 
(
	[C_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblStudentCourses]    Script Date: 2022-02-11 11:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblStudentCourses](
	[SC_ID] [int] NOT NULL,
	[SC_StudentID] [int] NOT NULL,
	[SC_CourseID] [int] NOT NULL,
	[SC_Grade] [char](1) NULL,
	[SC_Date] [varchar](20) NULL,
 CONSTRAINT [PK_tblEleverKurser] PRIMARY KEY CLUSTERED 
(
	[SC_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblEmployees]    Script Date: 2022-02-11 11:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblEmployees](
	[E_ID] [int] NOT NULL,
	[E_FirstName] [varchar](20) NOT NULL,
	[E_LastName] [varchar](20) NOT NULL,
	[E_Job] [varchar](20) NOT NULL,
	[E_YearsOfWork] [int] NULL,
	[E_Salary] [float] NULL,
 CONSTRAINT [PK_tblPersonal_] PRIMARY KEY CLUSTERED 
(
	[E_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblClasses]    Script Date: 2022-02-11 11:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblClasses](
	[Cl_ID] [int] NOT NULL,
	[Cl_Name] [varchar](20) NOT NULL,
 CONSTRAINT [PK_tblKlasser] PRIMARY KEY CLUSTERED 
(
	[Cl_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblTeacherCourses]    Script Date: 2022-02-11 11:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTeacherCourses](
	[TC_ID] [int] NOT NULL,
	[TC_CourseID] [int] NOT NULL,
	[TC_IsGrader] [int] NOT NULL,
	[TC_TeacherID] [int] NOT NULL,
 CONSTRAINT [PK_tblKurserPersonal] PRIMARY KEY CLUSTERED 
(
	[TC_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwClassesStudentsGrades]    Script Date: 2022-02-11 11:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vwClassesStudentsGrades]
as
select (S_FirstName + ' ' + S_LastName) as 'Elev', Cl_Name as 'Klass' ,C_Name as 'Kurs', SC_Grade as 'Betyg',
(E_FirstName + char(9) + E_LastName) as 'Lärare', (SC_Date) as 'Datum'  from tblStudentCourses
join tblStudents on SC_StudentID = S_ID 
join tblCourses on SC_CourseID = C_ID
join tblTeacherCourses on SC_CourseID = TC_CourseID
join tblEmployees on TC_TeacherID = E_ID
join tblClasses on S_ClassID = Cl_ID
where SC_Grade != '-' and TC_IsGrader = 0
GO
/****** Object:  View [dbo].[vwTeachersPrograms]    Script Date: 2022-02-11 11:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vwTeachersPrograms]
as
select distinct(E_FirstName + ' ' + E_LastName) as 'Lärare', 
CASE
When Substring(Cl_Name, 1, 2) = 'DE' then 'Design'
When Substring(Cl_Name, 1, 2) = 'MA' then 'Maskin'
When Substring(Cl_Name, 1, 2) = 'NA' then 'Natur'
end as 'Utbildning' from tblClasses
join tblStudents on S_ClassID = Cl_ID
join tblStudentCourses on S_ID = SC_StudentID
join tblTeacherCourses on SC_CourseID = TC_CourseID
join tblEmployees on TC_TeacherID = E_ID
GO
/****** Object:  Table [dbo].[tblGrades]    Script Date: 2022-02-11 11:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblGrades](
	[G_Letter] [char](1) NOT NULL,
	[G_Value] [float] NULL,
 CONSTRAINT [PK_tblBetyg] PRIMARY KEY CLUSTERED 
(
	[G_Letter] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwMonthlyGrades]    Script Date: 2022-02-11 11:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vwMonthlyGrades]
as
select (S_FirstName + char(9) + S_LastName) as 'Elev',  (C_Name) as 'Kurs', 
(G_Letter) as 'Betyg', SC_Date as 'Datum' from tblStudentCourses
join tblStudents on S_ID = SC_StudentID
join tblCourses on C_ID = SC_CourseID
join tblGrades on G_Letter = SC_Grade
where DATEDIFF(DAY, SC_Date, GETDATE()) <= 31
GO
/****** Object:  View [dbo].[vwGradeStatistics]    Script Date: 2022-02-11 11:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vwGradeStatistics]
as
select (C_Name) as Kurs,
CASE 
WHEN AVG(G_Value) = 20 THEN 'A' WHEN AVG(G_Value) >= 19.25 THEN 'A-'
WHEN AVG(G_Value) >= 18.75 THEN 'B+' WHEN AVG(G_Value) >= 17.5 THEN 'B' WHEN AVG(G_Value) >= 17 THEN 'B-'
WHEN AVG(G_Value) >= 16.5 THEN 'C+' WHEN AVG(G_Value) >= 15 THEN 'C' WHEN AVG(G_Value) >= 14.5 THEN 'C-'
WHEN AVG(G_Value) >= 13.75 THEN 'D+' WHEN AVG(G_Value) >= 12.5 THEN 'D' WHEN AVG(G_Value) >= 12 THEN 'D-'
WHEN AVG(G_Value) >= 11.5 THEN 'E+' WHEN AVG(G_Value) >= 10 THEN 'E'
WHEN AVG(G_Value) >= 0 THEN 'F'
ELSE '-'
END AS 'Medelbetyg',
CASE 
WHEN MIN(G_Value) = 20 THEN 'A'
WHEN MIN(G_Value) = 17.5 THEN 'B'
WHEN MIN(G_Value) = 15 THEN 'C'
WHEN MIN(G_Value) = 12.5 THEN 'D'
WHEN MIN(G_Value) = 10 THEN 'E'
WHEN MIN(G_Value) = 0 THEN 'F'
ELSE '-'
END AS 'Lägsta betyg',
CASE 
WHEN MAX(G_Value) = 20 THEN 'A'
WHEN MAX(G_Value) = 17.5 THEN 'B'
WHEN MAX(G_Value) = 15 THEN 'C'
WHEN MAX(G_Value) = 12.5 THEN 'D'
WHEN MAX(G_Value) = 10 THEN 'E'
WHEN MAX(G_Value) = 0 THEN 'F'
ELSE '-'
END AS 'Högsta betyg' from tblStudentCourses
join tblGrades on G_Letter = SC_Grade or G_Letter = null
join tblCourses on C_ID = SC_CourseID
group by C_Name
GO
/****** Object:  View [dbo].[vwValueStatistics]    Script Date: 2022-02-11 11:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vwValueStatistics]
as
select (C_Name) as Kurs, Round(AVG(G_Value), 2) as 'Medelbetyg', MIN(G_Value) as 'Lägsta betyg', 
MAX(G_Value) as 'Högsta betyg' from tblStudentCourses
join tblGrades on G_Letter = SC_Grade
join tblCourses on C_ID = SC_CourseID
group by C_Name
GO
/****** Object:  View [dbo].[vwEmployeesInfo]    Script Date: 2022-02-11 11:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vwEmployeesInfo]
as
select (E_FirstName + ' '+ E_LastName) as 'Personal', E_Job as 'Arbete', E_YearsOfWork as 'År på skolan' from tblEmployees
GO
/****** Object:  Table [dbo].[tblTeacher]    Script Date: 2022-02-11 11:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTeacher](
	[T_ID] [int] NOT NULL,
	[T_ClassID] [int] NULL,
	[T_DepartmentID] [int] NOT NULL,
 CONSTRAINT [PK_tblLärare] PRIMARY KEY CLUSTERED 
(
	[T_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblDepartment]    Script Date: 2022-02-11 11:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDepartment](
	[D_ID] [int] NOT NULL,
	[D_Name] [varchar](20) NOT NULL,
 CONSTRAINT [PK_tblDepartment] PRIMARY KEY CLUSTERED 
(
	[D_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwStaffAvgSalary]    Script Date: 2022-02-11 11:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vwStaffAvgSalary]
as
select D_Name as 'Avdelning', Round(AVG(E_Salary), 0) as 'Medellön' from tblTeacher
join tblDepartment on T_DepartmentID = D_ID
join tblEmployees on T_ID = E_ID
group by D_Name 
GO
/****** Object:  View [dbo].[vwPaymentDepartment]    Script Date: 2022-02-11 11:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vwPaymentDepartment]
as
select D_Name as 'Avdelning', sum(E_Salary) as 'Utbetalning' from tblEmployees
join tblTeacher on E_ID = T_ID
join tblDepartment on T_DepartmentID = D_ID
group by D_Name
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 2022-02-11 11:04:05 ******/
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
ALTER TABLE [dbo].[tblStudentCourses]  WITH CHECK ADD  CONSTRAINT [FK_EK_Betyg] FOREIGN KEY([SC_Grade])
REFERENCES [dbo].[tblGrades] ([G_Letter])
GO
ALTER TABLE [dbo].[tblStudentCourses] CHECK CONSTRAINT [FK_EK_Betyg]
GO
ALTER TABLE [dbo].[tblStudentCourses]  WITH CHECK ADD  CONSTRAINT [FK_tblEleverKurser_tblElever] FOREIGN KEY([SC_StudentID])
REFERENCES [dbo].[tblStudents] ([S_ID])
GO
ALTER TABLE [dbo].[tblStudentCourses] CHECK CONSTRAINT [FK_tblEleverKurser_tblElever]
GO
ALTER TABLE [dbo].[tblStudentCourses]  WITH CHECK ADD  CONSTRAINT [FK_tblEleverKurser_tblKurser] FOREIGN KEY([SC_CourseID])
REFERENCES [dbo].[tblCourses] ([C_ID])
GO
ALTER TABLE [dbo].[tblStudentCourses] CHECK CONSTRAINT [FK_tblEleverKurser_tblKurser]
GO
ALTER TABLE [dbo].[tblStudents]  WITH CHECK ADD  CONSTRAINT [FK_tblElever_tblKlasser] FOREIGN KEY([S_ClassID])
REFERENCES [dbo].[tblClasses] ([Cl_ID])
GO
ALTER TABLE [dbo].[tblStudents] CHECK CONSTRAINT [FK_tblElever_tblKlasser]
GO
ALTER TABLE [dbo].[tblTeacher]  WITH CHECK ADD  CONSTRAINT [FK_tblLärare_tblKlasser] FOREIGN KEY([T_ClassID])
REFERENCES [dbo].[tblClasses] ([Cl_ID])
GO
ALTER TABLE [dbo].[tblTeacher] CHECK CONSTRAINT [FK_tblLärare_tblKlasser]
GO
ALTER TABLE [dbo].[tblTeacher]  WITH CHECK ADD  CONSTRAINT [FK_tblLärare_tblPersonal_] FOREIGN KEY([T_ID])
REFERENCES [dbo].[tblEmployees] ([E_ID])
GO
ALTER TABLE [dbo].[tblTeacher] CHECK CONSTRAINT [FK_tblLärare_tblPersonal_]
GO
ALTER TABLE [dbo].[tblTeacher]  WITH CHECK ADD  CONSTRAINT [FK_tblTeacher_tblDepartment] FOREIGN KEY([T_DepartmentID])
REFERENCES [dbo].[tblDepartment] ([D_ID])
GO
ALTER TABLE [dbo].[tblTeacher] CHECK CONSTRAINT [FK_tblTeacher_tblDepartment]
GO
ALTER TABLE [dbo].[tblTeacherCourses]  WITH CHECK ADD  CONSTRAINT [FK_tblKurserPersonal_tblKurser] FOREIGN KEY([TC_CourseID])
REFERENCES [dbo].[tblCourses] ([C_ID])
GO
ALTER TABLE [dbo].[tblTeacherCourses] CHECK CONSTRAINT [FK_tblKurserPersonal_tblKurser]
GO
ALTER TABLE [dbo].[tblTeacherCourses]  WITH CHECK ADD  CONSTRAINT [FK_tblKurserPersonal_tblLärare] FOREIGN KEY([TC_TeacherID])
REFERENCES [dbo].[tblTeacher] ([T_ID])
GO
ALTER TABLE [dbo].[tblTeacherCourses] CHECK CONSTRAINT [FK_tblKurserPersonal_tblLärare]
GO
/****** Object:  StoredProcedure [dbo].[spAddStaff]    Script Date: 2022-02-11 11:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spAddStaff]
@EmpID int, @EmpFName varchar(20), @EmpLName varchar(20), @EmpJob varchar(20), @EmpYears int, @EmpSalary int
as begin
insert into tblEmployees
(E_ID, E_FirstName, E_LastName, E_Job, E_YearsOfWork, E_Salary)
values
(@EmpID, @EmpFName, @EmpLName, @EmpJob, @EmpYears, @EmpSalary)
END
GO
/****** Object:  StoredProcedure [dbo].[spAddStudents]    Script Date: 2022-02-11 11:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spAddStudents]
@StudentID int, @StudentFName varchar(20), @StudentLName varchar(20), @StudentSNum varchar(20), @StudentClassID int
as begin
insert into tblStudents
(S_ID, S_FirstName, S_LastName, S_SecurityNumber, S_ClassID)
values
(@StudentID, @StudentFName, @StudentLName, @StudentSNum, @StudentClassID)
END
GO
/****** Object:  StoredProcedure [dbo].[spChosenStaff]    Script Date: 2022-02-11 11:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spChosenStaff]
@ChosenJob varchar(20)
as 
if (@ChosenJob = 'Inget')
begin
select  E_FirstName +' '+ E_LastName as 'Personal', E_Job as 'Arbete'  from tblEmployees
end
else
begin
select  E_FirstName +' '+ E_LastName as 'Personal', E_Job as 'Arbete'  from tblEmployees
where E_Job = @ChosenJob 
END
GO
/****** Object:  StoredProcedure [dbo].[spElevsAvslutadeKurser]    Script Date: 2022-02-11 11:04:05 ******/
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
/****** Object:  StoredProcedure [dbo].[spFinishedCourses]    Script Date: 2022-02-11 11:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spFinishedCourses]
@StudentID int
as begin
select C_Name as 'Kurs', SC_Grade as 'Betyg',
(E_FirstName + char(9) + E_LastName) as 'Lärare', (SC_Date) as 'Datum'  from tblStudentCourses
join tblStudents on SC_StudentID = S_ID 
join tblCourses on SC_CourseID = C_ID
join tblTeacherCourses on SC_CourseID = TC_CourseID
join  tblEmployees on TC_TeacherID = E_ID
where SC_Grade != '-' and TC_IsGrader = 0 and
S_ID = @StudentID
order by SC_ID asc
end
GO
/****** Object:  StoredProcedure [dbo].[spGrading]    Script Date: 2022-02-11 11:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spGrading]
@StudentID int, @StudentCourseID int, @StudentGrade char
as 
begin try
 begin transaction 
  update tblStudentCourses set SC_Grade = @StudentGrade 
  where SC_StudentID = @StudentID and SC_CourseID = @StudentCourseID
  update tblStudentCourses set SC_Date = GETDATE()
  where SC_StudentID = @StudentID and SC_CourseID = @StudentCourseID
 commit transaction
Print 'Betyget har satts!'
end try
begin catch
rollback
print 'Betygsättningen togs tillbaka!'
end catch
GO
/****** Object:  StoredProcedure [dbo].[spSkapaElever]    Script Date: 2022-02-11 11:04:05 ******/
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
/****** Object:  StoredProcedure [dbo].[spStudentsInfo]    Script Date: 2022-02-11 11:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spStudentsInfo]
@StudentID int
as begin
select (S_FirstName + ' ' + S_LastName) as 'Elev', S_SecurityNumber as 'Personnummer' from tblStudents
where S_ID = @StudentID
end
GO
USE [master]
GO
ALTER DATABASE [HighSchoolDB] SET  READ_WRITE 
GO
