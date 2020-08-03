USE REPRISE_HRU
GO

--G�n�ration de la table CHOIXCOD et MINIMUMCONVENT � partir de TRANSCO

DECLARE

@VAR_NATURECONTROLE varchar(255),
@VAR_RESULTATCONTROLE varchar(255),
@VAR_COMMENTAIRE varchar(255),
@VAR_LIGNE_TRANSCO int,
@VAR_TOTAL_LIGNE_TRANSCO int,
@VAR_CC_SIREN varchar(35),
@VAR_CC_TYPE char(3),
@VAR_CC_CODE char(3),
@VAR_CC_LIBELLE varchar(35),
@VAR_CC_ABREGE varchar(35),
@VAR_CC_LIBRE varchar(35),
@VAR_TRA_TYPE varchar(35),
@VAR_PMI_SIREN varchar(35),
@VAR_PMI_NATURE char(3),
@VAR_PMI_CONVENTION char(3),
@VAR_PMI_TYPENATURE char(3),
@VAR_PMI_CODE char(3),
@VAR_PMI_LIBELLE varchar(35),
@VAR_PMI_NATUREINT char(3),
@VAR_PMI_NATURERESULT char(3),
@VAR_PMI_SENSINT char(2),
@VAR_PMI_PREDEFINI char(3),
@VAR_PMI_NODOSSIER char(6);


SET @VAR_PMI_TYPENATURE='VAL';
SET @VAR_PMI_CONVENTION='000';
SET @VAR_PMI_PREDEFINI='STD';
SET @VAR_PMI_NODOSSIER='000000';
SET @VAR_RESULTATCONTROLE='Ok'
SET @VAR_NATURECONTROLE='Cr�ation table CHOIXCOD';
SELECT @VAR_LIGNE_TRANSCO=MIN(TRA_ID) FROM TRANSCO;
SELECT @VAR_TOTAL_LIGNE_TRANSCO=MAX(TRA_ID) FROM TRANSCO;

WHILE @VAR_LIGNE_TRANSCO<=@VAR_TOTAL_LIGNE_TRANSCO

BEGIN

SELECT @VAR_TRA_TYPE=TRA_TYPE FROM TRANSCO WHERE TRA_ID=@VAR_LIGNE_TRANSCO;--r�cup�ration du type de reprise
SELECT @VAR_CC_SIREN=TRA_SIREN FROM TRANSCO WHERE TRA_ID=@VAR_LIGNE_TRANSCO;--r�cup�ration du code SIREN de la soci�t�
SET @VAR_PMI_SIREN=@VAR_CC_SIREN;
SELECT @VAR_CC_CODE=TRA_VALEURHRS FROM TRANSCO WHERE TRA_ID=@VAR_LIGNE_TRANSCO;--r�cup�ration du nouveau code
SELECT @VAR_CC_LIBELLE=TRA_VALEURHRU FROM TRANSCO WHERE TRA_ID=@VAR_LIGNE_TRANSCO;--r�cup�ration du libell� ancienne valeur HRU
SELECT @VAR_CC_ABREGE=TRA_VALEURHRU FROM TRANSCO WHERE TRA_ID=@VAR_LIGNE_TRANSCO;--r�cup�ration du libell� ancienne valeur HRU
IF @VAR_TRA_TYPE='Emploi'

	BEGIN

	SET @VAR_CC_TYPE='PLE';

	PRINT 'Cr�ation de la valeur '+@VAR_CC_CODE+' pour le SIREN '+@VAR_CC_SIREN+' ligne en cous '+CAST(@VAR_LIGNE_TRANSCO AS varchar(255))+'/'+CAST(@VAR_TOTAL_LIGNE_TRANSCO AS Varchar(255))

	SET @VAR_COMMENTAIRE='Cr�ation de la valeur '+@VAR_CC_CODE+' pour le SIREN '+@VAR_CC_SIREN+' ligne en cous '+CAST(@VAR_LIGNE_TRANSCO AS varchar(255))+'/'+CAST(@VAR_TOTAL_LIGNE_TRANSCO AS Varchar(255));

	INSERT INTO HR_SPRINT_CHOIXCOD
	VALUES (@VAR_CC_SIREN,@VAR_CC_TYPE,@VAR_CC_CODE,@VAR_CC_LIBELLE,@VAR_CC_ABREGE);

	END

IF @VAR_TRA_TYPE='CTA01'--dans la table PARAMETRES il faut regarder la zone HR SPRINT de destination pour retrouver le CC_TYPE

	BEGIN

	SET @VAR_CC_TYPE=

	CASE

	--CODE STATISTIQUE

	WHEN EXISTS (SELECT * FROM PARAMETRES WHERE PAR_NOM='CODESTAT' AND PAR_VALEUR='CTA01')
		THEN 'PSQ'

	--TravailN1

	WHEN EXISTS (SELECT * FROM PARAMETRES WHERE PAR_NOM='TABLETRAVAILN1' AND PAR_VALEUR='CTA01')
		THEN 'PAG'

	END;

	PRINT 'Cr�ation de la valeur '+@VAR_CC_CODE+' pour le SIREN '+@VAR_CC_SIREN+' ligne en cous '+CAST(@VAR_LIGNE_TRANSCO AS varchar(255))+'/'+CAST(@VAR_TOTAL_LIGNE_TRANSCO AS Varchar(255))

	SET @VAR_COMMENTAIRE='Cr�ation de la valeur '+@VAR_CC_CODE+' pour le SIREN '+@VAR_CC_SIREN+' ligne en cous '+CAST(@VAR_LIGNE_TRANSCO AS varchar(255))+'/'+CAST(@VAR_TOTAL_LIGNE_TRANSCO AS Varchar(255));

	INSERT INTO HR_SPRINT_CHOIXCOD
	VALUES (@VAR_CC_SIREN,@VAR_CC_TYPE,@VAR_CC_CODE,@VAR_CC_LIBELLE,@VAR_CC_ABREGE);


	END

