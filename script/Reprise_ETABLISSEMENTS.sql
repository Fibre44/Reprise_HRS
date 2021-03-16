USE REPRISE_HRU


--Gestion des nouveaux codes établissements
--attention dans la table Etablissement on trouve plusieurs fois les m�mes valeurs

DECLARE

@VAR_SOCIETE_LIGNE int,--soci�t� en cours
@VAR_SOCIETE_TOTAL int,--total des soci�t�s
@VAR_SOCIETE_CEMP char(4),--soci�t� é traiter
@VAR_ETABLISSEMENT_LIGNE int, --�tablissement en cours
@VAR_ETABLISSEMENT_TOTAL int, --total des �tablissement
@VAR_SOCIETE_ETABLISSEMENT char(4), --va lire les 4 premi�re position de gauche du champ etablissement dans etablissement pour trouver la soci�t�
@VAR_ETABLISSEMENT_CODE_HRU varchar(35),--code �tablissement HRU
@VAR_ETABLISSEMENT_CODE_HRS_TEMP int, --Incr�mentation des �tablissements
@VAR_ETABLISSEMENT_CODE_HRS char(3),--code �tablissement HRS
@VAR_RAISON_SOCIALE varchar(255),
@VAR_NATURECONTROLE varchar(255),
@VAR_RESULTATCONTROLE varchar(255),
@VAR_COMMENTAIRE varchar(255),
@VAR_TYPE_TRANSCO varchar(35),--alimente la table de transco
@VAR_TYPE_VALEUR_HRU int,--test si l'�tablissement existe d�j� dans la table de transco
@VAR_TRA_SIREN varchar(35), --SIREN de la soci�t�
@VAR_PARAMETRE_RDD char(1);

SELECT @VAR_PARAMETRE_RDD=PAR_VALEUR FROM PARAMETRES WHERE PAR_NOM='Conservation code etb';

PRINT @VAR_PARAMETRE_RDD;

SET @VAR_TYPE_TRANSCO='Etablissement'
SET @VAR_ETABLISSEMENT_CODE_HRS_TEMP=0;
SET @VAR_SOCIETE_LIGNE=1; 
SET @VAR_ETABLISSEMENT_LIGNE=1;

SELECT @VAR_SOCIETE_TOTAL=COUNT(*) FROM EMPLOYEUR;
SELECT @VAR_ETABLISSEMENT_TOTAL=COUNT(*) FROM ETABLISSEMENT;

WHILE @VAR_SOCIETE_LIGNE<=@VAR_SOCIETE_TOTAL --boucle par soci�t�

BEGIN

