--Use HighSchool

--select (P_Förnamn + char(9) + P_Efternamn) as 'Lärare' from tblPersonal_
--where P_Arbete = 'Lärare'

--select (E_Förnamn + char(9) + E_Efternamn) as 'Elev' from tblElever
--order by E_Efternamn asc

--select (E_Förnamn + char(9) + E_Efternamn) as 'Elev', Kl_KlassNamn as 'Klass' from tblElever
--join tblKlasser on Kl_ID = E_Klass_ID 
--where E_Klass_ID = 1

--select count(EK_Betyg) as 'Nya betyg i månaden' from tblEleverKurser
--where DATEDIFF(DAY, EK_BetygDatum, GETDATE()) < 31;


--create view MedelBetyg
--as
--select AVG(B_BetygVärde) as 'Medelbetyg' from tblEleverKurser
--join baseGiltigaBetyg on B_BetygBokstav = EK_Betyg

select (K_KursNamn) as Kurs, 
AVG(B_BetygVärde) as 'Medelbetyg',
Min(B_BetygVärde) as 'Lägsta betyg',
Max(B_BetygVärde) as 'Högsta betyg' from tblEleverKurser
join baseGiltigaBetyg on B_BetygBokstav = EK_Betyg or B_BetygBokstav = null
join tblKurser on K_ID = EK_KursID
group by K_KursNamn
order by K_KursNamn
