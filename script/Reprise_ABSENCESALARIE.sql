USE REPRISE_HRU
Go

--Reprise des absences + CP

DECLARE

@VAR_CMATR char(10),
@VAR_CEMP char(10),
@VAR_PCN_SIREN varchar(35),
@VAR_PCN_ETABLISSEMENT char(3),
@VAR_PCN_SALARIE varchar(10),
@VAR_PCN_DATEDEBUT datetime,
@VAR_PCN_DATEFIN datetime,
@VAR_ORDRE_TEMPORAIRE int,
@VAR_PCN_ORDRE int,
@VAR_PCN_TYPECONGE char(3),
@VAR_PCN_SENSABS char(3),
@VAR_PCN_DATEVALIDITE datetime,
@VAR_PCN_LIBELLE varchar(70),
@VAR_PCN_JOURS real,
@VAR_PCN_HEURES varchar(255),
@VAR_PCN_BASE varchar(255),
@VAR_PCN_DEBUTDJ char(3),
@VAR_PCN_FINDJ char(3),
@VAR_PCN_TRAVAILN1 char(3),
@VAR_PCN_TRAVAILN2 char(3),
@VAR_PCN_TRAVAILN3 char(3),
@VAR_PCN_TRAVAILN4 char(3),
@VAR_PCN_CODESTAT char(3),
@VAR_PCN_TYPEMVT char(3),
@VAR_PCN_PERIODECP char(1),
@VAR_PCN_PERIODEPY char(2),
@VAR_PCN_TYPEIMPUTE char(3),
@VAR_PCN_ETATPOSTPAIE char(3),
@VAR_PCN_GUID varchar(36),
@VAR_PCN_CODETAPE char(1),
@VAR_PCN_NBREMOIS int,
@VAR_LIGNE_ABSENCES_EN_COURS int,
@VAR_LIGNE_TOTAL_ABSENCES int,
@VAR_LIGNE_INDIVIDU_EN_COURS int,
@VAR_LIGNE_TOTAL_INDIVIDUS int,
@VAR_PAR_NBRE_CP_ACQUIS real,
@VAR_NOM_TABLE char(14);

SET @VAR_NOM_TABLE='ABSENCESALARIE';

SELECT @VAR_PAR_NBRE_CP_ACQUIS=CAST(PAR_VALEUR AS real) FROM PARAMETRES WHERE PAR_NOM='Acquis CP';

SET @VAR_PCN_ORDRE=0;
SET @VAR_LIGNE_ABSENCES_EN_COURS=1;
SET @VAR_PCN_ETATPOSTPAIE='VAL';
SELECT @VAR_LIGNE_TOTAL_ABSENCES=COUNT(*) FROM EVENEMENTS;

DECLARE ABSENCES_cursor CURSOR FOR 

SELECT IND_SIREN,IND_MATRICULEHRS,PSA_ETABLISSEMENT,CAST(DBEVT AS datetime) AS DBEVT, CAST(FIEVT AS datetime) AS FIEVT,CAST(FIEVT AS datetime) AS FIEVT,CDMTF
FROM VENTILATION_INDIVIDUS
LEFT JOIN EVENEMENTS ON IND_MATRICULEHRU=MATRI AND IND_CEMP=CEMP
INNER JOIN HR_SPRINT_SALARIES ON IND_MATRICULEHRS=PSA_SALARIE AND IND_SIREN=PSA_SIREN
WHERE DBEVT IS NOT NULL;

OPEN ABSENCES_cursor
FETCH NEXT FROM ABSENCES_cursor
INTO @VAR_PCN_SIREN,@VAR_PCN_SALARIE,@VAR_PCN_ETABLISSEMENT,@VAR_PCN_DATEDEBUT,@VAR_PCN_DATEFIN,@VAR_PCN_DATEVALIDITE,@VAR_PCN_TYPECONGE;

SET @VAR_PCN_TYPEMVT='ABS';
SET @VAR_PCN_SENSABS='-';
SET @VAR_PCN_LIBELLE='Reprise des absences FRH';
SET @VAR_PCN_PERIODECP='';
SET @VAR_PCN_PERIODEPY='';
SET @VAR_PCN_TYPEIMPUTE='';
SET @VAR_PCN_CODETAPE='P';
SET @VAR_PCN_NBREMOIS='0';

