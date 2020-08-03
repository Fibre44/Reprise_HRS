USE REPRISE_HRU

--Cr�ation des libell�s d'emploi/coefficient/qualification/niveau/zones libres
--Les libell�s sont dans la table VALIDCONTRAT il faut lire l'ensemble des lignes et importer dans la table TRANSCO si on ne connait pas la valeur
--Attention les tables libres peuvent etre partag�s donc on utilisera le SIREN 9999999 comme valeur

DECLARE
@VAR_SOCIETE_TOTAL int,
@VAR_SOCIETE_LIGNE int,
@VAR_NATURECONTROLE varchar(255),
@VAR_RESULTATCONTROLE varchar(255),
@VAR_COMMENTAIRE varchar(255),
@VAR_CONTRAT_EN_COURS int,
@VAR_CONTRAT_TOTAL int,
@VAR_EMPLOI_VALEUR_HRU varchar(35),
@VAR_EMPLOI_VALEUR_HRS char(3),--valeur HRS
@VAR_EMPLOI_TEMPORAIRE int, --code de transco
@VAR_EMPLOI_VALEUR_HRU_TRANSCO int,
@VAR_COEFFICIENT_VALEUR_HRU_TRANSCO int,
@VAR_POSITION_VALEUR_HRU_TRANSCO int,
@VAR_NIVEAU_VALEUR_HRU_TRANSCO int,
@VAR_QUALIFICATION_VALEUR_HRU_TRANSCO int,
@VAR_TRANSCO_TYPE varchar(35),
@VAR_TRA_SIREN varchar(35),
@VAR_CEMP_SOCIETE varchar(35),
@VAR_CEMP_SALARIE varchar(35),
@VAR_SALARIE varchar(35),
@VAR_COEFFICIENT_VALEUR_HRU varchar(35),
@VAR_QUALIFICATION_VALEUR_HRU varchar(35),
@VAR_NIVEAU_VALEUR_HRU varchar(35),
@VAR_POSITION_VALEUR_HRU varchar(35),
@VAR_COEFFICIENT_TEMPORAIRE int,
@VAR_COEFFICIENT_VALEUR_HRS char(3),
@VAR_QUALIFICATION_VALEUR_HRS char(3),
@VAR_CTA01_VALEUR_HRU varchar(35),
@VAR_CTA01_VALEUR_HRS varchar(35),
@VAR_CTA01_TEMPORAIRE varchar(35),
@VAR_CTA01_VALEUR_HRU_TRANSCO varchar(35),
@VAR_CTA02_VALEUR_HRU varchar(35),
@VAR_CTA02_VALEUR_HRS varchar(35),
@VAR_CTA02_TEMPORAIRE varchar(35),
@VAR_CTA02_VALEUR_HRU_TRANSCO varchar(35),
@VAR_PAR_PLE_PARTAGE char(1),
@VAR_PAR_TABLE_LIBRE_PARTAGE char(1),
@VAR_NIVEAU_VALEUR_HRS char(3);

SET @VAR_EMPLOI_TEMPORAIRE=0;
SELECT @VAR_SOCIETE_TOTAL=COUNT(*) FROM EMPLOYEUR;--nombre de soci�t�s � traiter
SELECT @VAR_CONTRAT_TOTAL=COUNT(*) FROM VALIDCONTRAT;--total contrat � traiter
SET @VAR_SOCIETE_LIGNE=1;
SET @VAR_CONTRAT_EN_COURS=1;

SELECT @VAR_PAR_PLE_PARTAGE=PAR_VALEUR FROM PARAMETRES WHERE PAR_NOM='Partage PLE';
SELECT @VAR_PAR_TABLE_LIBRE_PARTAGE=PAR_VALEUR FROM PARAMETRES WHERE PAR_NOM='Partage Table libre';

WHILE @VAR_CONTRAT_EN_COURS<=@VAR_CONTRAT_TOTAL--boucle par contrat
	
