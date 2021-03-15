USE REPRISE_HRU

Go

DECLARE 

@VAR_CMATR varchar(50),
@VAR_MATRICULEHRS varchar(10),--donnée de l'INSERT
@VAR_MATRICULEHRS_TEMPORAIRE int, --incrémentation du matricule
@VAR_AUXILIAIRE varchar(50),
@VAR_CEMP varchar(35),
@VAR_STATUT varchar(50),
@VAR_SIREN varchar(50),
@VAR_LIGNE_INDIVIDU int,
@VAR_TOTAL_INDIVIDUS int,
@VAR_RAISON_SOCIALE varchar(255),
@VAR_NATURECONTROLE varchar(255),
@VAR_RESULTATCONTROLE varchar(255),
@VAR_COMMENTAIRE varchar(255),
@VAR_VENTILATION_INDIVIDU int,
@VAR_VENTILATION_CEMP int,
@VAR_IND_REPRISE_HR_SPRINT_SALARIE char(1),
@VAR_IND_REPRISE_HR_SPRINT_CONTRATRAVAIL char(1),
@VAR_IND_REPRISE_HR_SPRINT_DEPORTSAL char(1),
@VAR_IND_REPRISE_HR_SPRINT_SALARIECOMPL char(1),
@VAR_IND_REPRISE_HR_SPRINT_TIERS char(1),
@VAR_IND_REPRISE_HR_SPRINT_RIB char(1),
@VAR_IND_REPRISE_HR_SPRINT_AXE char(1),
@VAR_IND_REPRISE_HR_SPRINT_CVENTIL char(1),
@VAR_IND_REPRISE_HR_SPRINT_CVENTILENTETE char(1),
@VAR_IND_REPRISE_HR_SPRINT_CSECTION char(1),
@VAF_IND_REPRISE_HR_SPRINT_PAIEENCOURS char(1),
@VAR_IND_REPRISE_HR_SPRINT_HISTOBULLETIN char(1),
@VAR_IND_REPRISE_HR_SPRINT_HISTOCUMSAL char(1),
@VAR_IND_REPRISE_HR_SPRINT_ENFANTSALARIE char(1),
@VAR_IND_REPRISE_HR_SPRINT_PASTAUX char(1),
@VAR_IND_REPRISE_HR_SPRINT_ABSENCESALARIE char(1),
@VAR_IND_REPRISE_HR_SPRINT_PAIEENCOURS char(1),
@VAR_IND_REPRISE_HR_SPRINT_PGHISTODETAIL char(1);

SET @VAR_IND_REPRISE_HR_SPRINT_SALARIE='-';
SET @VAR_IND_REPRISE_HR_SPRINT_CONTRATRAVAIL='-';
SET @VAR_IND_REPRISE_HR_SPRINT_DEPORTSAL='-';
SET @VAR_IND_REPRISE_HR_SPRINT_SALARIECOMPL='-'
SET @VAR_IND_REPRISE_HR_SPRINT_TIERS='-';
SET @VAR_IND_REPRISE_HR_SPRINT_RIB='-';
SET @VAR_IND_REPRISE_HR_SPRINT_AXE='-';
SET @VAR_IND_REPRISE_HR_SPRINT_CVENTIL='-';
SET @VAR_IND_REPRISE_HR_SPRINT_CVENTILENTETE='-';
SET @VAR_IND_REPRISE_HR_SPRINT_CSECTION='-';
SET @VAF_IND_REPRISE_HR_SPRINT_PAIEENCOURS='-';
SET @VAR_IND_REPRISE_HR_SPRINT_HISTOBULLETIN='-';
SET @VAR_IND_REPRISE_HR_SPRINT_HISTOCUMSAL='-';
SET @VAR_IND_REPRISE_HR_SPRINT_ENFANTSALARIE='-';
SET @VAR_IND_REPRISE_HR_SPRINT_PASTAUX='-';
SET @VAR_IND_REPRISE_HR_SPRINT_ABSENCESALARIE='-';
SET @VAR_IND_REPRISE_HR_SPRINT_PAIEENCOURS='-';
SET @VAR_IND_REPRISE_HR_SPRINT_PGHISTODETAIL='-';
SET @VAR_STATUT='Eligible';
SET @VAR_MATRICULEHRS='En attente';