WHILE @@FETCH_STATUS = 0

BEGIN

SELECT @VAR_ORDRE_TEMPORAIRE=COUNT(*) FROM HR_SPRINT_ABSENCESALARIE WHERE PCN_SALARIE=@VAR_PCN_SALARIE;--compte le nombre d'absence du salari� d�j� trait�
SET @VAR_PCN_ORDRE=@VAR_ORDRE_TEMPORAIRE+1; --incr�mente le compteur
SET @VAR_PCN_GUID=CONCAT('Reprise FRH absence',@VAR_PCN_SALARIE);

INSERT INTO HR_SPRINT_ABSENCESALARIE
VALUES (@VAR_PCN_SIREN,@VAR_PCN_ETABLISSEMENT,@VAR_PCN_SALARIE,@VAR_PCN_DATEDEBUT,@VAR_PCN_DATEFIN,@VAR_PCN_ORDRE,@VAR_PCN_TYPECONGE,@VAR_PCN_SENSABS,@VAR_PCN_DATEVALIDITE,
@VAR_PCN_LIBELLE,@VAR_PCN_JOURS,@VAR_PCN_HEURES,@VAR_PCN_BASE,@VAR_PCN_DEBUTDJ,@VAR_PCN_FINDJ,@VAR_PCN_TRAVAILN1,@VAR_PCN_TRAVAILN2,@VAR_PCN_TRAVAILN3,@VAR_PCN_TRAVAILN4,@VAR_PCN_TYPEMVT,@VAR_PCN_PERIODECP,@VAR_PCN_PERIODEPY,@VAR_PCN_TYPEIMPUTE,@VAR_PCN_ETATPOSTPAIE,@VAR_PCN_CODETAPE,@VAR_PCN_NBREMOIS,@VAR_PCN_CODESTAT,@VAR_NOM_TABLE,@VAR_PCN_GUID);

FETCH NEXT FROM ABSENCES_cursor
INTO @VAR_PCN_SIREN,@VAR_PCN_SALARIE,@VAR_PCN_ETABLISSEMENT,@VAR_PCN_DATEDEBUT,@VAR_PCN_DATEFIN,@VAR_PCN_DATEVALIDITE,@VAR_PCN_TYPECONGE;

UPDATE VENTILATION_INDIVIDUS SET IND_STATUS='Etape absences', IND_REPRISE_HR_SPRINT_ABSENCESALARIE='X' WHERE IND_MATRICULEHRU=@VAR_CMATR AND IND_SIREN=@VAR_PCN_SIREN;

PRINT 'Création d une absence ligne en cours '+CAST(@VAR_LIGNE_ABSENCES_EN_COURS AS VARCHAR(255))+'/'+CAST(@VAR_LIGNE_TOTAL_ABSENCES AS VARCHAR(255))

SET @VAR_LIGNE_ABSENCES_EN_COURS=@VAR_LIGNE_ABSENCES_EN_COURS+1;

END

CLOSE ABSENCES_cursor;  
DEALLOCATE ABSENCES_cursor;  
 
 --Gestion des CP Acquis N-1

DECLARE CP_ACQUIS_N_cursor CURSOR FOR

SELECT IND_SIREN,IND_MATRICULEHRS,VLRES,BASE,PSA_ETABLISSEMENT FROM COMPTEURS
INNER JOIN ENTETEPAIE ON COMPTEURS.MATRI=ENTETEPAIE.MATRI AND COMPTEURS.CEMP=ENTETEPAIE.CEMP
LEFT JOIN VENTILATION_INDIVIDUS ON COMPTEURS.MATRI=IND_MATRICULEHRU AND IND_CEMP=COMPTEURS.CEMP
LEFT JOIN HR_SPRINT_SALARIES ON IND_MATRICULEHRS=PSA_SALARIE
WHERE CDRG='CPD' AND CDSSR='150' AND NRUB='07020'

OPEN CP_ACQUIS_N_cursor
FETCH NEXT FROM CP_ACQUIS_N_cursor
INTO @VAR_PCN_SIREN,@VAR_PCN_SALARIE,@VAR_PCN_JOURS,@VAR_PCN_BASE,@VAR_PCN_ETABLISSEMENT;

