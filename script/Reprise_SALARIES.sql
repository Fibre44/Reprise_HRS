USE REPRISE_HRU

GO

DECLARE

@VAR_PSA_SIREN varchar(255),--SIREN de la soci�t�
@VAR_PSA_SALARIE varchar(10),--
@VAR_PSA_NUMEROSS varchar(15),
@VAR_PSA_LIBELLE varchar(35),
@VAR_PSA_NOMJF varchar(35),
@VAR_PSA_PRENOM varchar(35),
@VAR_PSA_ETABLISSEMENT char(3),
@VAR_ETABLISSEMENT_SALARIE varchar(35),
@VAR_PSA_ADRESSE1 varchar (35),
@VAR_PSA_CODEPOSTAL char(9),
@VAR_PSA_VILLE varchar(50),
@VAR_PSA_PAYS varchar(3),
@VAR_PSA_DATENAISSANCE datetime,
@VAR_PSA_COMMUNENAISS varchar(35),
@VAR_PSA_DEPTNAISSANCE char(2),
@VAR_PSA_PAYSNAISSANCE char(3),
@VAR_PSA_NATIONALITE char(50),
@VAR_PSA_SEXE char(1),
@VAR_SEXE_TRANSCO char(2),
@VAR_PSA_SITUATIONFAMIL char(3),
@VAR_SITUATIONFAMIL char(1),
@VAR_PSA_DATEENTREE datetime,
@VAR_PSA_DATEANCIENNETE datetime,
@VAR_PSA_DATESORTIE datetime,
@VAR_PSA_CARTESEJOUR varchar(50),
@VAR_PSA_DATEEXPIRSEJOUR datetime,
@VAR_PSA_DELIVRPAR varchar(35),
@VAR_PSA_PERSACHARGE int,
@VAR_PSA_MODEREGLE char(3),
@VAR_HRU_MODE_REGLE char(1),
@VAR_PSA_AUXILIAIRE varchar(17),
@VAR_PSA_TELEPHONE varchar(35),
@VAR_PSA_PORTABLE varchar(35),
@VAR_PSA_COEFFICIENT varchar(3),
@VAR_COEFFICIENT_SALARIE varchar(35),
@VAR_PSA_QUALIFICATION varchar(17),
@VAR_QUALIFICATION_SALARIE varchar(35),
@VAR_PSA_CONDEEMPLOI varchar(50),
@VAR_PSA_LIBELLEEMPLOI char(3),
@VAR_LIBELLE_EMPLOI_SALARIE varchar(35),
@VAR_PSA_HORAIREMOIS real,
@VAR_PSA_HORHEBDO real,
@VAR_CALCUL_HORAIRE_HEBDO float,
@VAR_PSA_CIVILITE char(3),
@VAR_PSA_CONGESPAYES char(1),
@VAR_PSA_SALAIREMOIS1 varchar(35),
@VAR_PSA_SALAIREMOIS2 varchar(35),
@VAR_PSA_SALAIREMOIS3 varchar(35),
@VAR_PSA_SALAIREMOIS4 varchar(35),
@VAR_PSA_SALAIREMOIS5 varchar(35),
@VAR_PSA_TRAVAILN1 char(3),
@VAR_PSA_TRAVAILN2 char(3),
@VAR_PSA_TRAVAILN3 char(3),
@VAR_PSA_TRAVAILN4 char(3),
@VAR_PSA_CODESTATISTQUE char(3),
@VAR_PSA_MOTIFENTREE char(3),
@VAR_PSA_INDICE char(3),
@VAR_PSA_NIVEAU char(3),
@VAR_PSA_PRISEFFECTIF char(1),
@VAR_PSA_UNITEPRISEFF numeric(19,4),
@VAR_PSA_REGIMESS char(3),
@VAR_PSA_DATELIBRE1 datetime,
@VAR_PSA_DATELIBRE2 datetime,
@VAR_PSA_DATELIBRE3 datetime,
@VAR_PSA_DATELIBRE4 datetime,
@VAR_GCB01 char(1),
@VAR_GCB02 char(1),
@VAR_GCB03 char(1),
@VAR_GCB04 char(1),
@VAR_GCB05 char(1),
@VAR_GCB06 char(1),
@VAR_GCB07 char(1),
@VAR_GCB08 char(1),
@VAR_CTA01_VALEUR_HRU char(35),
@VAR_CTA01_VALEUR_HRS char(35),
@VAR_CTA02_VALEUR_HRU char(35),
@VAR_CTA02_VALEUR_HRS char(35),
@VAR_CTA03_VALEUR_HRU char(35),
@VAR_CTA03_VALEUR_HRS char(35),
@VAR_CTA04_VALEUR_HRU char(35),
@VAR_CTA04_VALEUR_HRS char(35),
@VAR_CTA05_VALEUR_HRU char(35),
@VAR_CTA05_VALEUR_HRS char(35),
@VAR_PAR_BOITE1 char(35),
@VAR_PAR_BOITE2 char(35),
@VAR_PAR_BOITE3 char(35),
@VAR_PAR_BOITE4 char(35),
@VAR_PSA_BOLLIBRE1 char(1),
@VAR_PSA_BOLLIBRE2 char(1),
@VAR_PSA_BOLLIBRE3 char(1),
@VAR_PSA_BOLLIBRE4 char(1),
@VAR_PSA_LIBREPCMB1 char(3),
@VAR_PSA_LIBREPCMB2 char(3),
@VAR_PSA_LIBREPCMB3 char(3),
@VAR_PSA_LIBREPCMB4 char(3),
@VAR_PAR_CODESTAT char(35),
@VAR_PAR_TRAVAILN1 char(35),
@VAR_PAR_TRAVAILN2 char(35),
@VAR_PAR_TRAVAILN3 char(35),
@VAR_PAR_TRAVAILN4 char(35),
@VAR_PAR_LIBREN1 char(35),
@VAR_PAR_LIBREN2 char(35),
@VAR_PAR_LIBREN3 char(35),
@VAR_PAR_LIBREN4 char(35),
@VAR_PSA_ORDREAT char(1),
@VAR_PSA_CONDEMPLOI char(3),
@VAR_PSA_DADSPROF char(3),
@VAR_PSA_DADSCAT char(3),
@VAR_PSA_TAUXTEMPSPARTIEL varchar(255),
@VAR_TAUX_TEMPS_PARTIEL_SALARIE char(3),
@VAR_PSA_REGIMEMAL char(3),
@VAR_PSA_REGIMEVIP char(3),
@VAR_PSA_REGIMEAT char(3),
@VAR_PSA_TYPDSNFRAC char(3),
@VAR_PSA_DSNFRACTION char(1),
@VAR_PSA_TYPENATTAUXPAS char(3),
@VAR_PSA_NATURETAUXPAS char(3),
@VAR_PSA_CODEEMPLOI char(4),
@VAR_PSA_CONVENTION varchar(17),
@VAR_PSA_CONVENTION_TEMPORAIRE varchar(17),
@VAR_PSA_ETATBULLETIN char(3),
@VAR_SOCIETE_LIGNE int,--soci�t� en cours
@VAR_SOCIETE_TOTAL int,--total des soci�t�s
@VAR_RAISON_SOCIALE varchar(255),
@VAR_NATURECONTROLE varchar(255),
@VAR_RESULTATCONTROLE varchar(255),
@VAR_COMMENTAIRE varchar(255),
@VAR_CEMP varchar(255),
@VAR_LIGNE_INDIVIDU int,--salari� en cours table individu
@VAR_CMATR varchar(35), --matricule en cours 
@VAR_TOTAL_INDIVIDUS int,--donne le nombre de salari�s par soci�t�s
@VAR_CEMP_SALARIE varchar(35),--CEMP du salari� en cours
@VAR_STATUT_MIGRATION varchar(35),
@VAR_T_NATUREAUXILIAIRE char(3),
@VAR_T_LIBELE varchar(255),
@VAR_T_COLLECTIF varchar(255),
@VAR_T_ABREGE varchar(255),
@VAR_PSA_PAYSNAISSANCE_TEMP char(2),
@VAR_PSA_UNITETRAVAIL char(2),
@VAR_PSA_NATIONALITE_TEMP char(3),
@VAR_PSA_MOTIFSORTIE char(3),
@VAR_CCDEP_TEST char(3),
@VAR_PAR_PLE_PARTAGE char(1),
@VAR_PAR_TABLE_LIBRE_PARTAGE char(1),
@VAR_NOM_TABLE char(8),
@VAR_DADSPROF_TEMP char(2);