BEGIN 

	SELECT @VAR_SALARIE=MATRI FROM VALIDCONTRAT WHERE VALIDCONTRAT_LIGNE=@VAR_CONTRAT_EN_COURS;--r�cup�ration du code matricule salari�
	SELECT @VAR_CEMP_SALARIE=CEMP FROM VALIDCONTRAT WHERE VALIDCONTRAT_LIGNE=@VAR_CONTRAT_EN_COURS;--r�cup�ration CEMP SALARIE
	SELECT @VAR_EMPLOI_VALEUR_HRU=LQUAL FROM VALIDCONTRAT WHERE VALIDCONTRAT_LIGNE=@VAR_CONTRAT_EN_COURS; -- r�cup�ration du libell� emploi sur le contrat en cours
	SELECT @VAR_COEFFICIENT_VALEUR_HRU=COFFI FROM VALIDCONTRAT WHERE VALIDCONTRAT_LIGNE=@VAR_CONTRAT_EN_COURS;--r�cup�ration du coefficient
	SELECT @VAR_POSITION_VALEUR_HRU=POSIT FROM VALIDCONTRAT WHERE VALIDCONTRAT_LIGNE=@VAR_CONTRAT_EN_COURS; --r�cup�ration de la position
	SELECT @VAR_QUALIFICATION_VALEUR_HRU=QUALI FROM VALIDCONTRAT WHERE VALIDCONTRAT_LIGNE=@VAR_CONTRAT_EN_COURS;--r�cup�ration de la qualification
	SELECT @VAR_NIVEAU_VALEUR_HRU=NIVEA FROM VALIDCONTRAT WHERE VALIDCONTRAT_LIGNE=@VAR_CONTRAT_EN_COURS;--r�cup�ration de la qualification
	SELECT @VAR_TRA_SIREN=Siren FROM EMPLOYEUR WHERE Employeur=@VAR_CEMP_SALARIE; --r�cup�ration du SIREN du contrat
	IF @VAR_PAR_PLE_PARTAGE='X' -- si on partage les libell�s d'emploi 
	BEGIN
		SET @VAR_TRA_SIREN='999999999'
		SELECT @VAR_EMPLOI_VALEUR_HRU_TRANSCO=COUNT(*) FROM TRANSCO WHERE TRA_VALEURHRU=@VAR_EMPLOI_VALEUR_HRU AND TRA_SIREN=@VAR_TRA_SIREN; --test si la valeur existe d�j�
		Print 'Attention client en mode partage des libell�s d emploi'
	END
	ELSE--si on ne partage pas les libell�s d'emploi
	BEGIN
			SELECT @VAR_EMPLOI_VALEUR_HRU_TRANSCO=COUNT(*) FROM TRANSCO WHERE TRA_VALEURHRU=@VAR_EMPLOI_VALEUR_HRU AND TRA_SIREN=@VAR_TRA_SIREN; --test si la valeur existe d�j�
	END
	
	SELECT @VAR_COEFFICIENT_VALEUR_HRU_TRANSCO=COUNT(*) FROM TRANSCO WHERE TRA_VALEURHRU=@VAR_COEFFICIENT_VALEUR_HRU AND TRA_SIREN=@VAR_TRA_SIREN;
	SELECT @VAR_QUALIFICATION_VALEUR_HRU_TRANSCO=COUNT(*) FROM TRANSCO WHERE TRA_VALEURHRU=@VAR_QUALIFICATION_VALEUR_HRU AND TRA_SIREN=@VAR_TRA_SIREN;
	SELECT @VAR_CEMP_SALARIE=CEMP FROM VALIDCONTRAT WHERE VALIDCONTRAT_LIGNE=@VAR_CONTRAT_EN_COURS;--r�cup�ration de l'employeur du contrat
	IF @VAR_PAR_TABLE_LIBRE_PARTAGE='X' --si on partage les tables
	BEGIN
		SELECT @VAR_CTA01_VALEUR_HRU=CTA01 FROM VALIDCONTRAT WHERE VALIDCONTRAT_LIGNE=@VAR_CONTRAT_EN_COURS;--r�cup�ration du code stat
		SELECT @VAR_CTA01_VALEUR_HRU_TRANSCO=COUNT(*) FROM TRANSCO WHERE TRA_VALEURHRU=@VAR_CTA01_VALEUR_HRU; --test si le code stat existe
		SELECT @VAR_CTA02_VALEUR_HRU=CTA02 FROM VALIDCONTRAT WHERE VALIDCONTRAT_LIGNE=@VAR_CONTRAT_EN_COURS;--r�cup�ration du code travail n1
		SELECT @VAR_CTA02_VALEUR_HRU_TRANSCO=COUNT(*) FROM TRANSCO WHERE TRA_VALEURHRU=@VAR_CTA02_VALEUR_HRU;--controle si la valeur existe
		Print 'Attention client en mode partage des tables libres'

	END

	ELSE 

	BEGIN
	SELECT @VAR_CTA01_VALEUR_HRU=CTA01 FROM VALIDCONTRAT WHERE VALIDCONTRAT_LIGNE=@VAR_CONTRAT_EN_COURS;--r�cup�ration du code stat
		SELECT @VAR_CTA01_VALEUR_HRU_TRANSCO=COUNT(*) FROM TRANSCO WHERE TRA_VALEURHRU=@VAR_CTA01_VALEUR_HRU AND TRA_SIREN=@VAR_TRA_SIREN; --test si le code stat existe
		SELECT @VAR_CTA02_VALEUR_HRU=CTA02 FROM VALIDCONTRAT WHERE VALIDCONTRAT_LIGNE=@VAR_CONTRAT_EN_COURS;--r�cup�ration du code travail n1
		SELECT @VAR_CTA02_VALEUR_HRU_TRANSCO=COUNT(*) FROM TRANSCO WHERE TRA_VALEURHRU=@VAR_CTA02_VALEUR_HRU AND TRA_SIREN=@VAR_TRA_SIREN;--controle si la valeur existe

	END
	--libell� emploi

		IF @VAR_EMPLOI_VALEUR_HRU_TRANSCO=0 --Ajout d'un nouveau code emploi

		BEGIN
						
			SET @VAR_TRANSCO_TYPE='Emploi';
			SET @VAR_NATURECONTROLE='Transco emploi';
			SET @VAR_RESULTATCONTROLE='Ok';

			SELECT @VAR_EMPLOI_TEMPORAIRE=COUNT(*) FROM TRANSCO WHERE TRA_TYPE='Emploi' AND TRA_SIREN=@VAR_TRA_SIREN;

			SET @VAR_EMPLOI_TEMPORAIRE=@VAR_EMPLOI_TEMPORAIRE+1;--incr�mentation du code
	
			IF @VAR_EMPLOI_TEMPORAIRE<10 --ajout des 0
			
			BEGIN
				SET @VAR_EMPLOI_VALEUR_HRS=CONCAT('00',CAST(@VAR_EMPLOI_TEMPORAIRE AS char(3)));--passage au format texte
			END

			IF @VAR_EMPLOI_TEMPORAIRE>10 AND @VAR_EMPLOI_TEMPORAIRE<100 

			BEGIN
				SET @VAR_EMPLOI_VALEUR_HRS=CONCAT('0',CAST(@VAR_EMPLOI_TEMPORAIRE AS char(3)));--passage au format texte
			END
		
			IF @VAR_EMPLOI_TEMPORAIRE>100 

			BEGIN
				SET @VAR_EMPLOI_VALEUR_HRS=CAST(@VAR_EMPLOI_TEMPORAIRE AS char(3));--passage au format texte
			END
				

			INSERT INTO TRANSCO
			VALUES (@VAR_TRANSCO_TYPE,@VAR_EMPLOI_VALEUR_HRU,@VAR_EMPLOI_VALEUR_HRS,@VAR_TRA_SIREN);

			PRINT 'Le libell� emploi de HRU '+@VAR_EMPLOI_VALEUR_HRU+' devient le code '+@VAR_EMPLOI_VALEUR_HRS+' contrat en cours '+CAST(@VAR_CONTRAT_EN_COURS AS varchar(255))+'/'+CAST(@VAR_CONTRAT_TOTAL AS VARCHAR(255))
			SET @VAR_COMMENTAIRE='Le libell� emploi de HRU '+@VAR_EMPLOI_VALEUR_HRU+' devient le code '+@VAR_EMPLOI_VALEUR_HRS+' contrat en cours '+CAST(@VAR_CONTRAT_EN_COURS AS varchar(255))+'/'+CAST(@VAR_CONTRAT_TOTAL AS VARCHAR(255));
	
		END

		ELSE --si le libell� d'emploi existe d�j�

		BEGIN

			SET @VAR_TRANSCO_TYPE='Emploi';
			SET @VAR_NATURECONTROLE='Transco emploi';
			SET @VAR_RESULTATCONTROLE='Ok';

			PRINT 'Le libell� emploi de HRU '+@VAR_EMPLOI_VALEUR_HRU+' a d�j� �t� trait� contrat en cours '+CAST(@VAR_CONTRAT_EN_COURS AS varchar(255))+'/'+CAST(@VAR_CONTRAT_TOTAL AS VARCHAR(255)) 
	
		END
		
	--Gestion du CTA01
	
	IF @VAR_CTA01_VALEUR_HRU_TRANSCO=0 --Ajout d'un nouveau code emploi

		BEGIN
						
			SET @VAR_TRANSCO_TYPE='CTA01';
			SET @VAR_NATURECONTROLE='Transco CTA01';
			SET @VAR_RESULTATCONTROLE='Ok';

			SELECT @VAR_CTA01_TEMPORAIRE=COUNT(*) FROM TRANSCO WHERE TRA_TYPE='CTA01' AND TRA_SIREN=@VAR_TRA_SIREN;

			SET @VAR_CTA01_TEMPORAIRE=@VAR_CTA01_TEMPORAIRE+1;--incr�mentation du code
	
			IF @VAR_CTA01_TEMPORAIRE<10 --ajout des 0
			
			BEGIN
				SET @VAR_CTA01_VALEUR_HRS=CONCAT('00',CAST(@VAR_CTA01_TEMPORAIRE AS char(3)));--passage au format texte
			END

			IF @VAR_CTA01_TEMPORAIRE>10 AND @VAR_EMPLOI_TEMPORAIRE<100 

			BEGIN
				SET @VAR_CTA01_VALEUR_HRS=CONCAT('0',CAST(@VAR_CTA01_TEMPORAIRE AS char(3)));--passage au format texte
			END
		
			IF @VAR_CTA01_TEMPORAIRE>100 

			BEGIN
				SET @VAR_CTA01_VALEUR_HRS=CAST(@VAR_CTA01_TEMPORAIRE AS char(3));--passage au format texte
			END
				

			INSERT INTO TRANSCO
			VALUES (@VAR_TRANSCO_TYPE,@VAR_CTA01_VALEUR_HRU,@VAR_CTA01_VALEUR_HRS,@VAR_TRA_SIREN);

			PRINT 'Le code CTA01 de HRU '+@VAR_CTA01_VALEUR_HRU+' devient le code '+@VAR_CTA01_VALEUR_HRS+' contrat en cours '+CAST(@VAR_CONTRAT_EN_COURS AS varchar(255))+'/'+CAST(@VAR_CONTRAT_TOTAL AS VARCHAR(255))
			SET @VAR_COMMENTAIRE='Le code CTA01 de HRU '+@VAR_CTA01_VALEUR_HRU+' devient le code '+@VAR_CTA01_VALEUR_HRS+' contrat en cours '+CAST(@VAR_CONTRAT_EN_COURS AS varchar(255))+'/'+CAST(@VAR_CONTRAT_TOTAL AS VARCHAR(255));
	
		END

		ELSE --si le CTA01 existe

		BEGIN

			SET @VAR_TRANSCO_TYPE='CTA01';
			SET @VAR_NATURECONTROLE='Transco CTA01';
			SET @VAR_RESULTATCONTROLE='Ok';

			PRINT 'Le code CTA01 '+@VAR_CTA01_VALEUR_HRU+' a d�j� �t� trait� contrat en cours '+CAST(@VAR_CONTRAT_EN_COURS AS varchar(255))+'/'+CAST(@VAR_CONTRAT_TOTAL AS VARCHAR(255)) 

		END
		
	--Gestion du code CTA02
	
	IF @VAR_CTA02_VALEUR_HRU_TRANSCO=0 --Ajout d'un nouveau code emploi

		BEGIN
						
			SET @VAR_TRANSCO_TYPE='CTA02';
			SET @VAR_NATURECONTROLE='Transco travail CTA02';
			SET @VAR_RESULTATCONTROLE='Ok';

			SELECT @VAR_CTA02_TEMPORAIRE=COUNT(*) FROM TRANSCO WHERE TRA_TYPE='CTA02' AND TRA_SIREN=@VAR_TRA_SIREN;

			SET @VAR_CTA02_TEMPORAIRE=@VAR_CTA02_TEMPORAIRE+1;--incr�mentation du code
	
			IF @VAR_CTA02_TEMPORAIRE<10 --ajout des 0
			
			BEGIN
				SET @VAR_CTA02_VALEUR_HRS=CONCAT('00',CAST(@VAR_CTA02_TEMPORAIRE AS char(3)));--passage au format texte
			END

			IF @VAR_CTA02_TEMPORAIRE>10 AND @VAR_EMPLOI_TEMPORAIRE<100 

			BEGIN
				SET @VAR_CTA02_VALEUR_HRS=CONCAT('0',CAST(@VAR_CTA02_TEMPORAIRE AS char(3)));--passage au format texte
			END
		
			IF @VAR_CTA02_TEMPORAIRE>100 

			BEGIN
				SET @VAR_CTA02_VALEUR_HRS=CAST(@VAR_CTA02_TEMPORAIRE AS char(3));--passage au format texte
			END
				

			INSERT INTO TRANSCO
			VALUES (@VAR_TRANSCO_TYPE,@VAR_CTA02_VALEUR_HRU,@VAR_CTA02_VALEUR_HRS,@VAR_TRA_SIREN);

			PRINT 'Le code CTA02 de HRU '+@VAR_CTA02_VALEUR_HRU+' devient le code '+@VAR_CTA02_VALEUR_HRS+' contrat en cours '+CAST(@VAR_CONTRAT_EN_COURS AS varchar(255))+'/'+CAST(@VAR_CONTRAT_TOTAL AS VARCHAR(255))
			SET @VAR_COMMENTAIRE='Le code CTA02 de HRU '+@VAR_CTA02_VALEUR_HRU+' devient le code '+@VAR_CTA02_VALEUR_HRS+' contrat en cours '+CAST(@VAR_CONTRAT_EN_COURS AS varchar(255))+'/'+CAST(@VAR_CONTRAT_TOTAL AS VARCHAR(255));
	
		END

		ELSE --si le code CTA02 existe d�j�

		BEGIN

			SET @VAR_TRANSCO_TYPE='CTA02';
			SET @VAR_NATURECONTROLE='Transco CTA02';
			SET @VAR_RESULTATCONTROLE='Ok';

			PRINT 'Le code CTA02 de HRU '+@VAR_CTA02_VALEUR_HRU+' a d�j� �t� trait� contrat en cours '+CAST(@VAR_CONTRAT_EN_COURS AS varchar(255))+'/'+CAST(@VAR_CONTRAT_TOTAL AS VARCHAR(255)) 
		END
		
		SET @VAR_CONTRAT_EN_COURS=@VAR_CONTRAT_EN_COURS+1;--incr�mentation du compteur
	END--fin de boucle par contrat sur la soci�t� en cours