SET @VAR_PCN_SENSABS='+';
SET @VAR_PCN_PERIODECP='1';
SET @VAR_PCN_PERIODEPY='-1';
SET @VAR_PCN_TYPECONGE='REP';
SET @VAR_PCN_TYPEIMPUTE='AC2';
SET @VAR_PCN_CODETAPE='...';
SET @VAR_PCN_LIBELLE='Reprise des données des CP Acquis sur N';
SET @VAR_PCN_DATEVALIDITE='31/05/2020';
SET @VAR_PCN_TYPEMVT='CPA';
SET @VAR_PCN_DATEDEBUT='01/05/2020';
SET @VAR_PCN_DATEFIN='31/05/2020';

WHILE @@FETCH_STATUS = 0

BEGIN

SELECT @VAR_ORDRE_TEMPORAIRE=COUNT(*) FROM HR_SPRINT_ABSENCESALARIE WHERE PCN_SALARIE=@VAR_PCN_SALARIE;--compte le nombre d'absence du salarié déjà traité
SET @VAR_PCN_ORDRE=@VAR_ORDRE_TEMPORAIRE+1; --incrémente le compteur
SET @VAR_PCN_NBREMOIS=@VAR_PCN_JOURS/@VAR_PAR_NBRE_CP_ACQUIS;
IF @VAR_PCN_NBREMOIS>12
BEGIN
	SET @VAR_PCN_NBREMOIS=12;
END
SET @VAR_PCN_GUID=CONCAT('Reprise FRH CP N',@VAR_PCN_SALARIE);

INSERT INTO HR_SPRINT_ABSENCESALARIE
VALUES (@VAR_PCN_SIREN,@VAR_PCN_ETABLISSEMENT,@VAR_PCN_SALARIE,@VAR_PCN_DATEDEBUT,@VAR_PCN_DATEFIN,@VAR_PCN_ORDRE,@VAR_PCN_TYPECONGE,@VAR_PCN_SENSABS,@VAR_PCN_DATEVALIDITE,
@VAR_PCN_LIBELLE,@VAR_PCN_JOURS,@VAR_PCN_HEURES,@VAR_PCN_BASE,@VAR_PCN_DEBUTDJ,@VAR_PCN_FINDJ,@VAR_PCN_TRAVAILN1,@VAR_PCN_TRAVAILN2,@VAR_PCN_TRAVAILN3,@VAR_PCN_TRAVAILN4,@VAR_PCN_TYPEMVT,@VAR_PCN_PERIODECP,@VAR_PCN_PERIODEPY,@VAR_PCN_TYPEIMPUTE,@VAR_PCN_ETATPOSTPAIE,@VAR_PCN_CODETAPE,@VAR_PCN_NBREMOIS,@VAR_PCN_CODESTAT,@VAR_NOM_TABLE,@VAR_PCN_GUID);


FETCH NEXT FROM CP_ACQUIS_N_cursor
INTO @VAR_PCN_SIREN,@VAR_PCN_SALARIE,@VAR_PCN_JOURS,@VAR_PCN_BASE,@VAR_PCN_ETABLISSEMENT;

END

CLOSE CP_ACQUIS_N_cursor;  
DEALLOCATE CP_ACQUIS_N_cursor;  
 
--Gestin des CP PRIS sur N-1

DECLARE CP_PRIS_N_cursor CURSOR FOR

SELECT IND_SIREN,IND_MATRICULEHRS,VLRES,PSA_ETABLISSEMENT FROM COMPTEURS
LEFT JOIN VENTILATION_INDIVIDUS ON COMPTEURS.MATRI=IND_MATRICULEHRU AND IND_CEMP=COMPTEURS.CEMP
LEFT JOIN HR_SPRINT_SALARIES ON IND_MATRICULEHRS=PSA_SALARIE
WHERE CDRG='CPS' AND CDSSR='020' 

OPEN CP_PRIS_N_cursor
FETCH NEXT FROM CP_PRIS_N_cursor
INTO @VAR_PCN_SIREN,@VAR_PCN_SALARIE,@VAR_PCN_JOURS,@VAR_PCN_ETABLISSEMENT;