SET @VAR_NOM_TABLE='SALARIES'
SET @VAR_T_COLLECTIF='421000'
SET @VAR_T_NATUREAUXILIAIRE='SAL';


SELECT @VAR_LIGNE_INDIVIDU=MIN(IND_LIGNE) FROM VENTILATION_INDIVIDUS;
SELECT @VAR_TOTAL_INDIVIDUS=MAX(IND_LIGNE) FROM VENTILATION_INDIVIDUS;

WHILE @VAR_LIGNE_INDIVIDU<=@VAR_TOTAL_INDIVIDUS  --Boucle par salari�s 
	
BEGIN

SELECT
@VAR_CMATR=IND_MATRICULEHRU,--R�cup�ration du matricule en cours
@VAR_PSA_SIREN=IND_SIREN,--R�cup�ration du SIREN
@VAR_CEMP_SALARIE=IND_CEMP,--r�cup�ration de l'employeur du salari�
@VAR_STATUT_MIGRATION=IND_STATUS, --r�cup�ration du statut de la migration
@VAR_PSA_AUXILIAIRE=IND_AUXILIAIRE, --r�cup�ration du compte auxiliaire
@VAR_PSA_SALARIE=IND_MATRICULEHRS --r�cup�ration du matricule HRS
FROM VENTILATION_INDIVIDUS WHERE IND_LIGNE=@VAR_LIGNE_INDIVIDU; 

IF @VAR_STATUT_MIGRATION='Etape Salaries'
		
	BEGIN

	PRINT 'Soci�t� en cours '+@VAR_CEMP+' soci�t� '+CAST(@VAR_SOCIETE_LIGNE AS VARCHAR(255))+'/'+CAST(@VAR_SOCIETE_TOTAL AS VARCHAR(255))+' le salari� est d�j� migr� '+@VAR_CMATR+' ligne en cours'+CAST(@VAR_LIGNE_INDIVIDU AS VARCHAR(255))+'/'+CAST(@VAR_TOTAL_INDIVIDUS AS VARCHAR(255))

	SET @VAR_LIGNE_INDIVIDU=@VAR_LIGNE_INDIVIDU+1;


	END 