SELECT @VAR_SOCIETE_CEMP=Employeur FROM EMPLOYEUR WHERE @VAR_SOCIETE_LIGNE=SOCIETE_LIGNE;--r�cup�ration de la soci�t� é traiter
SELECT @VAR_TRA_SIREN=Siren FROM EMPLOYEUR WHERE @VAR_SOCIETE_LIGNE=SOCIETE_LIGNE; --r�cup�ration du SIREN


	WHILE @VAR_ETABLISSEMENT_LIGNE<=@VAR_ETABLISSEMENT_TOTAL --boucle par �tablissement

	BEGIN

	SELECT @VAR_SOCIETE_ETABLISSEMENT=LEFT(Etablissement,4) FROM ETABLISSEMENT WHERE  ETABLISSEMENT_LIGNE=@VAR_ETABLISSEMENT_LIGNE;--r�cup�ration du code soci�t�
	Print 'Societe du code etb'+ RIGHT(@VAR_SOCIETE_ETABLISSEMENT,4)+'soci�t� en cours'+@VAR_SOCIETE_CEMP 

		IF @VAR_SOCIETE_ETABLISSEMENT=@VAR_SOCIETE_CEMP --Si le code soci�t� de l'�tablissement correspond é l'�tablissement en cours alors traitement

			BEGIN
			SELECT @VAR_ETABLISSEMENT_CODE_HRU=Etablissement FROM ETABLISSEMENT WHERE ETABLISSEMENT_LIGNE=@VAR_ETABLISSEMENT_LIGNE;
			SELECT @VAR_TYPE_VALEUR_HRU=COUNT(*) FROM TRANSCO WHERE TRA_VALEURHRU=@VAR_ETABLISSEMENT_CODE_HRU;--recherche si l'�tablissement a d�j� �t� trait�

			IF @VAR_TYPE_VALEUR_HRU=0 --Test si l'�tablissement a d�j� �t� import�

			BEGIN

				IF @VAR_PARAMETRE_RDD='-'

				BEGIN

					SET @VAR_ETABLISSEMENT_CODE_HRS_TEMP=@VAR_ETABLISSEMENT_CODE_HRS_TEMP+1;--Incr�mentation du compteur
			
				
						IF @VAR_ETABLISSEMENT_CODE_HRS_TEMP<10--Ajout des 0 
	
							BEGIN
				
							SET @VAR_ETABLISSEMENT_CODE_HRS=CONCAT('00',CAST(@VAR_ETABLISSEMENT_CODE_HRS_TEMP AS VARCHAR(3)));
				
							END

						ELSE

							BEGIN

							SET @VAR_ETABLISSEMENT_CODE_HRS=CONCAT('0',CAST(@VAR_ETABLISSEMENT_CODE_HRS_TEMP AS VARCHAR(3)));

							END
		
					Print 'Soci�t� en cours '+@VAR_SOCIETE_CEMP+' l �tablissement '+@VAR_ETABLISSEMENT_CODE_HRU+' devient '+@VAR_ETABLISSEMENT_CODE_HRS-- Affiche du message
					SET @VAR_COMMENTAIRE='Soci�t� en cours '+@VAR_SOCIETE_CEMP+' l �tablissement '+@VAR_ETABLISSEMENT_CODE_HRU+' devient '+@VAR_ETABLISSEMENT_CODE_HRS;
				
					INSERT INTO TRANSCO
					VALUES (@VAR_TYPE_TRANSCO,@VAR_ETABLISSEMENT_CODE_HRU,@VAR_ETABLISSEMENT_CODE_HRS,@VAR_TRA_SIREN);

					END
				

				ELSE --Si non conserve le code
					BEGIN
					SET @VAR_ETABLISSEMENT_CODE_HRS=RIGHT (@VAR_ETABLISSEMENT_CODE_HRU,3);

					INSERT INTO TRANSCO
					VALUES (@VAR_TYPE_TRANSCO,@VAR_ETABLISSEMENT_CODE_HRU,@VAR_ETABLISSEMENT_CODE_HRS,@VAR_TRA_SIREN);

					PRINT 'On conserve le code etb'+@VAR_ETABLISSEMENT_CODE_HRS
					END
			END
			
			ELSE --L'�tablissement existe d�j�

				BEGIN

				Print 'L �tablissement a d�j� �t� trait�'
				SET @VAR_COMMENTAIRE='L �tablissement a d�j� �t� trait�';

				END
			END

			ELSE--l'�tablissement ne fait pas partie de la soci�t� en cours

			BEGIN

			Print 'L �tablissement ne fait pas partie de la soci�t�'
			END


	SET @VAR_ETABLISSEMENT_LIGNE=@VAR_ETABLISSEMENT_LIGNE+1;

	END

SET @VAR_ETABLISSEMENT_CODE_HRS_TEMP=0;
SET @VAR_ETABLISSEMENT_LIGNE=1;
SET @VAR_SOCIETE_LIGNE=@VAR_SOCIETE_LIGNE+1;

END

GO

--Alimentation de la table HR_SPRINT_ETABLISS

DECLARE

@VAR_ET_SIREN varchar(35),
@VAR_ET_ETABLISSEMENT char(3),
@VAR_ET_LIBELLE varchar(35),
@VAR_ET_ABREGE varchar(35),
@VAR_ET_ADRESSE1 varchar(50),
@VAR_ET_CODEPOSTAL char(5),
@VAR_ET_VILLE varchar(35),
@VAR_ET_DIVTERRIT char(5),
@VAR_ET_PAYS char(3),
@VAR_ET_LANGUE char(3),
@VAR_ET_SOCIETE char(3),
@VAR_ET_JURIDIQUE char(3),
@VAR_ET_SIRET char(14),
@VAR_NIC_ETABLISSEMENT varchar(5),
@VAR_ET_APE char(5),
@VAR_CODE_ETAB_HR_SPRINT char(3), --code �tablissement HR Sprint
@VAR_CODE_ETAB_HRU char(13),-- code �tablissement HRU
@VAR_NBRE_ETABLISSEMENT int,--nbre total d'�tablissement
@VAR_ETABLISSEMENT_EN_COURS int; --ligne en cours