SET @VAR_PCN_SENSABS='-';
SET @VAR_PCN_PERIODECP='1';
SET @VAR_PCN_PERIODEPY='-1';
SET @VAR_PCN_TYPEIMPUTE='AC2';
SET @VAR_PCN_TYPECONGE='CPA';
SET @VAR_PCN_CODETAPE='P';
SET @VAR_PCN_LIBELLE='Reprise des données des CP Pris sur N';
SET @VAR_PCN_BASE='';
SET @VAR_PCN_DATEVALIDITE='31/05/2020';
SET @VAR_PCN_DATEDEBUT='01/06/2019';
SET @VAR_PCN_DATEFIN='01/06/2019';

WHILE @@FETCH_STATUS = 0

BEGIN

SELECT @VAR_ORDRE_TEMPORAIRE=COUNT(*) FROM HR_SPRINT_ABSENCESALARIE WHERE PCN_SALARIE=@VAR_PCN_SALARIE;--compte le nombre d'absence du salari� d�j� trait�
SET @VAR_PCN_ORDRE=@VAR_ORDRE_TEMPORAIRE+1; --incrémente le compteur
SET @VAR_PCN_NBREMOIS=@VAR_PCN_JOURS/@VAR_PAR_NBRE_CP_ACQUIS;
SET @VAR_PCN_GUID=CONCAT('Reprise FRH CP Pris N',@VAR_PCN_SALARIE);

--@Insertion des CP pris au 31/05/2020
INSERT INTO HR_SPRINT_ABSENCESALARIE
VALUES (@VAR_PCN_SIREN,@VAR_PCN_ETABLISSEMENT,@VAR_PCN_SALARIE,@VAR_PCN_DATEDEBUT,@VAR_PCN_DATEFIN,@VAR_PCN_ORDRE,@VAR_PCN_TYPECONGE,@VAR_PCN_SENSABS,@VAR_PCN_DATEVALIDITE,
@VAR_PCN_LIBELLE,@VAR_PCN_JOURS,@VAR_PCN_HEURES,@VAR_PCN_BASE,@VAR_PCN_DEBUTDJ,@VAR_PCN_FINDJ,@VAR_PCN_TRAVAILN1,@VAR_PCN_TRAVAILN2,@VAR_PCN_TRAVAILN3,@VAR_PCN_TRAVAILN4,@VAR_PCN_TYPEMVT,@VAR_PCN_PERIODECP,@VAR_PCN_PERIODEPY,@VAR_PCN_TYPEIMPUTE,@VAR_PCN_ETATPOSTPAIE,@VAR_PCN_CODETAPE,@VAR_PCN_NBREMOIS,@VAR_PCN_CODESTAT,@VAR_NOM_TABLE,@VAR_PCN_GUID);

FETCH NEXT FROM CP_PRIS_N_cursor
INTO @VAR_PCN_SIREN,@VAR_PCN_SALARIE,@VAR_PCN_JOURS,@VAR_PCN_ETABLISSEMENT;

END

CLOSE CP_PRIS_N_cursor;  
DEALLOCATE CP_PRIS_N_cursor; 

--CP Acquis N1

DECLARE CP_ACQUIS_N1_cursor CURSOR FOR
SELECT IND_SIREN,IND_MATRICULEHRS,VLRES,TAUXS,PSA_ETABLISSEMENT FROM COMPTEURS
INNER JOIN ENTETEPAIE ON COMPTEURS.MATRI=ENTETEPAIE.MATRI AND COMPTEURS.CEMP=ENTETEPAIE.CEMP
LEFT JOIN VENTILATION_INDIVIDUS ON COMPTEURS.MATRI=IND_MATRICULEHRU AND IND_CEMP=COMPTEURS.CEMP
LEFT JOIN HR_SPRINT_SALARIES ON IND_MATRICULEHRS=PSA_SALARIE
WHERE CDRG='CPD' AND CDSSR='300' AND NRUB='07030'

OPEN CP_ACQUIS_N1_cursor
FETCH NEXT FROM CP_ACQUIS_N1_cursor
INTO @VAR_PCN_SIREN,@VAR_PCN_SALARIE,@VAR_PCN_JOURS,@VAR_PCN_BASE,@VAR_PCN_ETABLISSEMENT;