ELSE --si le salari� n'est pas encore migr�

	BEGIN
		
		UPDATE VENTILATION_INDIVIDUS SET IND_STATUS='En cours' WHERE IND_MATRICULEHRU=@VAR_CMATR;

		PRINT 'Le salari� '+@VAR_PSA_SALARIE+'a �t� trait� '+CAST(@VAR_LIGNE_INDIVIDU AS VARCHAR(255))+'/'+CAST(@VAR_TOTAL_INDIVIDUS AS VARCHAR(255))

		--Table source INDIVIDU

			SELECT
			@VAR_PSA_NUMEROSS=CONCAT(NSECU,CSECU), --r�cup�ration du num�ro SS
			@VAR_PSA_PRENOM=LPNOM, --r�cup�ration du pr�nom
			@VAR_PSA_ADRESSE1=LRUES,--r�cup�ration adresse 1
			@VAR_PSA_CODEPOSTAL=CPOST,--r�cup�ration du code postal
			@VAR_PSA_VILLE=LVILS,--r�cup�ration ville
			@VAR_PSA_DATENAISSANCE=CAST(DNAIS AS datetime),--r�cup�ration datetime de naissance
			@VAR_PSA_COMMUNENAISS=LNAIS,--r�cup�ration villet de naissance
			@VAR_PSA_DEPTNAISSANCE=RIGHT(LEFT(NSECU,7),2),--r�cup�ration code postal de naissance dans le num�ro SS
			@VAR_PSA_PAYSNAISSANCE_TEMP=PNAIS,--r�cup�ration pays de naissance
			@VAR_PSA_NATIONALITE_TEMP=LNATI,--r�cup�ration de la nationalit�
			@VAR_SEXE_TRANSCO=CISEX,--code sexe HRU
			@VAR_SITUATIONFAMIL=CSITF,--code situation familiale HRU
			@VAR_PSA_NOMJF=NMFAM,--r�cup�ration du Nom de jeune fille
			@VAR_PSA_LIBELLE=NMUSA,--r�cup�ration du Nom d'usage
			@VAR_PSA_PORTABLE=NTEL2,--r�cup�ration du portable
			@VAR_PSA_TELEPHONE=NTEL1, --r�cup�ration du fixe
			@VAR_HRU_MODE_REGLE=MPAM1--r�cup�ration mode r�glement HRU
			FROM INDIVIDU
			WHERE MATRI=@VAR_CMATR; 

			--Table source VALIDCONTRAT

			SELECT TOP(1)
			@VAR_ETABLISSEMENT_SALARIE=CDETS,--r�cup�ration du code �tablissement HRU
			@VAR_PSA_REGIMEMAL=RGBAS,--r�gime SS de base
			@VAR_PSA_REGIMESS=RGBAS,--r�gime SS de base
			@VAR_PSA_REGIMEAT=RGBAS,--r�gime SS de base
			@VAR_PSA_REGIMEVIP=RGBAS,--r�gime SS de base
			@VAR_PSA_DATEANCIENNETE=CAST(DDANC AS datetime), --r�cup�ration derni�re datetime d'anciennet�
			@VAR_PSA_CODEEMPLOI=CINEM,
			@VAR_PSA_COEFFICIENT=COFFI,--r�cup�ration coefficient HRU
			@VAR_PSA_QUALIFICATION=QUALI,--r�cup�ration qualication HRU
			@VAR_PSA_NIVEAU=NIVEA,--r�cup�ration du niveau HRU
			@VAR_LIBELLE_EMPLOI_SALARIE=LQUAL,--r�cup�ration libell� emploi HRU
			@VAR_PSA_HORAIREMOIS=QHMOI,--r�cup�ration horaire mois
			@VAR_PSA_SALAIREMOIS1=CAST(MSM AS varchar(35)),--r�cup�ration du salaire
			@VAR_TAUX_TEMPS_PARTIEL_SALARIE=APTAC,--taux temps partiel
			@VAR_PSA_DADSCAT=CCATS,
			@VAR_DADSPROF_TEMP=STCON --r�cup�ration du code DADS PROF
			FROM VALIDCONTRAT
			WHERE MATRI=@VAR_CMATR AND CEMP=@VAR_CEMP_SALARIE
			ORDER BY DVCTR DESC; 

			--Table source GENCONTRAT
			
			SELECT TOP(1)
			@VAR_PSA_DATEENTREE=CAST(DENTR AS datetime),--r�cup�ration derni�re datetime d'entr�e
			@VAR_PSA_DATESORTIE=CAST(DDEP AS datetime),--r�cup�ration derni�re datetime de sortie
			@VAR_CCDEP_TEST=CCDEP
			FROM GENCONTRAT
			WHERE MATRI=@VAR_CMATR AND CEMP=@VAR_CEMP_SALARIE
			ORDER BY DENTR DESC;

			--Table source PERMSEJOUR

			SELECT
			@VAR_PSA_CARTESEJOUR=ETCAS,--r�cup�ration carte de s�jour
			@VAR_PSA_DATEEXPIRSEJOUR=CAST(ETFCS AS datetime),--r�cup�ration datetime fin carte de s�jour
			@VAR_PSA_DELIVRPAR=ETCCS--r�cup�ration autorit� carte de s�jour
			FROM PERMSEJOUR
			WHERE MATRI=@VAR_CMATR

			--Table source ENFANTS

			IF EXISTS (SELECT * FROM ENFANTS WHERE MATRI=@VAR_CMATR)--si il existe des enfants dans la table ENFANTS on compte

			BEGIN

				SELECT @VAR_PSA_PERSACHARGE=COUNT(*) FROM ENFANTS WHERE MATRI=@VAR_CMATR; --r�cup�ration du nombre d'enfant
			END

			ELSE --sinon on r�cup�re la donn�e de la table INDIVIDU

			BEGIN
				SELECT @VAR_PSA_PERSACHARGE=NBENF FROM INDIVIDU WHERE MATRI=@VAR_CMATR;
			END
			
			SELECT TOP(1) @VAR_PSA_CONVENTION_TEMPORAIRE=RIGHT(CDCCN,4) FROM VALIDCONTRAT WHERE MATRI=@VAR_CMATR AND CEMP=@VAR_CEMP_SALARIE ORDER BY DVCTR DESC;
			SELECT  @VAR_PSA_CONVENTION=PCV_CONVENTION FROM HR_SPRINT_CONVENTIONCOLL WHERE PCV_IDCC=@VAR_PSA_CONVENTION_TEMPORAIRE;
			SELECT @VAR_PAR_PLE_PARTAGE=PAR_VALEUR FROM PARAMETRES WHERE PAR_NOM='Partage PLE';
												
			--Gestion des correspondances 

			--Gestion du code �tablissement

			SELECT @VAR_PSA_ETABLISSEMENT=TRA_VALEURHRS FROM TRANSCO WHERE TRA_TYPE='Etablissement' AND TRA_VALEURHRU=@VAR_ETABLISSEMENT_SALARIE AND TRA_SIREN=@VAR_PSA_SIREN;--r�cup�ration code �tablissement HRS
			
			--Gestion du code pays de naissance
			SET @VAR_PSA_PAYS='FRA';--Pays mot RHPI ADPY voir si besoin de transco
			IF @VAR_PSA_PAYSNAISSANCE_TEMP='FR'
			SET @VAR_PSA_PAYSNAISSANCE='FRA';
			ELSE 
			SET @VAR_PSA_PAYSNAISSANCE=@VAR_PSA_PAYSNAISSANCE_TEMP; 		
			IF @VAR_PSA_NATIONALITE_TEMP='FR'
			SET @VAR_PSA_NATIONALITE='FRA';
			ELSE 
			SET @VAR_PSA_NATIONALITE=@VAR_PSA_NATIONALITE_TEMP;

			--Gestion du mode de r�glement
			IF @VAR_HRU_MODE_REGLE='4'
			SET @VAR_PSA_MODEREGLE='VIR';
			IF @VAR_HRU_MODE_REGLE='5'
			SET @VAR_PSA_MODEREGLE='CHQ';

			--Gestion du sexe
			SELECT @VAR_PSA_SEXE=COR_VALEURHRS FROM CORRESPONDANCE_HRU_HRS WHERE COR_CHAMPHRU='CISEX' AND COR_VALEURHRU=@VAR_SEXE_TRANSCO;

			--Gestion situation de famille

			IF @VAR_SITUATIONFAMIL='M'
				SET @VAR_PSA_SITUATIONFAMIL='MAR';--mari� 
			IF @VAR_SITUATIONFAMIL='C'
				SET @VAR_PSA_SITUATIONFAMIL='CEL';--celibataire
			IF @VAR_SITUATIONFAMIL='D'
			SET @VAR_PSA_SITUATIONFAMIL='DIV';--divorc�
			IF @VAR_SITUATIONFAMIL='K'
			SET @VAR_PSA_SITUATIONFAMIL='90';--situation inconnue
			IF @VAR_SITUATIONFAMIL='S'
			SET @VAR_PSA_SITUATIONFAMIL='SEP';--s�par�

			
			--Gestion du libell� d'emploi

			IF @VAR_PAR_PLE_PARTAGE='X'--si on partage les libell�s d'emploi
			BEGIN
				SELECT @VAR_PSA_LIBELLEEMPLOI=TRA_VALEURHRS FROM TRANSCO WHERE TRA_VALEURHRU=@VAR_LIBELLE_EMPLOI_SALARIE AND TRA_TYPE='Emploi' AND TRA_SIREN='999999999';--r�cup�ration libell� emploi transco 
			END

			ELSE
			BEGIN
				SELECT @VAR_PSA_LIBELLEEMPLOI=TRA_VALEURHRS FROM TRANSCO WHERE TRA_VALEURHRU=@VAR_LIBELLE_EMPLOI_SALARIE AND TRA_TYPE='Emploi' AND TRA_SIREN=@VAR_PSA_SIREN;--r�cup�ration libell� emploi transco 
			END
			
			--Gestion de l'horaire hebdo

			IF @VAR_PSA_HORAIREMOIS=151.67--si le salari� est � temps plein

			BEGIN
				SET @VAR_PSA_HORHEBDO=35;
			END
			ELSE --si le salari� est � temps partiel
			BEGIN

			SET @VAR_PSA_HORHEBDO=@VAR_PSA_HORAIREMOIS*12/52;

			END

			--Gestion de la civilit�

			IF @VAR_SEXE_TRANSCO='01'
			BEGIN
				SET @VAR_PSA_CIVILITE='MR';
			END
			ELSE
			BEGIN
				SET @VAR_PSA_CIVILITE='MME';
			END

			IF @VAR_TAUX_TEMPS_PARTIEL_SALARIE='100'
			BEGIN
				SET @VAR_PSA_TAUXTEMPSPARTIEL='';
				SET @VAR_PSA_CONDEMPLOI='C';
			END
			ELSE
			BEGIN
				SET @VAR_PSA_TAUXTEMPSPARTIEL=@VAR_TAUX_TEMPS_PARTIEL_SALARIE;
				SET @VAR_PSA_CONDEMPLOI='P';
			END
		
			IF @VAR_DADSPROF_TEMP='07'--si ouvrier
				BEGIN
				SET @VAR_PSA_DADSPROF='01';
				END
			IF  @VAR_DADSPROF_TEMP='06'--si employ�
				BEGIN
				SET @VAR_PSA_DADSPROF='02';
				END
			IF  @VAR_DADSPROF_TEMP='05'--si assimil� cadre
				BEGIN
				SET @VAR_PSA_DADSPROF='29';
				END
			IF  @VAR_DADSPROF_TEMP='04'--si cadre
				BEGIN
				SET @VAR_PSA_DADSPROF='29';
			--Activation des valeurs par default
			SET @VAR_PSA_UNITEPRISEFF=1;
			SET @VAR_PSA_UNITETRAVAIL='07';
			SET @VAR_PSA_MOTIFENTREE='001';
			SET @VAR_PSA_PRISEFFECTIF='X';
			SET @VAR_PSA_CONGESPAYES='X';
			SET @VAR_PSA_SALAIREMOIS2='';
			SET @VAR_PSA_SALAIREMOIS3='';
			SET @VAR_PSA_SALAIREMOIS4='';	
			SET @VAR_PSA_ETATBULLETIN='PBG';			
			SET @VAR_PSA_ORDREAT='1';
			SET @VAR_PSA_TYPDSNFRAC='ETB'
			SET @VAR_PSA_DSNFRACTION='1'; 
			SET @VAR_PSA_TYPENATTAUXPAS='ETB';
			SET @VAR_PSA_NATURETAUXPAS='13';
			SET @VAR_PSA_SALAIREMOIS2='';
			SET @VAR_PSA_SALAIREMOIS3='';
			SET @VAR_PSA_SALAIREMOIS4='';



			IF LEN(@VAR_CCDEP_TEST)=3
				BEGIN
				SELECT @VAR_PSA_MOTIFSORTIE=CCDEP FROM GENCONTRAT WHERE MATRI=@VAR_CMATR AND CEMP=@VAR_CEMP_SALARIE ORDER BY DENTR DESC; 
				END
			ELSE
				BEGIN
				SET @VAR_PSA_MOTIFSORTIE='';
				END
	   
			--Dans la table PARAMETRES on cherche la valeur associ�e aux zones libres
			SELECT @VAR_PAR_CODESTAT=PAR_VALEUR FROM PARAMETRES WHERE PAR_NOM='CODESTAT';
			SELECT @VAR_PAR_TRAVAILN1=PAR_VALEUR FROM PARAMETRES WHERE PAR_NOM='TABLETRAVAILN1';
			SELECT @VAR_PAR_TRAVAILN2=PAR_VALEUR FROM PARAMETRES WHERE PAR_NOM='TABLETRAVAILN2';
			SELECT @VAR_PAR_TRAVAILN3=PAR_VALEUR FROM PARAMETRES WHERE PAR_NOM='TABLETRAVAILN3';
			SELECT @VAR_PAR_TRAVAILN4=PAR_VALEUR FROM PARAMETRES WHERE PAR_NOM='TABLETRAVAILN4';
			
			SELECT @VAR_PAR_TABLE_LIBRE_PARTAGE=PAR_VALEUR FROM PARAMETRES WHERE PAR_NOM='Partage Table libre';
			IF @VAR_PAR_TABLE_LIBRE_PARTAGE='X'--si on partage les tables libres
			BEGIN
				--r�cup�ration de la valeur CTA01
				SELECT @VAR_CTA01_VALEUR_HRU=CTA01 FROM VALIDCONTRAT WHERE MATRI=@VAR_CMATR AND CEMP=@VAR_CEMP_SALARIE ORDER BY DVCTR DESC;
				SELECT @VAR_CTA01_VALEUR_HRS=TRA_VALEURHRS FROM TRANSCO WHERE TRA_TYPE='CTA01' AND TRA_SIREN='999999999' AND TRA_VALEURHRU=@VAR_CTA01_VALEUR_HRU;
				--r�cup�ration de la valeur CTA02
			
				SELECT @VAR_CTA02_VALEUR_HRU=CTA02 FROM VALIDCONTRAT WHERE MATRI=@VAR_CMATR AND CEMP=@VAR_CEMP_SALARIE ORDER BY DVCTR DESC;
				SELECT @VAR_CTA02_VALEUR_HRS=TRA_VALEURHRS FROM TRANSCO WHERE TRA_TYPE='CTA02' AND TRA_SIREN='999999999' AND TRA_VALEURHRU=@VAR_CTA02_VALEUR_HRU;
				
				--r�cup�ration de la valeur CTA03
			
				SELECT @VAR_CTA03_VALEUR_HRU=CTA03 FROM VALIDCONTRAT WHERE MATRI=@VAR_CMATR AND CEMP=@VAR_CEMP_SALARIE ORDER BY DVCTR DESC;
				SELECT @VAR_CTA03_VALEUR_HRS=TRA_VALEURHRS FROM TRANSCO WHERE TRA_TYPE='CTA03' AND TRA_SIREN='999999999' AND TRA_VALEURHRU=@VAR_CTA03_VALEUR_HRU;
				
				--r�cup�ration de la valeur CTA04
			
				SELECT @VAR_CTA04_VALEUR_HRU=CTA03 FROM VALIDCONTRAT WHERE MATRI=@VAR_CMATR AND CEMP=@VAR_CEMP_SALARIE ORDER BY DVCTR DESC;
				SELECT @VAR_CTA04_VALEUR_HRS=TRA_VALEURHRS FROM TRANSCO WHERE TRA_TYPE='CTA04' AND TRA_SIREN='999999999' AND TRA_VALEURHRU=@VAR_CTA04_VALEUR_HRU;

				--r�cup�ration de la valeur CTA05
			
				SELECT @VAR_CTA05_VALEUR_HRU=CTA03 FROM VALIDCONTRAT WHERE MATRI=@VAR_CMATR AND CEMP=@VAR_CEMP_SALARIE ORDER BY DVCTR DESC;
				SELECT @VAR_CTA05_VALEUR_HRS=TRA_VALEURHRS FROM TRANSCO WHERE TRA_TYPE='CTA05' AND TRA_SIREN='999999999' AND TRA_VALEURHRU=@VAR_CTA05_VALEUR_HRU;
			END
			ELSE--si on ne partage pas

			BEGIN
				--r�cup�ration de la valeur CTA01

				SELECT @VAR_CTA01_VALEUR_HRU=CTA01 FROM VALIDCONTRAT WHERE MATRI=@VAR_CMATR AND CEMP=@VAR_CEMP_SALARIE ORDER BY DVCTR DESC;
				SELECT @VAR_CTA01_VALEUR_HRS=TRA_VALEURHRS FROM TRANSCO WHERE TRA_TYPE='CTA01' AND TRA_SIREN=@VAR_PSA_SIREN AND TRA_VALEURHRU=@VAR_CTA01_VALEUR_HRU;
				--r�cup�ration de la valeur CTA02
			
				SELECT @VAR_CTA02_VALEUR_HRU=CTA02 FROM VALIDCONTRAT WHERE MATRI=@VAR_CMATR AND CEMP=@VAR_CEMP_SALARIE ORDER BY DVCTR DESC;
				SELECT @VAR_CTA02_VALEUR_HRS=TRA_VALEURHRS FROM TRANSCO WHERE TRA_TYPE='CTA02' AND TRA_SIREN=@VAR_PSA_SIREN AND TRA_VALEURHRU=@VAR_CTA02_VALEUR_HRU;
				--r�cup�ration de la valeur CTA03
			
				SELECT @VAR_CTA03_VALEUR_HRU=CTA03 FROM VALIDCONTRAT WHERE MATRI=@VAR_CMATR AND CEMP=@VAR_CEMP_SALARIE ORDER BY DVCTR DESC;
				SELECT @VAR_CTA03_VALEUR_HRS=TRA_VALEURHRS FROM TRANSCO WHERE TRA_TYPE='CTA03' AND TRA_SIREN=@VAR_PSA_SIREN AND TRA_VALEURHRU=@VAR_CTA03_VALEUR_HRU;

				--r�cup�ration de la valeur CTA04
			
				SELECT @VAR_CTA04_VALEUR_HRU=CTA04 FROM VALIDCONTRAT WHERE MATRI=@VAR_CMATR AND CEMP=@VAR_CEMP_SALARIE ORDER BY DVCTR DESC;
				SELECT @VAR_CTA04_VALEUR_HRS=TRA_VALEURHRS FROM TRANSCO WHERE TRA_TYPE='CTA04' AND TRA_SIREN=@VAR_PSA_SIREN AND TRA_VALEURHRU=@VAR_CTA04_VALEUR_HRU;

				--r�cup�ration de la valeur CTA05
			
				SELECT @VAR_CTA05_VALEUR_HRU=CTA05 FROM VALIDCONTRAT WHERE MATRI=@VAR_CMATR AND CEMP=@VAR_CEMP_SALARIE ORDER BY DVCTR DESC;
				SELECT @VAR_CTA05_VALEUR_HRS=TRA_VALEURHRS FROM TRANSCO WHERE TRA_TYPE='CTA05' AND TRA_SIREN=@VAR_PSA_SIREN AND TRA_VALEURHRU=@VAR_CTA05_VALEUR_HRU;

			END
			
			IF @VAR_PAR_CODESTAT='CTA01'
			
			BEGIN
				SET @VAR_PSA_CODESTATISTQUE=@VAR_CTA01_VALEUR_HRS;
			END

			IF @VAR_PAR_TRAVAILN1='CTA02'
			BEGIN
				SET @VAR_PSA_TRAVAILN1=@VAR_CTA02_VALEUR_HRS;
			END

			SET @VAR_PSA_DATELIBRE1=01/01/1900;
			SET @VAR_PSA_DATELIBRE2=01/01/1900;
			SET @VAR_PSA_DATELIBRE3=01/01/1900;
			SET @VAR_PSA_DATELIBRE4=01/01/1900;

			--Gestion des boites � cocher


			UPDATE GENCONTRAT SET GCB01='X' WHERE GCB01='O';
			UPDATE GENCONTRAT SET GCB01='-' WHERE GCB01='';
			UPDATE GENCONTRAT SET GCB02='X' WHERE GCB02='O';
			UPDATE GENCONTRAT SET GCB02='-' WHERE GCB02='';
			UPDATE GENCONTRAT SET GCB03='X' WHERE GCB03='O';
			UPDATE GENCONTRAT SET GCB03='-' WHERE GCB03='';
			UPDATE GENCONTRAT SET GCB04='X' WHERE GCB04='O';
			UPDATE GENCONTRAT SET GCB04='-' WHERE GCB04='';
			UPDATE GENCONTRAT SET GCB05='X' WHERE GCB05='O';
			UPDATE GENCONTRAT SET GCB05='-' WHERE GCB05='';
			UPDATE GENCONTRAT SET GCB06='X' WHERE GCB06='O';
			UPDATE GENCONTRAT SET GCB06='-' WHERE GCB06='';
			UPDATE GENCONTRAT SET GCB07='X' WHERE GCB07='O';
			UPDATE GENCONTRAT SET GCB07='-' WHERE GCB07='';
			UPDATE GENCONTRAT SET GCB08='X' WHERE GCB08='O';
			UPDATE GENCONTRAT SET GCB08='-' WHERE GCB08='';

			SELECT TOP(1) @VAR_GCB01=GCB01 FROM GENCONTRAT WHERE MATRI=@VAR_CMATR ORDER BY DENTR DESC;
			SELECT TOP(1) @VAR_GCB02=GCB02 FROM GENCONTRAT WHERE MATRI=@VAR_CMATR ORDER BY DENTR DESC;
			SELECT TOP(1) @VAR_GCB04=GCB04 FROM GENCONTRAT WHERE MATRI=@VAR_CMATR ORDER BY DENTR DESC;
			SELECT TOP(1) @VAR_GCB05=GCB05 FROM GENCONTRAT WHERE MATRI=@VAR_CMATR ORDER BY DENTR DESC;
			SELECT TOP(1) @VAR_GCB06=GCB06 FROM GENCONTRAT WHERE MATRI=@VAR_CMATR ORDER BY DENTR DESC;
			SELECT TOP(1) @VAR_GCB07=GCB07 FROM GENCONTRAT WHERE MATRI=@VAR_CMATR ORDER BY DENTR DESC;
			SELECT TOP(1) @VAR_GCB08=GCB08 FROM GENCONTRAT WHERE MATRI=@VAR_CMATR ORDER BY DENTR DESC;

			
			SELECT @VAR_PAR_BOITE1=PAR_VALEUR FROM PARAMETRES WHERE PAR_NOM='Boite � cocher 1';
			SELECT @VAR_PAR_BOITE2=PAR_VALEUR FROM PARAMETRES WHERE PAR_NOM='Boite � cocher 2';
			SELECT @VAR_PAR_BOITE3=PAR_VALEUR FROM PARAMETRES WHERE PAR_NOM='Boite � cocher 3';
			SELECT @VAR_PAR_BOITE4=PAR_VALEUR FROM PARAMETRES WHERE PAR_NOM='Boite � cocher 4';

			--boite � cocher 1
			
			IF @VAR_PAR_BOITE1='GCB01'
			BEGIN
				SET @VAR_PSA_BOLLIBRE1=@VAR_GCB01;
			END
			IF @VAR_PAR_BOITE1='GCB02'
			BEGIN
				SET @VAR_PSA_BOLLIBRE1=@VAR_GCB02;
			END
			IF @VAR_PAR_BOITE1='GCB03'
			BEGIN
				SET @VAR_PSA_BOLLIBRE1=@VAR_GCB03;
			END
			IF @VAR_PAR_BOITE1='GCB04'
			BEGIN
				SET @VAR_PSA_BOLLIBRE1=@VAR_GCB04;
			END
				IF @VAR_PAR_BOITE1='GCB05'
			BEGIN
				SET @VAR_PSA_BOLLIBRE1=@VAR_GCB05;
			END
				IF @VAR_PAR_BOITE1='GCB06'
			BEGIN
			SET @VAR_PSA_BOLLIBRE1=@VAR_GCB05;
			END
			IF @VAR_PAR_BOITE1='GCB07'
			BEGIN
			SET @VAR_PSA_BOLLIBRE1=@VAR_GCB07;
			END
			IF @VAR_PAR_BOITE1='GCB08'
			BEGIN
			SET @VAR_PSA_BOLLIBRE1=@VAR_GCB08;
			END
			--Boite � coher 2
			IF @VAR_PAR_BOITE2='GCB01'
			BEGIN
			SET @VAR_PSA_BOLLIBRE2=@VAR_GCB01;
			END
			IF @VAR_PAR_BOITE2='GCB02'
			BEGIN
			SET @VAR_PSA_BOLLIBRE2=@VAR_GCB02;
			END
			IF @VAR_PAR_BOITE2='GCB03'
			BEGIN
			SET @VAR_PSA_BOLLIBRE2=@VAR_GCB03;
			END
			IF @VAR_PAR_BOITE2='GCB04'
			BEGIN
			SET @VAR_PSA_BOLLIBRE2=@VAR_GCB04;
			END
			IF @VAR_PAR_BOITE2='GCB05'
			BEGIN
			SET @VAR_PSA_BOLLIBRE2=@VAR_GCB05;
			END
			IF @VAR_PAR_BOITE2='GCB06'
			BEGIN
			SET @VAR_PSA_BOLLIBRE2=@VAR_GCB05;
			END
			IF @VAR_PAR_BOITE2='GCB07'
			BEGIN
			SET @VAR_PAR_BOITE2=@VAR_GCB07;
			END
			IF @VAR_PAR_BOITE2='GCB08'
			BEGIN
			SET @VAR_PSA_BOLLIBRE2=@VAR_GCB08;
			END

			--Boite � coher 3
			IF @VAR_PAR_BOITE3='GCB01'
			BEGIN
			SET @VAR_PSA_BOLLIBRE3=@VAR_GCB01;
			END
			IF @VAR_PAR_BOITE3='GCB02'
			BEGIN
			SET @VAR_PSA_BOLLIBRE3=@VAR_GCB02;
			END
			IF @VAR_PAR_BOITE3='GCB03'
			BEGIN
			SET @VAR_PSA_BOLLIBRE3=@VAR_GCB03;
			END
			IF @VAR_PAR_BOITE3='GCB04'
			BEGIN
			SET @VAR_PSA_BOLLIBRE3=@VAR_GCB04;
			END
			IF @VAR_PAR_BOITE3='GCB05'
			BEGIN
			SET @VAR_PSA_BOLLIBRE3=@VAR_GCB05;
			END
			IF @VAR_PAR_BOITE3='GCB06'
			BEGIN
			SET @VAR_PSA_BOLLIBRE3=@VAR_GCB05;
			END
			IF @VAR_PAR_BOITE3='GCB07'
			BEGIN
			SET @VAR_PSA_BOLLIBRE3=@VAR_GCB07;
			END
			IF @VAR_PAR_BOITE3='GCB08'
			BEGIN
			SET @VAR_PSA_BOLLIBRE3=@VAR_GCB08;
			END

			--Boite � coher 4
			IF @VAR_PAR_BOITE4='GCB01'
			BEGIN
			SET @VAR_PSA_BOLLIBRE4=@VAR_GCB01;
			END
			IF @VAR_PAR_BOITE4='GCB02'
			BEGIN
			SET @VAR_PSA_BOLLIBRE4=@VAR_GCB02;
			END
			IF @VAR_PAR_BOITE4='GCB03'
			BEGIN
			SET @VAR_PSA_BOLLIBRE4=@VAR_GCB03;
			END
			IF @VAR_PAR_BOITE4='GCB04'
			BEGIN
			SET @VAR_PSA_BOLLIBRE4=@VAR_GCB04;
			END
			IF @VAR_PAR_BOITE4='GCB05'
			BEGIN
			SET @VAR_PSA_BOLLIBRE4=@VAR_GCB05;
			END
			IF @VAR_PAR_BOITE4='GCB06'
			BEGIN
			SET @VAR_PSA_BOLLIBRE4=@VAR_GCB05;
			END
			IF @VAR_PAR_BOITE4='GCB07'
			BEGIN
			SET @VAR_PSA_BOLLIBRE4=@VAR_GCB07;
			END
			IF @VAR_PAR_BOITE4='GCB08'
			BEGIN
			SET @VAR_PSA_BOLLIBRE4=@VAR_GCB08;
			END

			INSERT INTO HR_SPRINT_SALARIES
			VALUES (@VAR_PSA_SIREN,@VAR_PSA_SALARIE,@VAR_PSA_NUMEROSS,@VAR_PSA_LIBELLE,@VAR_PSA_NOMJF,@VAR_PSA_PRENOM,@VAR_PSA_ETABLISSEMENT,@VAR_PSA_ADRESSE1,@VAR_PSA_CODEPOSTAL,
			@VAR_PSA_VILLE,@VAR_PSA_PAYS,@VAR_PSA_DATENAISSANCE,@VAR_PSA_COMMUNENAISS,@VAR_PSA_DEPTNAISSANCE,@VAR_PSA_PAYSNAISSANCE,@VAR_PSA_NATIONALITE,
			@VAR_PSA_SEXE,@VAR_PSA_SITUATIONFAMIL,@VAR_PSA_DATEENTREE,@VAR_PSA_DATEANCIENNETE,@VAR_PSA_DATESORTIE,@VAR_PSA_CARTESEJOUR,@VAR_PSA_DATEEXPIRSEJOUR,
			@VAR_PSA_DELIVRPAR,@VAR_PSA_PERSACHARGE,@VAR_PSA_MODEREGLE,@VAR_PSA_AUXILIAIRE,@VAR_PSA_TELEPHONE,@VAR_PSA_PORTABLE,@VAR_PSA_COEFFICIENT,
			@VAR_PSA_QUALIFICATION,@VAR_PSA_CONDEEMPLOI,@VAR_PSA_LIBELLEEMPLOI,@VAR_PSA_CODEEMPLOI,@VAR_PSA_CONVENTION,@VAR_PSA_HORAIREMOIS,@VAR_PSA_CIVILITE,@VAR_PSA_CONGESPAYES,@VAR_PSA_SALAIREMOIS1,@VAR_PSA_SALAIREMOIS2,
			@VAR_PSA_SALAIREMOIS3,@VAR_PSA_SALAIREMOIS4,@VAR_PSA_SALAIREMOIS5,@VAR_PSA_TRAVAILN1,@VAR_PSA_TRAVAILN2,@VAR_PSA_TRAVAILN3,@VAR_PSA_TRAVAILN4,
			@VAR_PSA_CODESTATISTQUE,@VAR_PSA_MOTIFENTREE,@VAR_PSA_INDICE,@VAR_PSA_NIVEAU,@VAR_PSA_PRISEFFECTIF,@VAR_PSA_UNITEPRISEFF,@VAR_PSA_REGIMESS,
			@VAR_PSA_DATELIBRE1,@VAR_PSA_DATELIBRE2,@VAR_PSA_DATELIBRE3,@VAR_PSA_DATELIBRE4,
			@VAR_PSA_BOLLIBRE1,@VAR_PSA_BOLLIBRE2,@VAR_PSA_BOLLIBRE3,@VAR_PSA_BOLLIBRE4,
			@VAR_PSA_LIBREPCMB1,@VAR_PSA_LIBREPCMB2,@VAR_PSA_LIBREPCMB3,@VAR_PSA_LIBREPCMB4,
			@VAR_PSA_ORDREAT,@VAR_PSA_CONDEMPLOI,@VAR_PSA_DADSPROF,@VAR_PSA_DADSCAT,@VAR_PSA_TAUXTEMPSPARTIEL,
			@VAR_PSA_REGIMEMAL,@VAR_PSA_REGIMEVIP,@VAR_PSA_REGIMEAT,@VAR_PSA_TYPDSNFRAC,@VAR_PSA_DSNFRACTION,@VAR_PSA_TYPENATTAUXPAS,@VAR_PSA_NATURETAUXPAS,@VAR_PSA_UNITETRAVAIL,@VAR_PSA_MOTIFSORTIE,@VAR_PSA_HORHEBDO,@VAR_PSA_ETATBULLETIN,@VAR_NOM_TABLE);

			UPDATE VENTILATION_INDIVIDUS SET IND_STATUS='Etape Salaries', IND_REPRISE_HR_SPRINT_SALARIE='X' WHERE IND_MATRICULEHRU=@VAR_CMATR AND IND_CEMP=@VAR_CEMP_SALARIE; --mise � jour du statuts
			
			--alimentation de la table des TIERS

			SET @VAR_T_LIBELE=CONCAT(@VAR_PSA_LIBELLE,' ',@VAR_PSA_PRENOM);
			SET @VAR_T_ABREGE=@VAR_T_LIBELE;

			INSERT INTO HR_SPRINT_TIERS
			VALUES(@VAR_PSA_SIREN,@VAR_PSA_AUXILIAIRE,@VAR_T_NATUREAUXILIAIRE,@VAR_T_LIBELE,@VAR_T_COLLECTIF,@VAR_T_ABREGE,@VAR_PSA_ADRESSE1,
			@VAR_PSA_CODEPOSTAL,@VAR_PSA_VILLE);
								
	SET @VAR_LIGNE_INDIVIDU=@VAR_LIGNE_INDIVIDU+1;
	
	--RAZ des valeurs
	SET @VAR_PSA_SALARIE ='';
	SET @VAR_PSA_NUMEROSS='';
	SET @VAR_PSA_LIBELLE='';
	SET @VAR_PSA_NOMJF='';
	SET @VAR_PSA_PRENOM ='';
	SET @VAR_PSA_ETABLISSEMENT='';
	SET @VAR_ETABLISSEMENT_SALARIE='';
	SET @VAR_PSA_ADRESSE1='';
	SET @VAR_PSA_CODEPOSTAL='';
	SET @VAR_PSA_VILLE='';
	SET @VAR_PSA_PAYS='';
	SET @VAR_PSA_DATENAISSANCE='';
	SET @VAR_PSA_COMMUNENAISS='';
	SET @VAR_PSA_DEPTNAISSANCE='';
	SET @VAR_PSA_PAYSNAISSANCE='';
	SET @VAR_PSA_NATIONALITE='';
	SET @VAR_PSA_SEXE ='';
	SET @VAR_SEXE_TRANSCO='';
	SET @VAR_PSA_SITUATIONFAMIL='';
	SET @VAR_SITUATIONFAMIL=''
	SET @VAR_PSA_DATEENTREE=01/01/1900;
	SET @VAR_PSA_DATEANCIENNETE=01/01/1900;
	SET @VAR_PSA_DATESORTIE=01/01/1900;
	SET @VAR_PSA_CARTESEJOUR='';
	SET @VAR_PSA_DATEEXPIRSEJOUR=01/01/1900;
	SET @VAR_PSA_DELIVRPAR='';
	SET @VAR_PSA_PERSACHARGE=0;
	SET @VAR_PSA_MODEREGLE='';
	SET @VAR_HRU_MODE_REGLE='';
	SET @VAR_PSA_AUXILIAIRE ='';
	SET @VAR_PSA_TELEPHONE='';
	SET @VAR_PSA_PORTABLE='';
	SET @VAR_PSA_COEFFICIENT='';
	SET @VAR_COEFFICIENT_SALARIE='';
	SET @VAR_PSA_QUALIFICATION='';
	SET @VAR_QUALIFICATION_SALARIE='';
	SET @VAR_PSA_CONDEEMPLOI='';
	SET @VAR_PSA_LIBELLEEMPLOI='';
	SET @VAR_LIBELLE_EMPLOI_SALARIE='';
	SET @VAR_PSA_HORAIREMOIS='';
	SET @VAR_PSA_CIVILITE='';
	SET @VAR_PSA_CONGESPAYES='';
	SET @VAR_PSA_SALAIREMOIS1='';
	SET @VAR_PSA_SALAIREMOIS2='';
	SET @VAR_PSA_SALAIREMOIS3='';
	SET @VAR_PSA_SALAIREMOIS4='';
	SET @VAR_PSA_SALAIREMOIS5='';
	SET @VAR_PSA_TRAVAILN1='';
	SET @VAR_PSA_TRAVAILN2='';
	SET @VAR_PSA_TRAVAILN3='';
	SET @VAR_PSA_TRAVAILN4='';
	SET @VAR_PSA_CODESTATISTQUE='';
	SET @VAR_PSA_MOTIFENTREE='';
	SET @VAR_PSA_INDICE='';
	SET @VAR_PSA_NIVEAU='';
	SET @VAR_PSA_PRISEFFECTIF='';
	SET @VAR_PSA_REGIMESS='';
	SET @VAR_PSA_DATELIBRE1=01/01/1900;
	SET @VAR_PSA_DATELIBRE2=1900;
	SET @VAR_PSA_DATELIBRE3=1900;
	SET @VAR_PSA_DATELIBRE4=1900;
	SET @VAR_PSA_BOLLIBRE1='';
	SET @VAR_PSA_BOLLIBRE2='';
	SET @VAR_PSA_BOLLIBRE3='';
	SET @VAR_PSA_BOLLIBRE4='';
	SET @VAR_PSA_LIBREPCMB1='';
	SET @VAR_PSA_LIBREPCMB2='';
	SET @VAR_PSA_LIBREPCMB3='';
	SET @VAR_PSA_LIBREPCMB4='';
	SET @VAR_PSA_ORDREAT='';
	SET @VAR_PSA_CONDEMPLOI='';
	SET @VAR_PSA_DADSPROF='';
	SET @VAR_PSA_DADSCAT='';
	SET @VAR_PSA_TAUXTEMPSPARTIEL='';
	SET @VAR_PSA_REGIMEMAL='';
	SET @VAR_PSA_REGIMEVIP='';
	SET @VAR_PSA_REGIMEAT='';
	SET @VAR_PSA_DSNFRACTION='';
	SET @VAR_PSA_TYPENATTAUXPAS='';
	SET @VAR_PSA_NATURETAUXPAS='';
	
	END
END

--RAZ du compteur salari� pour recommencer
GO

--Gestion des Noms de jeune fille attention sur HR SPRINT le champ PSA_NOMJF doit etre vide pour les hommes et le champ PSA_LIBELLE ne peut pas etre � NULL

UPDATE HR_SPRINT_SALARIES SET PSA_LIBELLE=PSA_NOMJF WHERE PSA_SEXE='M';--recopie les noms de jeune fille sur le champ nom d'usage pour les hommes
UPDATE HR_SPRINT_SALARIES SET PSA_NOMJF='' WHERE PSA_SEXE='M';--RAZ du champ nom de jeune fille pour les hommes
UPDATE HR_SPRINT_SALARIES SET PSA_LIBELLE=PSA_NOMJF WHERE PSA_SEXE='F' AND PSA_LIBELLE='';--on recopie les noms de de jeune fille sur le champ nom d'usage pour les femmes
UPDATE HR_SPRINT_SALARIES SET PSA_HORAIREMOIS=0, PSA_HORHEBDO=0 WHERE PSA_HORAIREMOIS IS NULL --suppression des valeurs � NULL

GO

Print 'Fin reprise des salari�s'