DECLARE VENTILATION_INDIVIDUS_CURSOR CURSOR FOR

SELECT MATRI,CEMP,SIREN
FROM GENCONTRAT
LEFT JOIN EMPLOYEUR ON EMPLOYEUR=CEMP
GROUP BY MATRI,CEMP,SIREN;

OPEN VENTILATION_INDIVIDUS_CURSOR
FETCH NEXT FROM VENTILATION_INDIVIDUS_CURSOR
INTO @VAR_CMATR,@VAR_CEMP,@VAR_SIREN;

WHILE @@FETCH_STATUS = 0

	BEGIN
			
	INSERT INTO VENTILATION_INDIVIDUS
		
	VALUES(@VAR_CEMP,@VAR_SIREN,@VAR_CMATR,CAST(@VAR_MATRICULEHRS AS VARCHAR(10)),@VAR_AUXILIAIRE,@VAR_STATUT,
	@VAR_IND_REPRISE_HR_SPRINT_SALARIE,@VAR_IND_REPRISE_HR_SPRINT_CONTRATRAVAIL,@VAR_IND_REPRISE_HR_SPRINT_DEPORTSAL,@VAR_IND_REPRISE_HR_SPRINT_SALARIECOMPL,@VAR_IND_REPRISE_HR_SPRINT_TIERS,@VAR_IND_REPRISE_HR_SPRINT_RIB,
	@VAR_IND_REPRISE_HR_SPRINT_AXE,@VAR_IND_REPRISE_HR_SPRINT_CVENTIL,@VAR_IND_REPRISE_HR_SPRINT_CVENTILENTETE,@VAR_IND_REPRISE_HR_SPRINT_CSECTION,@VAR_IND_REPRISE_HR_SPRINT_PAIEENCOURS,@VAR_IND_REPRISE_HR_SPRINT_HISTOBULLETIN,
	@VAR_IND_REPRISE_HR_SPRINT_HISTOCUMSAL,@VAR_IND_REPRISE_HR_SPRINT_ENFANTSALARIE,@VAR_IND_REPRISE_HR_SPRINT_PASTAUX,@VAR_IND_REPRISE_HR_SPRINT_ABSENCESALARIE,@VAR_IND_REPRISE_HR_SPRINT_PGHISTODETAIL);
	
	FETCH NEXT FROM VENTILATION_INDIVIDUS_CURSOR
	INTO @VAR_CMATR,@VAR_CEMP,@VAR_SIREN;

	END

CLOSE VENTILATION_INDIVIDUS_CURSOR;  
DEALLOCATE VENTILATION_INDIVIDUS_CURSOR;  
GO  

--Gestion de la renumération des matricules

--Le traitement aura lieu dans une table de travail TRAVAIL_RENUMEROTAION_MATRICULE

--Pour chaque matricule dans la table VENTILATION_INDIVIDUS on va chercher l'employeur (traitement à optimiser il doit tester le nbre de salarié*nbre de sociétés)

--Si Renumerotation matricule dans la table PARAMETRES = 1 : conservation matricule HRU 2: CEMP + matricule HRU 3: renumérotation

DECLARE

@VAR_PARAMETRES_RENUMEROTATION char(1),
@VAR_MATRICULEHRS_ANCIEN_VARCHAR varchar(10),
@VAR_MATRICULEHRS_ANCIEN_INT int,
@VAR_MATRICULEHRS varchar(10),
@VAR_SOCIETE_LIGNE int,--société en cours
@VAR_SOCIETE_TOTAL int,--total des sociétés
@VAR_RAISON_SOCIALE varchar(255),
@VAR_NATURECONTROLE varchar(255),
@VAR_RESULTATCONTROLE varchar(255),
@VAR_COMMENTAIRE varchar(255),
@VAR_CEMP varchar(255),
@VAR_LIGNE_INDIVIDU int,--salarié en cours table individu
@VAR_CMATR varchar(35), --matricule en cours 
@VAR_TOTAL_INDIVIDUS int,--donne le nombre de salariés par sociétés
@VAR_CEMP_SALARIE varchar(35),--CEMP du salarié en cours
@VAR_TRAV1_CEMP varchar(35),--CEMP du salarié en cours table de travail
@VAR_TRAV1_MATRICULEHRS_TEMPORAIRE varchar(35),
@VAR_TRAV1_MATRICULEHRS varchar(35),
@VAR_TRAV1_MATRICULEHRU varchar(35); --matricule en cours table de travail

