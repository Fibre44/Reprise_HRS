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
GROUP BY MATRI, CEMP,SIREN;

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

Print 'Mode de transco matricule : '+@VAR_PARAMETRES_RENUMEROTATION

IF @VAR_PARAMETRES_RENUMEROTATION='1' --on conserve le code HRU

BEGIN

UPDATE VENTILATION_INDIVIDUS SET IND_MATRICULEHRS=IND_MATRICULEHRU;

Print 'Conservation des matricules HRU'

END

IF @VAR_PARAMETRES_RENUMEROTATION='2' --on conserve le code HRU mais on ajoute le code employeur

BEGIN

UPDATE VENTILATION_INDIVIDUS SET IND_MATRICULEHRS=CONCAT(IND_CEMP,IND_MATRICULEHRU);

Print 'Conservation des matricules HRU + CEMP'

END

IF @VAR_PARAMETRES_RENUMEROTATION='3' --on change le code HRU

BEGIN

	WHILE @VAR_SOCIETE_LIGNE<=@VAR_SOCIETE_TOTAL --Boucle par sociétés

	BEGIN
	
	Print 'On recodifie les matricules'
	SELECT @VAR_CEMP=Employeur FROM EMPLOYEUR WHERE SOCIETE_LIGNE=@VAR_SOCIETE_LIGNE;--récupération de la société é traiter
	SELECT @VAR_TOTAL_INDIVIDUS=MAX(IND_LIGNE) FROM VENTILATION_INDIVIDUS;--donne le nombre de salariés total


		WHILE @VAR_LIGNE_INDIVIDU<=@VAR_TOTAL_INDIVIDUS  --Boucle par salariés 

	
			BEGIN

			SELECT @VAR_CMATR=IND_MATRICULEHRU FROM VENTILATION_INDIVIDUS WHERE IND_LIGNE=@VAR_LIGNE_INDIVIDU; --récupération du matricule en cours
			SELECT @VAR_CEMP_SALARIE=IND_CEMP FROM VENTILATION_INDIVIDUS WHERE IND_LIGNE=@VAR_LIGNE_INDIVIDU;--récupération de l'employeur
		
			IF @VAR_CEMP_SALARIE=@VAR_CEMP --Si le salarié est dans la société en cours alors on ajoute é la table de travail et on indique +1 dans le matricule
		
			BEGIN

			PRINT 'Société en cours '+@VAR_CEMP+' traitement '+CAST(@VAR_SOCIETE_LIGNE AS VARCHAR(255))+'/'+CAST(@VAR_SOCIETE_TOTAL AS VARCHAR(255))++' le salarié '+@VAR_CMATR+' est dans la société '+@VAR_CEMP_SALARIE+' on ajoute é la table de travail ligne en cours '+CAST(@VAR_LIGNE_INDIVIDU AS VARCHAR(255))+'/'+CAST(@VAR_TOTAL_INDIVIDUS AS VARCHAR(255))
			SET @VAR_TRAV1_CEMP=@VAR_CEMP_SALARIE;
			SET @VAR_TRAV1_MATRICULEHRU=@VAR_CMATR;
			SET @VAR_TRAV1_MATRICULEHRS_TEMPORAIRE=@VAR_TRAV1_MATRICULEHRS_TEMPORAIRE+1;--incrémentation du code matricule de la société
			Print 'Code matricule temporaire aprés incrémentation '+cast(@VAR_TRAV1_MATRICULEHRS_TEMPORAIRE as varchar(255))

			--Ajout des 0 en 4,3,2 éme position

				IF @VAR_TRAV1_MATRICULEHRS_TEMPORAIRE<10
				BEGIN	
					SET @VAR_TRAV1_MATRICULEHRS=CONCAT('00',@VAR_CEMP_SALARIE,'000',CAST(@VAR_TRAV1_MATRICULEHRS_TEMPORAIRE AS VARCHAR(10)));
				END
				ELSE IF @VAR_TRAV1_MATRICULEHRS_TEMPORAIRE=10
				BEGIN	
					SET @VAR_TRAV1_MATRICULEHRS=CONCAT('00',@VAR_CEMP_SALARIE,'00',CAST(@VAR_TRAV1_MATRICULEHRS_TEMPORAIRE AS VARCHAR(10)));
				END
				ELSE IF @VAR_TRAV1_MATRICULEHRS_TEMPORAIRE>10 AND @VAR_TRAV1_MATRICULEHRS_TEMPORAIRE<100
				BEGIN
					SET @VAR_TRAV1_MATRICULEHRS=CONCAT('00',@VAR_CEMP_SALARIE,'00',CAST(@VAR_TRAV1_MATRICULEHRS_TEMPORAIRE AS VARCHAR(10)));
				END
				ELSE IF @VAR_TRAV1_MATRICULEHRS_TEMPORAIRE>100 AND @VAR_TRAV1_MATRICULEHRS_TEMPORAIRE<1000
				BEGIN
					SET @VAR_TRAV1_MATRICULEHRS=CONCAT('00',@VAR_CEMP_SALARIE,'0',CAST(@VAR_TRAV1_MATRICULEHRS_TEMPORAIRE AS VARCHAR(10)));
				END
				ELSE IF @VAR_TRAV1_MATRICULEHRS_TEMPORAIRE=100 AND @VAR_TRAV1_MATRICULEHRS_TEMPORAIRE<999
				BEGIN
					SET @VAR_TRAV1_MATRICULEHRS=CONCAT('00',@VAR_CEMP_SALARIE,'0',CAST(@VAR_TRAV1_MATRICULEHRS_TEMPORAIRE AS VARCHAR(10)));
				END
				ELSE IF @VAR_TRAV1_MATRICULEHRS_TEMPORAIRE>1000
				BEGIN
					SET @VAR_TRAV1_MATRICULEHRS=CAST(@VAR_TRAV1_MATRICULEHRS_TEMPORAIRE AS VARCHAR(10));
				END
				Print 'Matricule définitif '+cast(@VAR_TRAV1_MATRICULEHRS as varchar(255))
				--INSERT INTO TRAVAIL_RENUMEROTATION_MATRICULE
				--VALUES (@VAR_TRAV1_CEMP,@VAR_TRAV1_MATRICULEHRU,@VAR_TRAV1_MATRICULEHRS_TEMPORAIRE,@VAR_TRAV1_MATRICULEHRS);--alimentation de la table de travail

				Print 'Mise é jour du matricule HRU' +@VAR_CMATR+'avec la valeur '+@VAR_TRAV1_MATRICULEHRS
				UPDATE VENTILATION_INDIVIDUS SET IND_MATRICULEHRS=@VAR_TRAV1_MATRICULEHRS WHERE IND_MATRICULEHRU=@VAR_CMATR AND IND_CEMP=@VAR_CEMP_SALARIE;

				END

				ELSE

				BEGIN
				PRINT 'Société en cours '+@VAR_CEMP+' le salarié '+@VAR_CMATR+' est dans la société '+@VAR_CEMP_SALARIE+' on ajoute  pas é la table de travail ligne en cours '+CAST(@VAR_LIGNE_INDIVIDU AS VARCHAR(255))+'/'+CAST(@VAR_TOTAL_INDIVIDUS AS VARCHAR(255))

				END

			SET @VAR_LIGNE_INDIVIDU=@VAR_LIGNE_INDIVIDU+1;--boucle par salarié
		
			END

		DELETE TRAVAIL_RENUMEROTATION_MATRICULE;--suppression des enregistrements pour le prochain tour
		SET @VAR_TRAV1_MATRICULEHRS_TEMPORAIRE=0;
		SELECT @VAR_LIGNE_INDIVIDU=MIN(IND_LIGNE) FROM VENTILATION_INDIVIDUS;--Remise 0 du compteur salarié é traiter
		SET @VAR_SOCIETE_LIGNE=@VAR_SOCIETE_LIGNE+1;--boucle par société

	END