GO

--Reprise des classifications

DECLARE

@VAR_PMI_SIREN varchar(35),
@VAR_PMI_NATURE char(3),
@VAR_PMI_CONVENTION char(3),
@VAR_PMI_TYPENATURE char(3),
@VAR_PMI_CODE varchar(17),
@VAR_PMI_LIBELLE varchar(35),
@VAR_PMI_PREDEFINI char(3),
@VARPMI_NODOSSIER char(6),
@VAR_IDCC char(4),
@VAR_TOTAL_LIGNES_CLASSIF_1 int,
@VAR_TOTAL_LIGNES_CLASSIF_2 int,
@VAR_TOTAL_LIGNES_CLASSIF_3 int,
@VAR_TOTAL_LIGNES_CLASSIF_4 int,
@VAR_TOTAL_LIGNES_CLASSIF_5 int,
@VAR_LIGNE_EN_COURS_CLASSIF_1 int,
@VAR_LIGNE_EN_COURS_CLASSIF_2 int,
@VAR_LIGNE_EN_COURS_CLASSIF_3 int,
@VAR_LIGNE_EN_COURS_CLASSIF_4 int,
@VAR_LIGNE_EN_COURS_CLASSIF_5 int;

SET @VAR_LIGNE_EN_COURS_CLASSIF_1=1;
SET @VAR_LIGNE_EN_COURS_CLASSIF_2=1;
SET @VAR_LIGNE_EN_COURS_CLASSIF_3=1;
SET @VAR_LIGNE_EN_COURS_CLASSIF_4=1;
SET @VAR_LIGNE_EN_COURS_CLASSIF_5=1;

