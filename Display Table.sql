
Use HighSchoolDB

drop proc spElevsAvslutadeKurser, spSkapaElever, spUtvaldPersonal
drop view vwBetygStatistik, vwMånadensBetyg, vwPersonalInfo, vwPersonalMedellön

alter database HighSchool modify name = HighSchoolDB

select (E_FirstName + char(9) + E_LastName) as 'Personal', E_Job as 'Arbetsroll' from tblEmployees
--where P_Arbete = 'Lärare'

select * from tblClasses

select (S_FirstName + char(9) + S_LastName) as 'Elev' from tblStudents
order by S_LastName asc

select (S_FirstName + char(9) + S_LastName) as 'Elev', Cl_Name as 'Klass' from tblStudents
join tblClasses on Cl_ID = S_ClassID 
where Cl_ID = 1

select count(SC_Grade) as 'Nya betyg denna månad' from tblStudentCourses ---Should be 2 grades with current table values
where DATEDIFF(DAY, SC_Date, GETDATE()) <= 31;

GO

create proc spChosenStaff
@ChosenJob varchar(20)
with encryption
as 
if (@ChosenJob = 'Inget')
begin
select E_ID, E_FirstName, E_LastName, E_Job  from tblEmployees
end
else
begin
select E_ID, E_FirstName, E_LastName, E_Job  from tblEmployees
where E_Job = @ChosenJob 
END

drop proc spChosenStaff
exec spChosenStaff 'SYV'  

GO

create view vwMonthlyGrades
as
select (S_FirstName + char(9) + S_LastName) as 'Elev',  (C_Name) as 'Kurs', 
(G_Letter) as 'Betyg', SC_Date as 'Datum' from tblStudentCourses
join tblStudents on S_ID = SC_StudentID
join tblCourses on C_ID = SC_CourseID
join tblGrades on G_Letter = SC_Grade
where DATEDIFF(DAY, SC_Date, GETDATE()) <= 31

GO

select * from vwMonthlyGrades

GO

create view vwGradeStatistics
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

go

create view vwValueStatistics
as
select (C_Name) as Kurs, Round(AVG(G_Value), 2) as 'Medelbetyg', MIN(G_Value) as 'Lägsta betyg', 
MAX(G_Value) as 'Högsta betyg' from tblStudentCourses
join tblGrades on G_Letter = SC_Grade
join tblCourses on C_ID = SC_CourseID
group by C_Name

go

select * from vwGradeStatistics
select * from vwValueStatistics


go

create proc spFinishedCourses
@StudentID int
as begin
select C_Name as 'Kurs', SC_Grade as 'Betyg',
(E_FirstName + char(9) + E_LastName) as 'Lärare', (SC_Date) as 'Datum'  from tblStudentCourses
join tblStudents on SC_StudentID = S_ID 
join tblCourses on SC_CourseID = C_ID
join tblTeachersCourses on SC_CourseID = TC_CourseID
join  tblEmployees on TC_TeacherID = E_ID
where SC_Grade != '-' and
S_ID = 1 and TC_IsGrader = 0
order by SC_ID
end 

select distinct C_Name from tblCourses 

exec spFinispFinishedCourses2

select (S_FirstName + char(9) + S_LastName) as 'Elev', C_Name as 'Kurs', SC_Grade as 'Betyg' from tblStudentsCourses
join tblStudents on SC_StudentID = S_ID
join tblCourses on SC_CourseID = C_ID
where S_ClassID = 5
order by S_LastName asc

GO

create proc spAddStudents
@StudentID int, @StudentFName varchar(20), @StudentLName varchar(20), @StudentSNum varchar(20), @StudentClassID int
as begin
insert into tblStudents
(S_ID, S_FirstName, S_LastName, S_SecurityNumber, S_ClassID)
values
(@StudentID, @StudentFName, @StudentLName, @StudentSNum, @StudentClassID)
END

GO

exec spAddStuspAddStudents 121, 'Anders', 'Holm', '20050101-1551', 10

go

create view vwEmployeesInfo
as
select (E_FirstName + ' '+ E_LastName) as 'Personal', E_Job as 'Arbete', E_YearsOfWork as 'År på skolan' from tblEmployees

select * from vwPersonalInfo

GO

create proc spAddStaff
@EmpID int, @EmpFName varchar(20), @EmpLName varchar(20), @EmpJob varchar(20), @EmpYears int, @EmpSalary int
as begin
insert into tblEmployees
(E_ID, E_FirstName, E_LastName, E_Job, E_YearsOfWork, E_Salary)
values
(@EmpID, @EmpFName, @EmpLName, @EmpJob, @EmpYears, @EmpSalary)
END

GO

