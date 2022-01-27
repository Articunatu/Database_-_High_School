Use HighSchool

select (P_F�rnamn + char(9) + P_Efternamn) as 'L�rare' from tblPersonal_
where P_Arbete = 'L�rare'

select * from tblKlasser

select (E_F�rnamn + char(9) + E_Efternamn) as 'Elev' from tblElever
order by E_Efternamn asc

select (E_F�rnamn + char(9) + E_Efternamn) as 'Elev', Kl_KlassNamn as 'Klass' from tblElever
join tblKlasser on Kl_ID = E_Klass_ID 
where KL_ID = 1

select count(EK_Betyg) as 'Nya betyg denna m�nad' from tblEleverKurser ---Should be 2 grades with current table values
where DATEDIFF(DAY, EK_BetygDatum, GETDATE()) <= 31;

GO

create proc spUtvaldPersonal
@ValdKategori varchar(10)
as begin
select (P_F�rnamn + char(9) + P_Efternamn), P_Arbete from tblPersonal_
where P_Arbete = @ValdKategori
END

exec spUtvaldPersonal L�rare

GO

create view vwM�nadensBetyg
as
select (E_F�rnamn + char(9) + E_Efternamn) as 'Elev',  (K_Namn) as 'Kurs', (B_Bokstav) as 'Betyg' from tblEleverKurser
join tblElever on E_ID = EK_ElevID
join tblKurser on K_ID = EK_KursID
join tblBetyg on B_Bokstav = EK_Betyg
where DATEDIFF(DAY, EK_BetygDatum, GETDATE()) <= 31

GO


select * from vwM�nadensBetyg

GO

create view vwBetygStatistik
as
select (K_Namn) as Kurs,
CASE 
WHEN AVG(B_V�rde) = 20 THEN 'A' WHEN AVG(B_V�rde) >= 19.25 THEN 'A-'
WHEN AVG(B_V�rde) >= 18.75 THEN 'B+' WHEN AVG(B_V�rde) >= 17.5 THEN 'B' WHEN AVG(B_V�rde) >= 17 THEN 'B-'
WHEN AVG(B_V�rde) >= 16.5 THEN 'C+' WHEN AVG(B_V�rde) >= 15 THEN 'C' WHEN AVG(B_V�rde) >= 14.5 THEN 'C-'
WHEN AVG(B_V�rde) >= 13.75 THEN 'D+' WHEN AVG(B_V�rde) >= 12.5 THEN 'D' WHEN AVG(B_V�rde) >= 12 THEN 'D-'
WHEN AVG(B_V�rde) >= 11.5 THEN 'E+' WHEN AVG(B_V�rde) >= 10 THEN 'E'
WHEN AVG(B_V�rde) >= 0 THEN 'F'
ELSE '-'
END AS 'Medelbetyg',
CASE 
WHEN MIN(B_V�rde) = 20 THEN 'A'
WHEN MIN(B_V�rde) = 17.5 THEN 'B'
WHEN MIN(B_V�rde) = 15 THEN 'C'
WHEN MIN(B_V�rde) = 12.5 THEN 'D'
WHEN MIN(B_V�rde) = 10 THEN 'E'
WHEN MIN(B_V�rde) = 0 THEN 'F'
ELSE '-'
END AS 'L�gsta betyg',
CASE 
WHEN MAX(B_V�rde) = 20 THEN 'A'
WHEN MAX(B_V�rde) = 17.5 THEN 'B'
WHEN MAX(B_V�rde) = 15 THEN 'C'
WHEN MAX(B_V�rde) = 12.5 THEN 'D'
WHEN MAX(B_V�rde) = 10 THEN 'E'
WHEN MAX(B_V�rde) = 0 THEN 'F'
ELSE '-'
END AS 'H�gsta betyg' from tblEleverKurser
join tblBetyg on B_Bokstav = EK_Betyg or B_Bokstav = null
join tblKurser on K_ID = EK_KursID
group by K_Namn

GO

select * from vwBetygStatistik

select (E_F�rnamn + char(9) + E_Efternamn) as 'Elev',  (P_F�rnamn + char(9) + P_Efternamn) as 'L�rare', (K_Namn) as 'Kurs'  from tblEleverKurser
join tblElever on EK_ElevID = E_ID 
join tblKurser on EK_KursID = K_ID
join tblKurserPersonal on EK_KursID = KP_KursID
join  tblPersonal_ on KP_PersonalID = P_ID
where E_F�rnamn = 'Gordon'
order by K_Namn

select (E_F�rnamn + char(9) + E_Efternamn) as 'Elev', K_Namn as 'Kurs', EK_Betyg as 'Betyg' from tblEleverKurser
join tblElever on EK_ElevID = E_ID
join tblKurser on EK_KursID = K_ID
where E_Klass_ID = 5
order by E_Efternamn asc

GO


create proc spSkapaElever
@ElevID int, @ElevF�rnamn varchar(20), @ElevEfternamn varchar(20), @ElevPersonnummer varchar(20), @ElevKlassID int
as begin
insert into tblElever
(E_ID, E_F�rnamn, E_Efternamn, E_Personnummer, E_Klass_ID)
values
(@ElevID, @ElevF�rnamn, @ElevEfternamn, @ElevPersonnummer, @ElevKlassID)
END

GO

exec spSkapaElever @ElevID, @ElevF�rnamn, @ElevEfternamn, @ElevPersonnummer, @ElevKlassID

--begin try
--  begin transaction
--    update tblPerson set Salary = 45000 where Age > 30
--	  update tblPerson set City = 'Stockholm' where City = 'Bor�s'
--	  commit transaction
--	Print 'Transaction commited'
--end try

--begin catch
--rollback transaction 
--print 'transaction rolled back'
--end catch