SELECT @VAR_TOTAL_LIGNES_CLASSIF_1=COUNT(*) FROM TRSCLASSIFICATION1;
SELECT @VAR_TOTAL_LIGNES_CLASSIF_3=COUNT(*) FROM TRSCLASSIFICATION3;
SELECT @VAR_TOTAL_LIGNES_CLASSIF_4=COUNT(*) FROM TRSCLASSIFICATION4;
SELECT @VAR_TOTAL_LIGNES_CLASSIF_5=COUNT(*) FROM TRSCLASSIFICATION5;

SET @VAR_PMI_SIREN='999999999';

--Classification 1 =Qualification

WHILE @VAR_LIGNE_EN_COURS_CLASSIF_1<=@VAR_TOTAL_LIGNES_CLASSIF_1

BEGIN


SET @VAR_PMI_NATURE='QUA';
SELECT @VAR_IDCC=LEFT(CLASSIF1,4) FROM TRSCLASSIFICATION1 WHERE TRSCLASSIFICATION1_LIGNE=@VAR_LIGNE_EN_COURS_CLASSIF_1;
SELECT @VAR_PMI_CONVENTION=PCV_CONVENTION FROM HR_SPRINT_CONVENTIONCOLL WHERE PCV_IDCC=@VAR_IDCC;
SET @VAR_PMI_TYPENATURE='VAL'
SELECT @VAR_PMI_CODE=RUBCHRU FROM TRSCLASSIFICATION1 WHERE TRSCLASSIFICATION1_LIGNE=@VAR_LIGNE_EN_COURS_CLASSIF_1;
SELECT @VAR_PMI_LIBELLE=RUBCHRU FROM TRSCLASSIFICATION1 WHERE TRSCLASSIFICATION1_LIGNE=@VAR_LIGNE_EN_COURS_CLASSIF_1;

