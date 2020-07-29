USE REPRISE_HRU
--Reprise des enfants

DECLARE

@VAR_CMATR varchar(35),
@VAR_ENFANT_EN_COURS int,
@VAR_ENFANT_TOTAL int,
@VAR_NBRE_ENFANT_AVANT_INSERT int,
@VAR_PEF_SIREN varchar(35),
@VAR_PEF_SALARIE varchar(10),
@VAR_PEF_ENFANT int,
@VAR_PEF_NOM varchar(35),
@VAR_PEF_PRENOM varchar(35),
@VAR_PEF_DATENAISSANCE date,
@VAR_PEF_ACHARGE char(1),
@VAR_PEF_NATIONALITE char(3),
@VAR_SEXE_TRANSCO char(2),
@VAR_PEF_SEXE char(1),
@VAR_PEF_TYPEPARENTAL char(3),
@VAR_NATURECONTROLE varchar(255),
@VAR_RESULTATCONTROLE varchar(255),
@VAR_COMMENTAIRE varchar(255);

SET @VAR_NBRE_ENFANT_AVANT_INSERT=0;
SET @VAR_ENFANT_EN_COURS=1;
SELECT @VAR_ENFANT_TOTAL=COUNT(*) FROM ENFANTS;
SET @VAR_PEF_TYPEPARENTAL='001';
SET @VAR_PEF_ACHARGE='X';
SET @VAR_PEF_NATIONALITE='FRA';

WHILE @VAR_ENFANT_EN_COURS<=@VAR_ENFANT_TOTAL
BEGIN

SELECT @VAR_CMATR=MATRI FROM ENFANTS WHERE @VAR_ENFANT_EN_COURS=ENFANTS_LIGNE;--r�cup�ration du matricule HRU
SELECT @VAR_PEF_SALARIE=IND_MATRICULEHRS FROM VENTILATION_INDIVIDUS WHERE IND_MATRICULEHRU=@VAR_CMATR; --r�cup�ration du matricule HRS
SELECT @VAR_PEF_SIREN=IND_SIREN FROM VENTILATION_INDIVIDUS WHERE IND_MATRICULEHRU=@VAR_CMATR;--r�cup�ration du SIREN
SELECT @VAR_NBRE_ENFANT_AVANT_INSERT=COUNT(*) FROM HR_SPRINT_ENFANTSALARIE WHERE PEF_SALARIE=@VAR_PEF_SALARIE;--compte le nombre d'enfant avant le prochain INSERT
SET @VAR_PEF_ENFANT=@VAR_NBRE_ENFANT_AVANT_INSERT+1; --incr�mentation du compteur d'enfants
SELECT @VAR_PEF_NOM=NMENF FROM ENFANTS WHERE @VAR_ENFANT_EN_COURS=ENFANTS_LIGNE;--nom de l'enfant
SELECT @VAR_PEF_PRENOM=PRENF FROM ENFANTS WHERE @VAR_ENFANT_EN_COURS=ENFANTS_LIGNE;--pr�nom de l'enfant
SELECT @VAR_PEF_DATENAISSANCE=CAST(DNENF AS datetime) FROM ENFANTS WHERE @VAR_ENFANT_EN_COURS=ENFANTS_LIGNE;--datetime de naissance de l'enfant
SELECT @VAR_SEXE_TRANSCO=SXENF FROM ENFANTS WHERE @VAR_ENFANT_EN_COURS=ENFANTS_LIGNE;--datetime de naissance de l'enfant
IF @VAR_SEXE_TRANSCO='01'
SET @VAR_PEF_SEXE='M';
ELSE 
SET @VAR_PEF_SEXE='F';

INSERT INTO HR_SPRINT_ENFANTSALARIE
VALUES (@VAR_PEF_SIREN,@VAR_PEF_SALARIE,@VAR_PEF_ENFANT,@VAR_PEF_NOM,@VAR_PEF_PRENOM,@VAR_PEF_DATENAISSANCE,@VAR_PEF_ACHARGE,@VAR_PEF_NATIONALITE,@VAR_PEF_SEXE,@VAR_PEF_TYPEPARENTAL);

UPDATE VENTILATION_INDIVIDUS SET IND_STATUS='Etape Enfants', IND_REPRISE_HR_SPRINT_ENFANTSALARIE='X' WHERE IND_MATRICULEHRU=@VAR_CMATR AND IND_SIREN=@VAR_PEF_SIREN; 

Print 'Cr�ation de l enfant num�ro '+CAST(@VAR_PEF_ENFANT AS varchar(255))+@VAR_PEF_NOM+@VAR_PEF_PRENOM+' pour le salari� '+@VAR_PEF_SALARIE+' ligne en cours '+CAST(@VAR_ENFANT_EN_COURS AS varchar(255))+'/'+CAST(@VAR_ENFANT_TOTAL AS varchar(255))
SET @VAR_NBRE_ENFANT_AVANT_INSERT=0;
SET @VAR_PEF_ENFANT=0;
SET @VAR_ENFANT_EN_COURS=@VAR_ENFANT_EN_COURS+1;
END

GO
PRINT 'Fin reprise des enfants'