SET @VAR_PCN_SENSABS='+';
SET @VAR_PCN_PERIODECP='';
SET @VAR_PCN_PERIODEPY='-1';
SET @VAR_PCN_TYPEIMPUTE='AC2';
SET @VAR_PCN_TYPECONGE='REP';
SET @VAR_PCN_CODETAPE='....';
SET @VAR_PCN_LIBELLE='Reprise des données des CP Acquis sur N+1';
SET @VAR_PCN_DATEVALIDITE='01/06/2020';
SET @VAR_PCN_DATEDEBUT='01/01/1900';
SET @VAR_PCN_DATEFIN='01/01/1900';

WHILE @@FETCH_STATUS = 0

BEGIN

SELECT @VAR_ORDRE_TEMPORAIRE=COUNT(*) FROM HR_SPRINT_ABSENCESALARIE WHERE PCN_SALARIE=@VAR_PCN_SALARIE;--compte le nombre d'absence du salari� d�j� trait�
SET @VAR_PCN_ORDRE=@VAR_ORDRE_TEMPORAIRE+1; --incrémente le compteur
--Insertion des CP acquis au 01/06/2020
SET @VAR_PCN_NBREMOIS=@VAR_PCN_JOURS/@VAR_PAR_NBRE_CP_ACQUIS;

IF @VAR_PCN_NBREMOIS>12
BEGIN
	SET @VAR_PCN_NBREMOIS=12;
END
SET @VAR_PCN_GUID=CONCAT('Reprise FRH CP Acquis N1',@VAR_PCN_SALARIE);


INSERT INTO HR_SPRINT_ABSENCESALARIE
VALUES (@VAR_PCN_SIREN,@VAR_PCN_ETABLISSEMENT,@VAR_PCN_SALARIE,@VAR_PCN_DATEDEBUT,@VAR_PCN_DATEFIN,@VAR_PCN_ORDRE,@VAR_PCN_TYPECONGE,@VAR_PCN_SENSABS,@VAR_PCN_DATEVALIDITE,
@VAR_PCN_LIBELLE,@VAR_PCN_JOURS,@VAR_PCN_HEURES,@VAR_PCN_BASE,@VAR_PCN_DEBUTDJ,@VAR_PCN_FINDJ,@VAR_PCN_TRAVAILN1,@VAR_PCN_TRAVAILN2,@VAR_PCN_TRAVAILN3,@VAR_PCN_TRAVAILN4,@VAR_PCN_TYPEMVT,@VAR_PCN_PERIODECP,@VAR_PCN_PERIODEPY,@VAR_PCN_TYPEIMPUTE,@VAR_PCN_ETATPOSTPAIE,@VAR_PCN_CODETAPE,@VAR_PCN_NBREMOIS,@VAR_PCN_CODESTAT,@VAR_NOM_TABLE,@VAR_PCN_GUID);

FETCH NEXT FROM CP_ACQUIS_N1_cursor
INTO @VAR_PCN_SIREN,@VAR_PCN_SALARIE,@VAR_PCN_JOURS,@VAR_PCN_BASE,@VAR_PCN_ETABLISSEMENT;

END

CLOSE CP_ACQUIS_N1_cursor;  
DEALLOCATE CP_ACQUIS_N1_cursor; 

--Reprise CP N-2

DECLARE

@VAR_IND_MATRICULEHRU char(10),
@VAR_IND_SIREN char(9),
@VAR_ACQUISN2 real,
@VAR_PRISN2 real,
@VAR_SOLDEN2 real,
@VAR_BASEN2 real;

SET @VAR_PCN_TYPECONGE='AJU';
SET @VAR_PCN_SENSABS='-';
SET @VAR_PCN_PERIODECP='1';
SET @VAR_PCN_PERIODEPY='-1';
SET @VAR_PCN_TYPEIMPUTE='AC2';
SET @VAR_PCN_TYPECONGE='CPA';
SET @VAR_PCN_CODETAPE='P';
SET @VAR_PCN_LIBELLE='Reprise des données des CP solde sur N -2';
SET @VAR_PCN_BASE='';
SET @VAR_PCN_DATEVALIDITE='31/05/2020';
SET @VAR_PCN_DATEDEBUT='01/06/2019';
SET @VAR_PCN_DATEFIN='01/06/2019';