SET @VAR_PMI_PREDEFINI='STD';
SET @VARPMI_NODOSSIER='000000';

INSERT INTO HR_SPRINT_MINIMUMCONVENT
VALUES (@VAR_PMI_SIREN,@VAR_PMI_NATURE,@VAR_PMI_CONVENTION,@VAR_PMI_TYPENATURE,@VAR_PMI_CODE,@VAR_PMI_LIBELLE,@VAR_PMI_PREDEFINI,@VARPMI_NODOSSIER);

Print 'Cr�ation de la qualification'+@VAR_PMI_LIBELLE+' sur la convention IDCC '+@VAR_PMI_CONVENTION+' ligne en cours '+cast(@VAR_LIGNE_EN_COURS_CLASSIF_1 as varchar(255))+'/'+cast(@VAR_TOTAL_LIGNES_CLASSIF_1 as varchar(255))

SET @VAR_LIGNE_EN_COURS_CLASSIF_1=@VAR_LIGNE_EN_COURS_CLASSIF_1+1;

END

--Classification 3 =Coefficient

WHILE @VAR_LIGNE_EN_COURS_CLASSIF_3<=@VAR_TOTAL_LIGNES_CLASSIF_3

BEGIN


SET @VAR_PMI_NATURE='COE';

SELECT @VAR_IDCC=LEFT(CLASSIF3,4) FROM TRSCLASSIFICATION3 WHERE TRSCLASSIFICATION3_LIGNE=@VAR_LIGNE_EN_COURS_CLASSIF_3;
SELECT @VAR_PMI_CONVENTION=PCV_CONVENTION FROM HR_SPRINT_CONVENTIONCOLL WHERE PCV_IDCC=@VAR_IDCC;SET @VAR_PMI_TYPENATURE='VAL'
SELECT @VAR_PMI_CODE=RUBCHRU FROM TRSCLASSIFICATION3 WHERE TRSCLASSIFICATION3_LIGNE=@VAR_LIGNE_EN_COURS_CLASSIF_3;
SELECT @VAR_PMI_LIBELLE=RUBCHRU FROM TRSCLASSIFICATION3 WHERE TRSCLASSIFICATION3_LIGNE=@VAR_LIGNE_EN_COURS_CLASSIF_3;