END

GO

--Gestion des codes matricules < 10 positions

DECLARE

@VAR_LONGUEUR_MATRICULE_HRU int,
@VAR_LONGUEUR_MATRICULE_HRS int,
@VAR_LONGUEUR_CIBLE int,
@VAR_INDIVIDUS_EN_COURS int,
@VAR_NB_CARACTERE_BOURAGE int,
@VAR_INDIVIDUS_TOTAL int,
@VAR_PARAMETRES_RENUMEROTATION char(1);

SELECT @VAR_PARAMETRES_RENUMEROTATION=PAR_VALEUR FROM PARAMETRES WHERE PAR_NOM='Renumérotation matricules';
SET @VAR_LONGUEUR_CIBLE=10;
SELECT @VAR_INDIVIDUS_EN_COURS=MIN(IND_LIGNE) FROM VENTILATION_INDIVIDUS;
SELECT @VAR_INDIVIDUS_TOTAL=MAX(IND_LIGNE) FROM VENTILATION_INDIVIDUS;

IF @VAR_PARAMETRES_RENUMEROTATION='2' -- si CEMP+Matricule HRU

BEGIN
	
	WHILE @VAR_INDIVIDUS_EN_COURS<=@VAR_INDIVIDUS_TOTAL
	
	BEGIN
		
		SELECT @VAR_LONGUEUR_MATRICULE_HRS=LEN(IND_MATRICULEHRS) FROM VENTILATION_INDIVIDUS WHERE IND_LIGNE=@VAR_INDIVIDUS_EN_COURS
		
		IF @VAR_LONGUEUR_MATRICULE_HRS>10

		BEGIN			
			UPDATE VENTILATION_INDIVIDUS SET IND_MATRICULEHRS=LEFT(IND_MATRICULEHRS,10) WHERE IND_LIGNE=@VAR_INDIVIDUS_EN_COURS;
		END

		ELSE

		BEGIN
			
			SET @VAR_NB_CARACTERE_BOURAGE=@VAR_LONGUEUR_CIBLE-@VAR_LONGUEUR_MATRICULE_HRS;

			IF @VAR_NB_CARACTERE_BOURAGE=2

			BEGIN

			UPDATE VENTILATION_INDIVIDUS SET IND_MATRICULEHRS=CONCAT('00',IND_MATRICULEHRS) WHERE IND_LIGNE=@VAR_INDIVIDUS_EN_COURS;

			END

			IF @VAR_NB_CARACTERE_BOURAGE=1

			BEGIN

			UPDATE VENTILATION_INDIVIDUS SET IND_MATRICULEHRS=CONCAT('0',IND_MATRICULEHRS) WHERE IND_LIGNE=@VAR_INDIVIDUS_EN_COURS;

			END
			
		END
		SET @VAR_INDIVIDUS_EN_COURS=@VAR_INDIVIDUS_EN_COURS+1;
	END


