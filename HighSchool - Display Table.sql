Use HighSchool

select (P_F�rnamn + char(9) + P_Efternamn) as 'L�rare' from tblPersonal_
where P_Arbete = 'L�rare'

select (E_F�rnamn + char(9) + E_Efternamn) as 'Elev' from tblElever
order by E_Efternamn asc

select (E_F�rnamn + char(9) + E_Efternamn) as 'Elev', Kl_KlassNamn as 'Klass' from tblElever
join tblKlasser on Kl_ID = E_Klass_ID 
where Kl_KlassNamn = 'NV21K' ---Or KL_ID = 1

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
select (E_F�rnamn + char(9) + E_Efternamn) as 'Elev',  (K_KursNamn) as 'Kurs', (B_Bokstav) as 'Betyg' from tblEleverKurser
join tblElever on E_ID = EK_ElevID
join tblKurser on K_ID = EK_KursID
join tblBetyg on B_Bokstav = EK_Betyg
where DATEDIFF(DAY, EK_BetygDatum, GETDATE()) <= 31

GO

select * from vwM�nadensBetyg

GO

create view vwBetygStatistik
as
select (K_KursNamn) as Kurs, 
AVG(B_V�rde) as 'Medelbetyg',
Min(B_V�rde) as 'L�gsta betyg',
Max(B_V�rde) as 'H�gsta betyg' from tblEleverKurser
join tblBetyg on B_Bokstav = EK_Betyg or B_Bokstav = null
join tblKurser on K_ID = EK_KursID
group by K_KursNamn
order by K_KursNamn

GO

create proc spSkapaElever
@ElevID int, @ElevF�rnamn varchar