SET @VAR_PMI_PREDEFINI='STD';
SET @VARPMI_NODOSSIER='000000';

INSERT INTO HR_SPRINT_MINIMUMCONVENT
VALUES (@VAR_PMI_SIREN,@VAR_PMI_NATURE,@VAR_PMI_CONVENTION,@VAR_PMI_TYPENATURE,@VAR_PMI_CODE,@VAR_PMI_LIBELLE,@VAR_PMI_PREDEFINI,@VARPMI_NODOSSIER);

Print 'Cr�ation du coefficient '+@VAR_PMI_LIBELLE+' sur la convention IDCC '+@VAR_PMI_CONVENTION+' ligne en cours '+cast(@VAR_LIGNE_EN_COURS_CLASSIF_3 as varchar(255))+'/'+cast(@VAR_TOTAL_LIGNES_CLASSIF_3 as varchar(255))

SET @VAR_LIGNE_EN_COURS_CLASSIF_3=@VAR_LIGNE_EN_COURS_CLASSIF_3+1;

END

--Classification 4 =Niveau

WHILE @VAR_LIGNE_EN_COURS_CLASSIF_4<=@VAR_TOTAL_LIGNES_CLASSIF_4

BEGIN


SET @VAR_PMI_NATURE='NIV';
SELECT @VAR_IDCC=LEFT(CLASSIF4,4) FROM TRSCLASSIFICATION4 WHERE TRSCLASSIFICATION4_LIGNE=@VAR_LIGNE_EN_COURS_CLASSIF_4;
SELECT @VAR_PMI_CONVENTION=PCV_CONVENTION FROM HR_SPRINT_CONVENTIONCOLL WHERE PCV_IDCC=@VAR_IDCC;SET @VAR_PMI_TYPENATURE='VAL'SET @VAR_PMI_TYPENATURE='VAL'
SELECT @VAR_PMI_CODE=RUBCHRU FROM TRSCLASSIFICATION4 WHERE TRSCLASSIFICATION4_LIGNE=@VAR_LIGNE_EN_COURS_CLASSIF_4;
SELECT @VAR_PMI_LIBELLE=RUBCHRU FROM TRSCLASSIFICATION4 WHERE TRSCLASSIFICATION4_LIGNE=@VAR_LIGNE_EN_COURS_CLASSIF_4;