END

ELSE -- si scenario conservation matricule HRU ou renumérotation compléte

BEGIN
	WHILE @VAR_INDIVIDUS_EN_COURS<=@VAR_INDIVIDUS_TOTAL

	BEGIN

		SELECT @VAR_LONGUEUR_MATRICULE_HRU=LEN(IND_MATRICULEHRU) FROM VENTILATION_INDIVIDUS WHERE IND_LIGNE=@VAR_INDIVIDUS_EN_COURS

		SET @VAR_NB_CARACTERE_BOURAGE=@VAR_LONGUEUR_CIBLE-@VAR_LONGUEUR_MATRICULE_HRU;

		IF @VAR_NB_CARACTERE_BOURAGE=7

		BEGIN

			UPDATE VENTILATION_INDIVIDUS SET IND_MATRICULEHRS=CONCAT('0000000',IND_MATRICULEHRU) WHERE IND_LIGNE=@VAR_INDIVIDUS_EN_COURS;

		END


		IF @VAR_NB_CARACTERE_BOURAGE=6

		BEGIN

				UPDATE VENTILATION_INDIVIDUS SET IND_MATRICULEHRS=CONCAT('000000',IND_MATRICULEHRU) WHERE IND_LIGNE=@VAR_INDIVIDUS_EN_COURS;

		END


		IF @VAR_NB_CARACTERE_BOURAGE=5

		BEGIN

				UPDATE VENTILATION_INDIVIDUS SET IND_MATRICULEHRS=CONCAT('00000',IND_MATRICULEHRU) WHERE IND_LIGNE=@VAR_INDIVIDUS_EN_COURS;

		END

		IF @VAR_NB_CARACTERE_BOURAGE=4

		BEGIN

			UPDATE VENTILATION_INDIVIDUS SET IND_MATRICULEHRS=CONCAT('0000',IND_MATRICULEHRU) WHERE IND_LIGNE=@VAR_INDIVIDUS_EN_COURS;

		END

		IF @VAR_NB_CARACTERE_BOURAGE=3

		BEGIN

			UPDATE VENTILATION_INDIVIDUS SET IND_MATRICULEHRS=CONCAT('000',IND_MATRICULEHRU) WHERE IND_LIGNE=@VAR_INDIVIDUS_EN_COURS;

		END

		IF @VAR_NB_CARACTERE_BOURAGE=2

		BEGIN

			UPDATE VENTILATION_INDIVIDUS SET IND_MATRICULEHRS=CONCAT('00',IND_MATRICULEHRU) WHERE IND_LIGNE=@VAR_INDIVIDUS_EN_COURS;

		END

		IF @VAR_NB_CARACTERE_BOURAGE=1

		BEGIN

			UPDATE VENTILATION_INDIVIDUS SET IND_MATRICULEHRS=CONCAT('0',IND_MATRICULEHRU) WHERE IND_LIGNE=@VAR_INDIVIDUS_EN_COURS;

		END

	PRINT 'Justification nbre de caractere HRU 10-'+CAST(@VAR_LONGUEUR_MATRICULE_HRU as varchar(255))+'='+CAST(@VAR_NB_CARACTERE_BOURAGE as varchar(255))+' ligne en cours '+cast(@VAR_INDIVIDUS_EN_COURS AS varchar(255))+'/'+cast(@VAR_INDIVIDUS_TOTAL as varchar(255))

	 SET @VAR_INDIVIDUS_EN_COURS=@VAR_INDIVIDUS_EN_COURS+1;

	END
