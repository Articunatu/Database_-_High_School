Use HighSchool

select (P_F�rnamn + char(9) + P_Efternamn) as 'L�rare' from tblPersonal_
where P_Arbete = 'L�rare'

select (E_F�rnamn + char(9) + E_Efternamn) as 'Elev' from tblElever
order by E_Efternamn asc

select (E_F�rnamn + char(9) + E_Efternamn) as 'Elev', Kl_KlassNamn as 'Klass' from tblElever
join tblKlasser on Kl_ID = E_Klass_ID 
where Kl_KlassNamn = 'NV21K' /*or KL_ID = 1*/

select count(EK_Betyg) as 'Nya betyg denna m�nad' from tblEleverKurser
where DATEDIFF(DAY, EK_BetygDatum, GETDATE()) < 31;

--select (K_KursNamn) as Kurs, 
--AVG(B_V�rde) as 'Medelbetyg',
--Min(B_V�rde) as 'L�gsta betyg',
--Max(B_V�rde) as 'H�gsta betyg' from tblEleverKurser
--join tblBetyg on B_Bokstav = EK_Betyg or B_Bokstav = null
--join tblKurser on K_ID = EK_KursID
--group by K_KursNamn
--order by K_KursNamn