IF @VAR_TRA_TYPE='CTA02'

	BEGIN

	SET @VAR_CC_TYPE=

	CASE

	--CODE STATISTIQUE

	WHEN EXISTS (SELECT * FROM PARAMETRES WHERE PAR_NOM='CODESTAT' AND PAR_VALEUR='CTA02')
		THEN 'PSQ'

	--TravailN1

	WHEN EXISTS (SELECT * FROM PARAMETRES WHERE PAR_NOM='TABLETRAVAILN1' AND PAR_VALEUR='CTA02')
		THEN 'PAG'

	END;

	PRINT 'Cr�ation de la valeur '+@VAR_CC_CODE+' pour le SIREN '+@VAR_CC_SIREN+' ligne en cous '+CAST(@VAR_LIGNE_TRANSCO AS varchar(255))+'/'+CAST(@VAR_TOTAL_LIGNE_TRANSCO AS Varchar(255))

	SET @VAR_COMMENTAIRE='Cr�ation de la valeur '+@VAR_CC_CODE+' pour le SIREN '+@VAR_CC_SIREN+' ligne en cous '+CAST(@VAR_LIGNE_TRANSCO AS varchar(255))+'/'+CAST(@VAR_TOTAL_LIGNE_TRANSCO AS Varchar(255));

	INSERT INTO HR_SPRINT_CHOIXCOD
	VALUES (@VAR_CC_SIREN,@VAR_CC_TYPE,@VAR_CC_CODE,@VAR_CC_LIBELLE,@VAR_CC_ABREGE);


	END

IF @VAR_TRA_TYPE='Coefficient' OR @VAR_TRA_TYPE='Qualification' OR @VAR_TRA_TYPE='Niveau'  --sinon il s'agit d'une qualif/coeff/Niveau
	BEGIN

	IF @VAR_TRA_TYPE='Coefficient'

		BEGIN

		SET @VAR_PMI_NATURE='COE';

		END

	IF @VAR_TRA_TYPE='Qualification'

		BEGIN

		SET @VAR_PMI_NATURE='QUA';

		END

	IF @VAR_TRA_TYPE='Niveau'

		BEGIN

		SET @VAR_PMI_NATURE='NIV';

		END

	SELECT @VAR_PMI_LIBELLE=TRA_VALEURHRU FROM TRANSCO WHERE TRA_ID=@VAR_LIGNE_TRANSCO; 
	SELECT @VAR_PMI_CODE=TRA_VALEURHRS FROM TRANSCO WHERE TRA_ID=@VAR_LIGNE_TRANSCO; 

	INSERT INTO HR_SPRINT_MINIMUMCONVENT
	VALUES (@VAR_PMI_SIREN,@VAR_PMI_NATURE,@VAR_PMI_CONVENTION,@VAR_PMI_TYPENATURE,@VAR_PMI_CODE,@VAR_PMI_LIBELLE,@VAR_PMI_PREDEFINI,@VAR_PMI_NODOSSIER);

	PRINT 'Le type de transco est diff�rent de emploi passage � la ligne suivante ligne en cours '+CAST(@VAR_LIGNE_TRANSCO AS varchar(255))+'/'+CAST(@VAR_TOTAL_LIGNE_TRANSCO AS Varchar(255))

	SET @VAR_COMMENTAIRE='Le type de transco est diff�rent de emploi passage � la ligne suivante ligne en cours '+CAST(@VAR_LIGNE_TRANSCO AS varchar(255))+'/'+CAST(@VAR_TOTAL_LIGNE_TRANSCO AS Varchar(255));

	END

ELSE--il s'agit d'une autre transco

BEGIN

PRINT 'Le type de transco est diff�rent de emploi passage � la ligne suivante ligne en cours '+CAST(@VAR_LIGNE_TRANSCO AS varchar(255))+'/'+CAST(@VAR_TOTAL_LIGNE_TRANSCO AS Varchar(255))

SET @VAR_COMMENTAIRE='Le type de transco est diff�rent de emploi passage � la ligne suivante ligne en cours '+CAST(@VAR_LIGNE_TRANSCO AS varchar(255))+'/'+CAST(@VAR_TOTAL_LIGNE_TRANSCO AS Varchar(255));

END

SET @VAR_LIGNE_TRANSCO=@VAR_LIGNE_TRANSCO+1; 

END

GO

PRINT 'Fin reprise CHOIXCOD et MINIMUMCONVENT'