END
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

--Le code auxiliaire é une longueur @VAR_AUXI_LONGUEUR. Il commence par un préfixe @VAR_AUXI_PREFIXE + Matricule

--Longueur de l'auxiliaire - longueur du prefixe = longueur du code matricule é prendre

SET @VAR_MATRICUE_RIGHT=@VAR_AUXI_LONGUEUR-@VAR_AUXI_PREFIXE_LONGUEUR;

Print 'Nbre de caractéres é prendre dans le matricule= '+CAST(@VAR_MATRICUE_RIGHT AS Varchar(255))


WHILE @VAR_SALARIE_LIGNE<=@VAR_SALARIE_TOTAL --mise é jour de l'auxiliaire

BEGIN



SELECT @VAR_MATRICULE_SAL=RIGHT(IND_MATRICULEHRS,@VAR_MATRICUE_RIGHT) FROM VENTILATION_INDIVIDUS WHERE IND_LIGNE=@VAR_SALARIE_LIGNE;

SET @VAR_AUXILIAIRE=CONCAT(@VAR_AUXI_PREFIXE,@VAR_MATRICULE_SAL);

UPDATE VENTILATION_INDIVIDUS SET IND_AUXILIAIRE=@VAR_AUXILIAIRE WHERE IND_LIGNE=@VAR_SALARIE_LIGNE;

PRINT 'Création du code auxiliaire '+@VAR_AUXILIAIRE+' ligne en cours '+Cast(@VAR_SALARIE_LIGNE AS varchar(255))+'/'+Cast(@VAR_SALARIE_TOTAL AS varchar(255))

SET @VAR_SALARIE_LIGNE=@VAR_SALARIE_LIGNE+1;

END

GO

PRINT 'Fin gestion table VENTILATION_INDIVIDUS'