SET @VAR_PMI_PREDEFINI='STD';
SET @VARPMI_NODOSSIER='000000';

INSERT INTO HR_SPRINT_MINIMUMCONVENT
VALUES (@VAR_PMI_SIREN,@VAR_PMI_NATURE,@VAR_PMI_CONVENTION,@VAR_PMI_TYPENATURE,@VAR_PMI_CODE,@VAR_PMI_LIBELLE,@VAR_PMI_PREDEFINI,@VARPMI_NODOSSIER);

Print 'Cr�ation du niveau '+@VAR_PMI_LIBELLE+' sur la convention IDCC '+@VAR_PMI_CONVENTION+' ligne en cours '+cast(@VAR_LIGNE_EN_COURS_CLASSIF_4 as varchar(255))+'/'+cast(@VAR_TOTAL_LIGNES_CLASSIF_4 as varchar(255))

SET @VAR_LIGNE_EN_COURS_CLASSIF_4=@VAR_LIGNE_EN_COURS_CLASSIF_4+1;

END

--Classification 5 =Echelon 

WHILE @VAR_LIGNE_EN_COURS_CLASSIF_5<=@VAR_TOTAL_LIGNES_CLASSIF_5

BEGIN


SET @VAR_PMI_NATURE='IND';
SELECT @VAR_IDCC=LEFT(CLASSIF5,4) FROM TRSCLASSIFICATION5 WHERE TRSCLASSIFICATION5_LIGNE=@VAR_LIGNE_EN_COURS_CLASSIF_5;
SELECT @VAR_PMI_CONVENTION=PCV_CONVENTION FROM HR_SPRINT_CONVENTIONCOLL WHERE PCV_IDCC=@VAR_IDCC;SET @VAR_PMI_TYPENATURE='VAL'SET @VAR_PMI_TYPENATURE='VAL'SET @VAR_PMI_TYPENATURE='VAL'
SELECT @VAR_PMI_CODE=RUBCHRU FROM TRSCLASSIFICATION5 WHERE TRSCLASSIFICATION5_LIGNE=@VAR_LIGNE_EN_COURS_CLASSIF_5;
SELECT @VAR_PMI_LIBELLE=RUBCHRU FROM TRSCLASSIFICATION5 WHERE TRSCLASSIFICATION5_LIGNE=@VAR_LIGNE_EN_COURS_CLASSIF_5;