DECLARE SOLDE_CP_N2_cursor CURSOR FOR

SELECT IND_SIREN,IND_MATRICULEHRU,IND_MATRICULEHRS,PSA_ETABLISSEMENT FROM VENTILATION_INDIVIDUS
LEFT JOIN HR_SPRINT_SALARIES ON PSA_SALARIE=IND_MATRICULEHRS AND PSA_SIREN=IND_SIREN;

OPEN SOLDE_CP_N2_cursor
FETCH NEXT FROM SOLDE_CP_N2_cursor
INTO @VAR_PCN_SIREN,@VAR_IND_MATRICULEHRU,@VAR_PCN_SALARIE,@VAR_PCN_ETABLISSEMENT;

WHILE @@FETCH_STATUS = 0

BEGIN

	SELECT @VAR_ACQUISN2=VLRES FROM COMPTEURS WHERE MATRI=@VAR_IND_MATRICULEHRU AND CDRG='CPD' AND CDSSR='050';
	SELECT @VAR_PRISN2=VLRES FROM COMPTEURS WHERE MATRI=@VAR_IND_MATRICULEHRU AND CDRG='CPS' AND CDSSR='010';
	SET @VAR_SOLDEN2=@VAR_ACQUISN2-@VAR_PRISN2;
	
	IF 	@VAR_SOLDEN2>0

	BEGIN--alors solde positif à reprendre
		SELECT @VAR_ORDRE_TEMPORAIRE=COUNT(*) FROM HR_SPRINT_ABSENCESALARIE WHERE PCN_SALARIE=@VAR_PCN_SALARIE;--compte le nombre d'absence du salarié déjà traité
		SET @VAR_PCN_ORDRE=@VAR_ORDRE_TEMPORAIRE+1; --incrémente le compteur
		SET @VAR_PCN_JOURS=@VAR_SOLDEN2;--solde N-2
		SET @VAR_PCN_NBREMOIS=@VAR_PCN_JOURS/@VAR_PAR_NBRE_CP_ACQUIS;
		IF @VAR_PCN_NBREMOIS>12
		BEGIN
			SET @VAR_PCN_NBREMOIS=12;
		END
		SELECT @VAR_BASEN2=TAUXS FROM ENTETEPAIE WHERE MATRI=@VAR_IND_MATRICULEHRU AND NRUB='0701';
		SET @VAR_PCN_BASE=@VAR_BASEN2/@VAR_ACQUISN2*VAR_PCN_JOURS; -- Base 10ème : Base 10ème de l'exercice N-2 / Acquis de l'exercice = prix de journée * le solde des jours CP N-2.
		SET @VAR_PCN_GUID=CONCAT('Reprise FRH CP N-2',@VAR_PCN_SALARIE);

		INSERT INTO HR_SPRINT_ABSENCESALARIE
		VALUES (@VAR_PCN_SIREN,@VAR_PCN_ETABLISSEMENT,@VAR_PCN_SALARIE,@VAR_PCN_DATEDEBUT,@VAR_PCN_DATEFIN,@VAR_PCN_ORDRE,@VAR_PCN_TYPECONGE,@VAR_PCN_SENSABS,@VAR_PCN_DATEVALIDITE,
		@VAR_PCN_LIBELLE,@VAR_PCN_JOURS,@VAR_PCN_HEURES,@VAR_PCN_BASE,@VAR_PCN_DEBUTDJ,@VAR_PCN_FINDJ,@VAR_PCN_TRAVAILN1,@VAR_PCN_TRAVAILN2,@VAR_PCN_TRAVAILN3,@VAR_PCN_TRAVAILN4,@VAR_PCN_TYPEMVT,@VAR_PCN_PERIODECP,@VAR_PCN_PERIODEPY,@VAR_PCN_TYPEIMPUTE,@VAR_PCN_ETATPOSTPAIE,@VAR_PCN_CODETAPE,@VAR_PCN_NBREMOIS,@VAR_PCN_CODESTAT,@VAR_NOM_TABLE,@VAR_PCN_GUID);

	END

	ELSE
	BEGIN
		PRINT 'Matricule '+@VAR_PCN_SALARIE+' Acquis N-2 '+CAST(@VAR_ACQUISN2 as varchar(255))+' Pris N-2 '+CAST(@VAR_PRISN2 as varchar(255)) +' solde = '+CAST(@VAR_SOLDEN2 as varchar(255))
	END

