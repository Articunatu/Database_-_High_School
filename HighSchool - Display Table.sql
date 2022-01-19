--select (E_F�rnamn + char(9) + E_Efternamn) as Elev, (K_KursNamn) as Kurs, (EK_Betyg) as Betyg from tblEleverKurser
--join tblElever on E_ID = EK_ElevID
--join tblKurser on K_ID = EK_KursID
--where K_KursNamn = 'Matematik 1c'
--order by E_Efternamn asc

select (P_F�rnamn + char(9) + P_Efternamn) as L�rare from tblPersonal_
where P_Arbete = 'L�rare'

select (E_F�rnamn + char(9) + E_Efternamn) as Elev from tblElever
order by E_Efternamn asc

select (E_F�rnamn + char(9) + E_Efternamn) as Elev, Kl_KlassNamn as Klass from tblElever
join tblKlasser on Kl_ID = E_Klass_ID 
where E_Klass_ID = 1

select count(EK_Betyg) as 'Nya betyg i m�naden' from tblEleverKurser
where DATEDIFF(DAY, EK_BetygDatum, GETDATE()) < 31