SET @VAR_TRAV1_MATRICULEHRS_TEMPORAIRE=0;
SET @VAR_TRAV1_MATRICULEHRS=' ';
SET @VAR_TOTAL_INDIVIDUS=0;
SELECT @VAR_LIGNE_INDIVIDU=MIN(IND_LIGNE) FROM VENTILATION_INDIVIDUS;
SET @VAR_NATURECONTROLE='RENUMEROTATION_MATRICULE';
SET @VAR_RESULTATCONTROLE='Ok';
SET @VAR_SOCIETE_LIGNE=1;

SELECT @VAR_SOCIETE_TOTAL=COUNT(*) FROM EMPLOYEUR;--nombre de sociétés é traiter


SELECT @VAR_PARAMETRES_RENUMEROTATION=PAR_VALEUR FROM PARAMETRES WHERE PAR_NOM='RENUMEROTATION_MATRICULE';

Print 'Mode de transco matricule : '+CAST(@VAR_PARAMETRES_RENUMEROTATION as varchar(255))

IF @VAR_PARAMETRES_RENUMEROTATION='1' --on conserve le code HRU

BEGIN

UPDATE VENTILATION_INDIVIDUS SET IND_MATRICULEHRS=IND_MATRICULEHRU;

Print 'Conservation des matricules HRU'

END

IF @VAR_PARAMETRES_RENUMEROTATION='2' --on conserve le code HRU mais on ajoute le code employeur

BEGIN

UPDATE VENTILATION_INDIVIDUS SET IND_MATRICULEHRS=CONCAT(IND_CEMP,IND_MATRICULEHRU);

Print 'Conservation des matricules HRU + CEMP CONCAT IND_CEMP+IND_MATRICULEHRU'

END

--Passage des comptes matricule sur 10 positons
GO
DECLARE 
@VAR_MATRICULEHRS varchar(10),
@VAR_NBRECARACTEREBOURRAGE int;
DECLARE VENTILATION_INDIVIDUS_RENUMEROTATION_CURSOR CURSOR FOR

SELECT IND_MATRICULEHRS
FROM VENTILATION_INDIVIDUS

OPEN VENTILATION_INDIVIDUS_RENUMEROTATION_CURSOR
FETCH NEXT FROM VENTILATION_INDIVIDUS_RENUMEROTATION_CURSOR
INTO @VAR_MATRICULEHRS;


WHILE @@FETCH_STATUS = 0
BEGIN
	
	SET @VAR_NBRECARACTEREBOURRAGE=10-LEN(@VAR_MATRICULEHRS);
	PRINT 'Nbre caractere bourrage '+CAST(@VAR_NBRECARACTEREBOURRAGE as varchar(255))+' pour le matricule : '+@VAR_MATRICULEHRS
	IF @VAR_NBRECARACTEREBOURRAGE=1
	BEGIN
		UPDATE VENTILATION_INDIVIDUS SET IND_MATRICULEHRS = Left('0'+IND_MATRICULEHRS,10) WHERE IND_MATRICULEHRS=@VAR_MATRICULEHRS;
	END
	IF @VAR_NBRECARACTEREBOURRAGE=2
	BEGIN
		UPDATE VENTILATION_INDIVIDUS SET IND_MATRICULEHRS = Left('00'+IND_MATRICULEHRS,10) WHERE IND_MATRICULEHRS=@VAR_MATRICULEHRS;
	END
	IF @VAR_NBRECARACTEREBOURRAGE=3
	BEGIN
		UPDATE VENTILATION_INDIVIDUS SET IND_MATRICULEHRS = Left('000'+IND_MATRICULEHRS,10) WHERE IND_MATRICULEHRS=@VAR_MATRICULEHRS;
	END	
	IF @VAR_NBRECARACTEREBOURRAGE=4
	BEGIN
		UPDATE VENTILATION_INDIVIDUS SET IND_MATRICULEHRS = Left('0000'+IND_MATRICULEHRS,10) WHERE IND_MATRICULEHRS=@VAR_MATRICULEHRS;
	END
	IF @VAR_NBRECARACTEREBOURRAGE=5
	BEGIN
		UPDATE VENTILATION_INDIVIDUS SET IND_MATRICULEHRS = Left('00000'+IND_MATRICULEHRS,10) WHERE IND_MATRICULEHRS=@VAR_MATRICULEHRS;
	END
	IF @VAR_NBRECARACTEREBOURRAGE=6
	BEGIN
		UPDATE VENTILATION_INDIVIDUS SET IND_MATRICULEHRS = Left('000000'+IND_MATRICULEHRS,10) WHERE IND_MATRICULEHRS=@VAR_MATRICULEHRS;
	END
	FETCH NEXT FROM VENTILATION_INDIVIDUS_RENUMEROTATION_CURSOR
	INTO @VAR_MATRICULEHRS;
