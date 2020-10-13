USE REPRISE_HRU

Go



DECLARE 

@VAR_PCV_SIREN varchar(35),
@VAR_PCV_CONVENTION_HRU varchar(255),
@VAR_PCV_CONVENTION varchar(17),--ne peut finir que par 1 ou 3
@VAR_PCV_VALEUR_POSSIBLE char(3),
@VAR_PCV_LIBELLE varchar(60),
@VAR_PCV_PREDEFINI char(3),
@VAR_PCV_NODOSSIER char(6),
@VAR_PCV_IDCC varchar(17);

SET @VAR_PCV_PREDEFINI='STD';
SET @VAR_PCV_NODOSSIER='000000';
SET @VAR_PCV_SIREN='999999999';

DECLARE CCN_cursor CURSOR FOR

--CO_LIBRE=Libell� de la CCN
SELECT RIGHT([CODE CONVENTION],4), CO_LIBRE, ROW_NUMBER() OVER(ORDER BY [CODE CONVENTION] DESC) AS Ligne
FROM CCNEMPLOYEUR
LEFT JOIN CODE_CCN_HR_SPRINT ON CO_ABREGE=RIGHT([CODE CONVENTION],4)--la jointure se fait sur le code IDCC
GROUP BY RIGHT([CODE CONVENTION],4), CO_LIBRE,[CODE CONVENTION]

OPEN CCN_cursor;

FETCH NEXT FROM CCN_cursor
INTO @VAR_PCV_IDCC,@VAR_PCV_LIBELLE,@VAR_PCV_CONVENTION;
 
 --@VAR_PCV_CONVENTION r�cup�re le num�ro de la ligne avec ROW_NUMBER pour ensuite avancer dans la table VALEUR_POSSIBLE_CCN

WHILE @@FETCH_STATUS = 0

BEGIN

	PRINT 'Le code convention est '+@VAR_PCV_IDCC+' le SIREN est '+@VAR_PCV_SIREN+' Le code libell� est '+@VAR_PCV_LIBELLE
	INSERT INTO HR_SPRINT_CONVENTIONCOLL
	VALUES (@VAR_PCV_SIREN,@VAR_PCV_CONVENTION,@VAR_PCV_LIBELLE,@VAR_PCV_PREDEFINI,@VAR_PCV_NODOSSIER,@VAR_PCV_IDCC);

	SELECT @VAR_PCV_VALEUR_POSSIBLE=VAL_CODE FROM VALEUR_POSSIBLE_CCN WHERE VAL_LIGNE=@VAR_PCV_CONVENTION;
	
	UPDATE HR_SPRINT_CONVENTIONCOLL SET PCV_CONVENTION=@VAR_PCV_VALEUR_POSSIBLE WHERE CONV_LIGNE=@VAR_PCV_CONVENTION;--Mise � jour du code pour utiliser un code HRS

	Print @VAR_PCV_VALEUR_POSSIBLE

	FETCH NEXT FROM CCN_cursor
	INTO @VAR_PCV_IDCC,@VAR_PCV_LIBELLE,@VAR_PCV_CONVENTION;
	  	 
END

  
CLOSE CCN_cursor;  
DEALLOCATE CCN_cursor;  
GO  

PRINT 'Fin reprise CCN'