FETCH NEXT FROM SOLDE_CP_N2_cursor
INTO @VAR_PCN_SIREN,@VAR_IND_MATRICULEHRU,@VAR_PCN_SALARIE,@VAR_PCN_ETABLISSEMENT;

END

CLOSE SOLDE_CP_N2_cursor;  
DEALLOCATE SOLDE_CP_N2_cursor;  

Go


--Gestion des zones libres

DECLARE

@VAR_PCN_SIREN varchar(17),
@VAR_PCN_SALARIE varchar(10),
@VAR_PCN_TRAVAILN1 char(3),
@VAR_PCN_TRAVAILN2 char(3),
@VAR_PCN_TRAVAILN3 char(3),
@VAR_PCN_TRAVAILN4 char(3),
@VAR_PCN_CODESTAT char(3);


DECLARE MAJ_ZONES_LIBRES_cursor CURSOR FOR
SELECT PSA_SIREN,PSA_SALARIE,PSA_CODESTAT,PSA_TRAVAILN1,PSA_TRAVAILN2,PSA_TRAVAILN3,PSA_TRAVAILN4 FROM HR_SPRINT_SALARIES;

OPEN MAJ_ZONES_LIBRES_cursor
FETCH NEXT FROM MAJ_ZONES_LIBRES_cursor
INTO @VAR_PCN_SIREN,@VAR_PCN_SALARIE,@VAR_PCN_CODESTAT,@VAR_PCN_TRAVAILN1,@VAR_PCN_TRAVAILN2,@VAR_PCN_TRAVAILN3,@VAR_PCN_TRAVAILN4;

WHILE @@FETCH_STATUS = 0

BEGIN

UPDATE HR_SPRINT_ABSENCESALARIE SET PCN_CODESTAT=@VAR_PCN_CODESTAT,PCN_TRAVAILN1=@VAR_PCN_TRAVAILN1,PCN_TRAVAILN2=@VAR_PCN_TRAVAILN2,PCN_TRAVAILN3=@VAR_PCN_TRAVAILN3,PCN_TRAVAILN4=@VAR_PCN_TRAVAILN4 WHERE PCN_SIREN=@VAR_PCN_SIREN AND PCN_SALARIE=@VAR_PCN_SALARIE

FETCH NEXT FROM MAJ_ZONES_LIBRES_cursor
INTO @VAR_PCN_SIREN,@VAR_PCN_SALARIE,@VAR_PCN_CODESTAT,@VAR_PCN_TRAVAILN1,@VAR_PCN_TRAVAILN2,@VAR_PCN_TRAVAILN3,@VAR_PCN_TRAVAILN4;


END

CLOSE MAJ_ZONES_LIBRES_cursor;  
DEALLOCATE MAJ_ZONES_LIBRES_cursor;  

Print 'Maj des zones libres dans la table ABSENCESALARIE';

--Suppression des valeurs à NULL

UPDATE HR_SPRINT_ABSENCESALARIE SET PCN_JOURS='' WHERE PCN_JOURS IS NULL;
UPDATE HR_SPRINT_ABSENCESALARIE SET PCN_HEURES='' WHERE PCN_HEURES IS NULL;
UPDATE HR_SPRINT_ABSENCESALARIE SET PCN_BASE='' WHERE PCN_BASE IS NULL;
UPDATE HR_SPRINT_ABSENCESALARIE SET PCN_DEBUTDJ='' WHERE PCN_DEBUTDJ IS NULL;
UPDATE HR_SPRINT_ABSENCESALARIE SET PCN_FINDJ='' WHERE PCN_FINDJ IS NULL;
GO

DELETE HR_SPRINT_ABSENCESALARIE where PCN_TYPECONGE<>'REP' AND PCN_TYPECONGE<>'CPA' --suppresion des absences

GO
PRINT 'Fin reprise des absences + CP'
