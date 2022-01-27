Use HighSchool

select (P_Förnamn + char(9) + P_Efternamn) as 'Lärare' from tblPersonal_
where P_Arbete = 'Lärare'

select * from tblKlasser

select (E_Förnamn + char(9) + E_Efternamn) as 'Elev' from tblElever
order by E_Efternamn asc

select (E_Förnamn + char(9) + E_Efternamn) as 'Elev', Kl_KlassNamn as 'Klass' from tblElever
join tblKlasser on Kl_ID = E_Klass_ID 
where KL_ID = 1

select count(EK_Betyg) as 'Nya betyg denna månad' from tblEleverKurser ---Should be 2 grades with current table values
where DATEDIFF(DAY, EK_BetygDatum, GETDATE()) <= 31;

GO

create proc spUtvaldPersonal
@ValdKategori varchar(10)
as begin
select (P_Förnamn + char(9) + P_Efternamn), P_Arbete from tblPersonal_
where P_Arbete = @ValdKategori
END

exec spUtvaldPersonal Lärare

GO

create view vwMånadensBetyg
as
select (E_Förnamn + char(9) + E_Efternamn) as 'Elev',  (K_Namn) as 'Kurs', (B_Bokstav) as 'Betyg' from tblEleverKurser
join tblElever on E_ID = EK_ElevID
join tblKurser on K_ID = EK_KursID
join tblBetyg on B_Bokstav = EK_Betyg
where DATEDIFF(DAY, EK_BetygDatum, GETDATE()) <= 31

GO


select * from vwMånadensBetyg

GO

create view vwBetygStatistik
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

select * from vwBetygStatistik

select (E_Förnamn + char(9) + E_Efternamn) as 'Elev',  (P_Förnamn + char(9) + P_Efternamn) as 'Lärare', (K_Namn) as 'Kurs'  from tblEleverKurser
join tblElever on EK_ElevID = E_ID 
join tblKurser on EK_KursID = K_ID
join tblKurserPersonal on EK_KursID = KP_KursID
join  tblPersonal_ on KP_PersonalID = P_ID
where E_Förnamn = 'Gordon'
order by K_Namn

select (E_Förnamn + char(9) + E_Efternamn) as 'Elev', K_Namn as 'Kurs', EK_Betyg as 'Betyg' from tblEleverKurser
join tblElever on EK_ElevID = E_ID
join tblKurser on EK_KursID = K_ID
where E_Klass_ID = 5
order by E_Efternamn asc

GO


create proc spSkapaElever
@ElevID int, @ElevFörnamn varchar(20), @ElevEfternamn varchar(20), @ElevPersonnummer varchar(20), @ElevKlassID int
as begin
insert into tblElever
(E_ID, E_Förnamn, E_Efternamn, E_Personnummer, E_Klass_ID)
values
(@ElevID, @ElevFörnamn, @ElevEfternamn, @ElevPersonnummer, @ElevKlassID)
END

GO

exec spSkapaElever @ElevID, @ElevFörnamn, @ElevEfternamn, @ElevPersonnummer, @ElevKlassID

--begin try
--  begin transaction
--    update tblPerson set Salary = 45000 where Age > 30
--	  update tblPerson set City = 'Stockholm' where City = 'Borås'
--	  commit transaction
--	Print 'Transaction commited'
--end try

--begin catch
--rollback transaction 
--print 'transaction rolled back'
--end catch