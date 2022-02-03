
Use HighSchool

select (P_Förnamn + char(9) + P_Efternamn) as 'Personal', P_Arbete as 'Arbetsroll' from tblPersonal_
--where P_Arbete = 'Lärare'

select * from tblKlasser

select (E_Förnamn + char(9) + E_Efternamn) as 'Elev' from tblElever
order by E_Efternamn asc

select (E_Förnamn + char(9) + E_Efternamn) as 'Elev', Kl_KlassNamn as 'Klass' from tblElever
join tblKlasser on Kl_ID = E_Klass_ID 
where KL_ID = 1

select count(EK_Betyg) as 'Nya betyg denna månad' from tblEleverKurser ---Should be 2 grades with current table values
where DATEDIFF(DAY, EK_BetygDatum, GETDATE()) <= 31;

GO

alter proc spUtvaldPersonal
@ValdKategori varchar(20)
with encryption
as 
if (@ValdKategori = 'Inget')
begin
select P_ID, P_Förnamn, P_Efternamn, P_Arbete  from tblPersonal_
end
else
begin
select P_ID, P_Förnamn, P_Efternamn, P_Arbete  from tblPersonal_
where P_Arbete = @ValdKategori 
END

drop proc spUtvaldPersonal
exec spUtvaldPersonal 'SYV'  

GO

alter view vwMånadensBetyg
as
select (E_Förnamn + char(9) + E_Efternamn) as 'Elev',  (K_Namn) as 'Kurs', (B_Bokstav) as 'Betyg', EK_BetygDatum from tblEleverKurser
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

go

create proc spElevsAvslutadeKurser
@ElevID int
as begin
select K_Namn as 'Kurs', EK_Betyg as 'Betyg',
(P_Förnamn + char(9) + P_Efternamn) as 'Lärare', (EK_BetygDatum) as 'Datum'  from tblEleverKurser
join tblElever on EK_ElevID = E_ID 
join tblKurser on EK_KursID = K_ID
join tblKurserPersonal on EK_KursID = KP_KursID
join  tblPersonal_ on KP_PersonalID = P_ID
where EK_Betyg != '-' and
E_ID = 1
order by K_Namn 
end 

exec spElevsAvslutadeKurser 2

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

exec spSkapaElever 121, 'Anders', 'Holm', '20050101-1551', 10

go

alter view vwPersonalInfo 
as
select (P_Förnamn + ' '+ P_Efternamn) as 'Personal', P_Arbete as 'Arbete', P_ÅrAvArbete as 'År på skolan' from tblPersonal_

select * from vwPersonalInfo

GO

create proc spSkapaPersonal
@PersID int, @PersFörnamn varchar(20), @PersEfternamn varchar(20), @PersArbete varchar(20), @PersÅr int, @PersLön int
as begin
insert into tblPersonal_
(P_ID, P_Förnamn, P_Efternamn, P_Arbete, P_ÅrAvArbete, P_Lön)
values
(@PersID, @PersFörnamn, @PersEfternamn, @PersArbete, @PersÅr, @PersLön)
END

GO

alter view vwPersonalMedellön
as
select P_Arbete as 'Avdelning', AVG(P_Lön) as 'Medellön' from tblPersonal_
group by P_Arbete 

select Avdelning, Round(Medellön, 0) from vwPersonalMedellön

go


create proc spEleverInfo
@ElevID int
as begin
select (E_Förnamn + ' ' + E_Efternamn) as 'Elev', E_Personnummer as 'Personnummer' from tblElever
end

go

create proc spBetygSättning
@ElevID int, @ElevKursID int, @ElevBetyg char
as 
begin try
 begin transaction 
  update tblEleverKurser set EK_Betyg = @ElevBetyg 
  where EK_ElevID = @ElevID and EK_KursID = @ElevKursID
 commit transaction
Print 'Betyget har satts!'
end try

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

/*Distinct join
--select a.FirstName, a.LastName, v.District
--from AddTbl a 
--inner join (select distinct LastName, District 
--    from ValTbl) v
--   on a.LastName = v.LastName
--order by Firstname  