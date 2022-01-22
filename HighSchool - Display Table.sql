Use HighSchool

select (P_Förnamn + char(9) + P_Efternamn) as 'Lärare' from tblPersonal_
where P_Arbete = 'Lärare'

select (E_Förnamn + char(9) + E_Efternamn) as 'Elev' from tblElever
order by E_Efternamn asc

select (E_Förnamn + char(9) + E_Efternamn) as 'Elev', Kl_KlassNamn as 'Klass' from tblElever
join tblKlasser on Kl_ID = E_Klass_ID 
where Kl_KlassNamn = 'NV21K' ---Or KL_ID = 1

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
select (E_Förnamn + char(9) + E_Efternamn) as 'Elev',  (K_KursNamn) as 'Kurs', (B_Bokstav) as 'Betyg' from tblEleverKurser
join tblElever on E_ID = EK_ElevID
join tblKurser on K_ID = EK_KursID
join tblBetyg on B_Bokstav = EK_Betyg
where DATEDIFF(DAY, EK_BetygDatum, GETDATE()) <= 31

GO

select * from vwMånadensBetyg

GO

create view vwBetygStatistik
as
select (K_KursNamn) as Kurs, 
AVG(B_Värde) as 'Medelbetyg',
Min(B_Värde) as 'Lägsta betyg',
Max(B_Värde) as 'Högsta betyg' from tblEleverKurser
join tblBetyg on B_Bokstav = EK_Betyg or B_Bokstav = null
join tblKurser on K_ID = EK_KursID
group by K_KursNamn
order by K_KursNamn

GO

create proc spSkapaElever
@ElevID int, @ElevFörnamn varchar