SET @VAR_PMI_PREDEFINI='STD';
SET @VARPMI_NODOSSIER='000000';

INSERT INTO HR_SPRINT_MINIMUMCONVENT
VALUES (@VAR_PMI_SIREN,@VAR_PMI_NATURE,@VAR_PMI_CONVENTION,@VAR_PMI_TYPENATURE,@VAR_PMI_CODE,@VAR_PMI_LIBELLE,@VAR_PMI_PREDEFINI,@VARPMI_NODOSSIER);

Print 'Cr�ation de l indice '+@VAR_PMI_LIBELLE+' sur la convention IDCC '+@VAR_PMI_CONVENTION+' ligne en cours '+cast(@VAR_LIGNE_EN_COURS_CLASSIF_5 as varchar(255))+'/'+cast(@VAR_TOTAL_LIGNES_CLASSIF_5 as varchar(255))

SET @VAR_LIGNE_EN_COURS_CLASSIF_5=@VAR_LIGNE_EN_COURS_CLASSIF_5+1;

END

GO

DECLARE 

@VAR_AUXI_LONGUEUR int,
@VAR_AUXI_PREFIXE varchar(35),
@VAR_AUXI_PREFIXE_LONGUEUR int,
@VAR_MATRICULE_LONGUEUR int,
@VAR_MATRICUE_RIGHT int;

SELECT @VAR_AUXI_LONGUEUR=CAST(PAR_VALEUR AS int) FROM PARAMETRES WHERE PAR_NOM LIKE 'AUXI_LONGUEUR'; --r�cup�ration de la longueur des comptes auxiliaire
SELECT @VAR_AUXI_PREFIXE=PAR_VALEUR FROM PARAMETRES WHERE PAR_NOM LIKE 'AUXI_PREFIXE'; --r�cup�ration du prefixe
SET @VAR_AUXI_PREFIXE_LONGUEUR=LEN(@VAR_AUXI_PREFIXE)--nbre de caract�res du prefixe
SELECT TOP(1) @VAR_MATRICULE_LONGUEUR=LEN(IND_MATRICULEHRS) FROM VENTILATION_INDIVIDUS --longueur des matricule

--Le code auxiliaire � une longueur @VAR_AUXI_LONGUEUR. Il commence par un pr�fixe @VAR_AUXI_PREFIXE + Matricule

--Longueur de l'auxiliaire - longueur du prefixe = longueur du code matricule � prendre

SET @VAR_MATRICUE_RIGHT=@VAR_AUXI_LONGUEUR-@VAR_AUXI_PREFIXE_LONGUEUR;

Print 'Nbre de caract�res � prendre dans le matricule= '+CAST(@VAR_MATRICUE_RIGHT AS Varchar(255))

GO

Print 'Fin reprise classification'