create view vwStaffAvgSalary
as
select D_Name as 'Avdelning', AVG(E_Salary) as 'Medellön' from tblTeacher
join tblDepartment on T_DepartmentID = D_ID
join tblEmployees on T_ID = E_ID
group by D_Name 

select Avdelning, Round(Medellön, 0) as 'Medellön' from vwStaffAvgSalary

go


create proc spStudentsInfo
@StudentID int
as begin
select (S_FirstName + ' ' + S_LastName) as 'Elev', S_SecurityNumber as 'Personnummer' from tblStudents
end

go

create proc spGrading
@StudentID int, @StudentCourseID int, @StudentGrade char
as 
begin try
 begin transaction 
  update tblStudentsCourses set SC_Grade = @StudentGrade 
  where SC_StudentID = @StudentID and SC_CourseID = @StudentCourseID
  update tblStudentsCourses set SC_DateOfGrade = GETDATE()
  where SC_StudentID = @StudentID and SC_CourseID = @StudentCourseID
 commit transaction
Print 'Betyget har satts!'
end try
begin catch
rollback
print 'Betygsättningen togs tillbaka!'
end catch

go

exec spGrading 1, 3, C

go

create proc spFinishedCourses
@StudentID int
as begin
select C_Name as 'Kurs', SC_Grade as 'Betyg',
(E_FirstName + char(9) + E_LastName) as 'Lärare', (SC_DateOfGrade) as 'Datum'  from tblStudentsCourses
join tblStudents on SC_StudentID = S_ID 
join tblCourses on SC_CourseID = C_ID
join tblTeachersCourses on SC_CourseID = TC_CourseID
join  tblEmployees on TC_TeacherID = E_ID
where SC_Grade != '-' and TC_IsGrader = 0 and
S_ID = @StudentID
order by SC_ID asc
end

go

exec spFinishedCourses 1
select C_Name, E_FirstName, E_LastName from tblTeachersCourses
join tblCourses on TC_CourseID = C_ID
join tblEmployees on TC_TeacherID = E_ID
order by TC_ID

GO

--create proc spExtraStudentInfo
--as begin
--select Cl_Name as 'Klass',  from tblStudentsCourses
--join tblStudents on S_ID = SC_StudentID
--join tblClasses on S_ClassID = Cl_ID
--join tblTeachersCourses on SC_CourseID = TC_CourseID
--join tblEmployees on TC_TeacherID

--create view vwTeachersPrograms
--as
--select (E_FirstName +' '+ E_LastName) as Lärare, Cl from tblEmployees
--join tblTeachers on T_ID = E_ID
--join tblClasses on T_ClassID = Cl_ID

create view vwAverageGrades
as
select C_Name as 'Kurs', Round(AVG(G_Value), 2) as 'Medelbetyg' from tblStudentsCourses
join tblGrades on SC_Grade = G_Letter
join tblStudents on SC_StudentID = S_ID
join tblCourses on SC_CourseID = C_ID AND SC_StudentID = 1
where G_Letter != '-' AND SC_StudentID = S_ID
group by C_Name

select * from tblStudents
join tblStudentsCourses on S_ID = SC_StudentID
where 15 < (select AVG(SC_Grade) from tblStudents)

select S_FirstName, G_Value from tblStudents
join tblStudentsCourses on S_ID = SC_StudentID
join tblCourses on SC_CourseID = C_ID
join tblGrades on SC_Grade = G_Letter
where C_Name = 'Engelska 5'

select top 50 percent (C_Name) as Kurs, Round(AVG(G_Value), 2) as 'Medelbetyg', MIN(G_Value) as 'Lägsta betyg', 
MAX(G_Value) as 'Högsta betyg' from tblStudentsCourses
join tblGrades on G_Letter = SC_Grade
join tblCourses on C_ID = SC_CourseID
group by C_Name

--alter table tblStudents
--check(S_SecurityNumber.ToArray.Count = 11)

go

create view vwTeachersPrograms
as
select (E_FirstName + ' ' + E_LastName) as 'Namn' from tblClasses
join tblStudents on S_ClassID = Cl_ID
join tblStudentsCourses on S_ID = SC_StudentID
join tblTeachersCourses on SC_CourseID = TC_CourseID
join tblEmployees on TC_TeacherID = E_ID

go

select S_FirstName+' '+S_LastName as Namn, Cl_Name as Klass, E_FirstName+' ' +E_LastName as Lärare, C_Name
from tblStudents
join tblClasses on S_ClassID = Cl_ID
join tblStudentsCourses on S_ID = SC_StudentID
join tblCourses on SC_CourseID = C_ID
join tblTeachersCourses on SC_CourseID = TC_CourseID
join tblEmployees on TC_TeacherID = E_ID
where S_ID = 1
order by C_Name asc