SELECT @VAR_ETABLISSEMENT_EN_COURS=MIN(TRA_ID) FROM TRANSCO WHERE TRA_TYPE='Etablissement';
SELECT @VAR_NBRE_ETABLISSEMENT=MAX(TRA_ID) FROM TRANSCO WHERE TRA_TYPE='Etablissement';
SET @VAR_ET_DIVTERRIT='';
SET @VAR_ET_SOCIETE='001';
SET @VAR_ET_PAYS='FRA';
SET @VAR_ET_LANGUE='';
SET @VAR_ET_JURIDIQUE='';

WHILE @VAR_ETABLISSEMENT_EN_COURS<=@VAR_NBRE_ETABLISSEMENT

BEGIN

SELECT @VAR_CODE_ETAB_HR_SPRINT=TRA_VALEURHRS FROM TRANSCO WHERE TRA_ID=@VAR_ETABLISSEMENT_EN_COURS; --r�cup�ration du code �tablissement HRS
SET @VAR_ET_ETABLISSEMENT=@VAR_CODE_ETAB_HR_SPRINT;
SELECT @VAR_CODE_ETAB_HRU=TRA_VALEURHRU FROM TRANSCO WHERE TRA_ID=@VAR_ETABLISSEMENT_EN_COURS;--r�cup�ration du code �tablissement HRU
SELECT @VAR_ET_SIREN=TRA_SIREN FROM TRANSCO WHERE TRA_ID=@VAR_ETABLISSEMENT_EN_COURS; --r�cup�ration du SIREN de l'�tablissement

SELECT TOP(1) @VAR_ET_LIBELLE=[Raison Sociale] FROM ETABLISSEMENT WHERE Etablissement=@VAR_CODE_ETAB_HRU;
SELECT TOP(1) @VAR_ET_ABREGE=[Raison Sociale] FROM ETABLISSEMENT WHERE Etablissement=@VAR_CODE_ETAB_HRU;
SELECT TOP(1) @VAR_NIC_ETABLISSEMENT=[Nic] FROM ETABLISSEMENT WHERE Etablissement=@VAR_CODE_ETAB_HRU;--r�cup�ration du NIC etablissement
SET @VAR_ET_SIRET=CONCAT(@VAR_ET_SIREN,@VAR_NIC_ETABLISSEMENT);
Print @VAR_ET_SIRET
SELECT TOP(1) @VAR_ET_APE=[Code APET] FROM ETABLISSEMENT WHERE Etablissement=@VAR_CODE_ETAB_HRU;--r�cup�ration du NIC etablissement
SELECT TOP(1) @VAR_ET_ADRESSE1=Voie FROM ETABLISSEMENT WHERE Etablissement=@VAR_CODE_ETAB_HRU;--r�cup�ration du NIC etablissement
SELECT TOP(1) @VAR_ET_CODEPOSTAL=[Code postal] FROM ETABLISSEMENT WHERE Etablissement=@VAR_CODE_ETAB_HRU;--r�cup�ration du NIC etablissement
SELECT TOP(1) @VAR_ET_VILLE=[Localit�] FROM ETABLISSEMENT WHERE Etablissement=@VAR_CODE_ETAB_HRU;--r�cup�ration du NIC etablissement

INSERT INTO HR_SPRINT_ETABLISS
VALUES (@VAR_ET_SIREN,@VAR_ET_ETABLISSEMENT,@VAR_ET_LIBELLE,@VAR_ET_ABREGE,@VAR_ET_ADRESSE1,@VAR_ET_CODEPOSTAL,@VAR_ET_VILLE,@VAR_ET_DIVTERRIT,@VAR_ET_PAYS,
@VAR_ET_LANGUE,@VAR_ET_SOCIETE,@VAR_ET_JURIDIQUE,@VAR_ET_SIRET,@VAR_ET_APE);

PRINT 'Cr�ation de l �tablissement '+@VAR_ET_LIBELLE

SET @VAR_ETABLISSEMENT_EN_COURS=@VAR_ETABLISSEMENT_EN_COURS+1;

END

GO

Print 'Fin reprise Etablissements'