END

CLOSE VENTILATION_INDIVIDUS_RENUMEROTATION_CURSOR;  
DEALLOCATE VENTILATION_INDIVIDUS_RENUMEROTATION_CURSOR;  
GO  

--Création des auxilaires

DECLARE 

@VAR_AUXI_LONGUEUR int,
@VAR_AUXI_PREFIXE varchar(35),
@VAR_AUXI_PREFIXE_LONGUEUR int,
@VAR_MATRICULE_LONGUEUR int,
@VAR_MATRICUE_RIGHT int,
@VAR_SALARIE_LIGNE int,
@VAR_SALARIE_TOTAL int,
@VAR_MATRICULE_SAL varchar(10),
@VAR_AUXILIAIRE varchar(35);

SET @VAR_MATRICULE_SAL=' ';
SELECT @VAR_SALARIE_LIGNE=MIN(IND_LIGNE) FROM VENTILATION_INDIVIDUS;
SELECT @VAR_SALARIE_TOTAL=MAX(IND_LIGNE) FROM VENTILATION_INDIVIDUS;

SELECT @VAR_AUXI_LONGUEUR=CAST(PAR_VALEUR AS int) FROM PARAMETRES WHERE PAR_NOM LIKE 'AUXI_LONGUEUR'; --récupération de la longueur des comptes auxiliaire
SELECT @VAR_AUXI_PREFIXE=PAR_VALEUR FROM PARAMETRES WHERE PAR_NOM LIKE 'AUXI_PREFIXE'; --récupération du prefixe
SET @VAR_AUXI_PREFIXE_LONGUEUR=LEN(@VAR_AUXI_PREFIXE)--nbre de caractéres du prefixe
SELECT TOP(1) @VAR_MATRICULE_LONGUEUR=LEN(IND_MATRICULEHRS) FROM VENTILATION_INDIVIDUS --longueur des matricule

--Le code auxiliaire à une longueur @VAR_AUXI_LONGUEUR. Il commence par un préfixe @VAR_AUXI_PREFIXE + Matricule

--Longueur de l'auxiliaire - longueur du prefixe = longueur du code matricule à prendre

SET @VAR_MATRICUE_RIGHT=@VAR_AUXI_LONGUEUR-@VAR_AUXI_PREFIXE_LONGUEUR;

Print 'Nbre de caractéres à prendre dans le matricule= '+CAST(@VAR_MATRICUE_RIGHT AS Varchar(255))


WHILE @VAR_SALARIE_LIGNE<=@VAR_SALARIE_TOTAL --mise à jour de l'auxiliaire

BEGIN
		
	SELECT @VAR_MATRICULE_SAL=RIGHT(IND_MATRICULEHRS,@VAR_MATRICUE_RIGHT) FROM VENTILATION_INDIVIDUS WHERE IND_LIGNE=@VAR_SALARIE_LIGNE;

	SET @VAR_AUXILIAIRE=CONCAT(@VAR_AUXI_PREFIXE,@VAR_MATRICULE_SAL);

	UPDATE VENTILATION_INDIVIDUS SET IND_AUXILIAIRE=@VAR_AUXILIAIRE WHERE IND_LIGNE=@VAR_SALARIE_LIGNE;

	PRINT 'Création du code auxiliaire '+@VAR_AUXILIAIRE+' ligne en cours '+Cast(@VAR_SALARIE_LIGNE AS varchar(255))+'/'+Cast(@VAR_SALARIE_TOTAL AS varchar(255))

	SET @VAR_SALARIE_LIGNE=@VAR_SALARIE_LIGNE+1;

END

GO

PRINT 'Fin gestion table VENTILATION_INDIVIDUS'