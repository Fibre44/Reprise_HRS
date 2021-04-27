USE REPRISE_HRU
GO

--Gestion de la table PAIEENCOURS/HISTOBULLETIN/HISTOCUMSAL

--Génération des datetimes de début et de fin zone PPAIE. La colonne est au format AAAAMM la fonction CAST ne peut pas convertir au format datetime

 
UPDATE ENTETEPAIE SET TRANSCO_PPAIE_TEMPORAIRE=CONCAT(PPAIE,'01');--passage au format AAAAMMJJ
UPDATE ENTETEPAIE SET TRANSCO_PPAIE=TRANSCO_PPAIE_TEMPORAIRE;--passage au format datetime 

GO

--Gestion de la datetime de fin TRANSCO_PPAIE_FIN


UPDATE ENTETEPAIE SET TRANSCO_MOIS=MONTH(TRANSCO_PPAIE) FROM ENTETEPAIE

UPDATE ENTETEPAIE SET TRANSCO_PPAIE_FIN=CONCAT(PPAIE,'31') WHERE TRANSCO_MOIS='1' OR TRANSCO_MOIS='3' OR TRANSCO_MOIS='5' OR TRANSCO_MOIS='7' OR TRANSCO_MOIS='8' OR TRANSCO_MOIS='10' OR TRANSCO_MOIS='12';--passage au format datetime time

UPDATE ENTETEPAIE SET TRANSCO_PPAIE_FIN=CONCAT(PPAIE,'30') WHERE TRANSCO_MOIS='4' OR TRANSCO_MOIS='6' OR TRANSCO_MOIS='9' OR TRANSCO_MOIS='11'--passage au format datetime time

UPDATE ENTETEPAIE SET TRANSCO_PPAIE_FIN=CONCAT(PPAIE,'28') WHERE TRANSCO_MOIS='2';--passage au format datetime time



GO

DECLARE --analyse de la table ENTETEPAIE pour trouver les dates des bulletins

@VAR_PPU_SIREN varchar(35),
@VAR_PPU_ETABLISSEMENT char(3),
@VAR_PPU_SALARIE varchar(10),
@VAR_PPU_DATEDEBUT datetime,
@VAR_PPU_DATEFIN datetime,
@VAR_PPU_TOPCLOTURE char(1),
@VAR_PPU_TRAVAILN1 char(3),
@VAR_PPU_TRAVAILN2 char(3),
@VAR_PPU_TRAVAILN3 char(3),
@VAR_PPU_TRAVAILN4 char(3),
@VAR_PPU_CODESTAT char(3),
@VAR_PPU_NUMEROSS varchar(35),
@VAR_PPU_LIBELLE varchar(35),
@VAR_PPU_PRENOM varchar(35),
@VAR_PPU_ADRESSE1 varchar(35),
@VAR_PPU_ADRESSE2 varchar(35),
@VAR_PPU_ADRESSE3 varchar(35),
@VAR_PPU_CODEPOSTAL varchar(9),
@VAR_PPU_VILLE varchar(35),
@VAR_PPU_INDICE varchar(17),
@VAR_PPU_NIVEAU varchar(17),
@VAR_PPU_CONVENTION varchar(17),
@VAR_PPU_CODDEMPLOI varchar(4),
@VAR_PPU_AUXILIAIRE varchar(17),
@VAR_PPU_LIBREPCMB1 char(3),
@VAR_PPU_LIBREPCMB2 char(3),
@VAR_PPU_LIBREPCMB3 char(3),
@VAR_PPU_LIBREPCMB4 char(3),
@VAR_PPU_QUALIFICATION char(3),
@VAR_PPU_COEFFICIENT char(3),
@VAR_PPU_LIBELLEEMPLOI char(3),
@VAR_PPU_DATEENTREE datetime,
@VAR_PPU_DATESORTIE datetime,
@VAR_PPU_TRENTIEMEMOD char(1),
@VAR_PPU_DENOMINTRENT int,
@VAR_PPU_NUMERATTRENT int,
@VAR_PPU_CIVILITE char(3),
@VAR_NOM_TABLE char(11);

SET @VAR_NOM_TABLE='PAIEENCOURS';
SET @VAR_PPU_TOPCLOTURE='X';

DECLARE PAIEENCOURS_CURSOR CURSOR FOR

SELECT  IND_SIREN,PSA_ETABLISSEMENT,IND_MATRICULEHRS,TRANSCO_PPAIE,TRANSCO_PPAIE_FIN,PSA_TRAVAILN1,PSA_TRAVAILN2,PSA_TRAVAILN3,PSA_TRAVAILN4,PSA_CODESTAT,PSA_NUMEROSS,PSA_LIBELLE,PSA_PRENOM,PSA_ADRESSE1,PSA_CODEPOSTAL,PSA_VILLE,
PSA_INDICE,PSA_NIVEAU,PSA_CONVENTION,PSA_CODEEMPLOI,PSA_AUXILIAIRE,PSA_LIBREPCMB1,PSA_LIBREPCMB2,PSA_LIBREPCMB3,PSA_LIBREPCMB4,PSA_QUALIFICATION,PSA_COEFFICIENT,PSA_LIBELLEEMPLOI,PSA_DATEENTREE,PSA_DATESORTIE,PSA_CIVILITE
FROM ENTETEPAIE
LEFT JOIN VENTILATION_INDIVIDUS ON MATRI=IND_MATRICULEHRU AND IND_CEMP=CEMP
LEFT JOIN HR_SPRINT_SALARIES ON IND_MATRICULEHRS=PSA_SALARIE AND IND_SIREN=PSA_SIREN
GROUP BY IND_SIREN,PSA_ETABLISSEMENT,IND_MATRICULEHRS,TRANSCO_PPAIE,TRANSCO_PPAIE_FIN,PSA_TRAVAILN1,PSA_TRAVAILN2,PSA_TRAVAILN3,PSA_TRAVAILN4,PSA_CODESTAT,PSA_NUMEROSS,PSA_LIBELLE,PSA_PRENOM,PSA_ADRESSE1,PSA_CODEPOSTAL,PSA_VILLE,
PSA_INDICE,PSA_NIVEAU,PSA_CONVENTION,PSA_CODEEMPLOI,PSA_AUXILIAIRE,PSA_LIBREPCMB1,PSA_LIBREPCMB2,PSA_LIBREPCMB3,PSA_LIBREPCMB4,PSA_QUALIFICATION,PSA_COEFFICIENT,PSA_LIBELLEEMPLOI,PSA_DATEENTREE,PSA_DATESORTIE,PSA_CIVILITE;

OPEN PAIEENCOURS_CURSOR
FETCH NEXT FROM PAIEENCOURS_CURSOR
INTO @VAR_PPU_SIREN,@VAR_PPU_ETABLISSEMENT,@VAR_PPU_SALARIE,@VAR_PPU_DATEDEBUT,@VAR_PPU_DATEFIN,@VAR_PPU_TRAVAILN1,@VAR_PPU_TRAVAILN2,@VAR_PPU_TRAVAILN3,@VAR_PPU_TRAVAILN4,@VAR_PPU_CODESTAT,@VAR_PPU_NUMEROSS,@VAR_PPU_LIBELLE,@VAR_PPU_PRENOM,@VAR_PPU_ADRESSE1,@VAR_PPU_CODEPOSTAL,@VAR_PPU_VILLE,
	@VAR_PPU_INDICE,@VAR_PPU_NIVEAU,@VAR_PPU_CONVENTION,@VAR_PPU_CODDEMPLOI,@VAR_PPU_AUXILIAIRE,@VAR_PPU_LIBREPCMB1,@VAR_PPU_LIBREPCMB2,@VAR_PPU_LIBREPCMB3,@VAR_PPU_LIBREPCMB4,@VAR_PPU_QUALIFICATION,@VAR_PPU_COEFFICIENT,@VAR_PPU_LIBELLEEMPLOI,@VAR_PPU_DATEENTREE,@VAR_PPU_DATESORTIE,@VAR_PPU_CIVILITE;

WHILE @@FETCH_STATUS = 0  

BEGIN

	INSERT INTO HR_SPRINT_PAIEENCOURS
	VALUES(@VAR_PPU_SIREN,@VAR_PPU_ETABLISSEMENT,@VAR_PPU_SALARIE,@VAR_PPU_DATEDEBUT,@VAR_PPU_DATEFIN,@VAR_PPU_TOPCLOTURE,@VAR_PPU_TRAVAILN1,@VAR_PPU_TRAVAILN2,@VAR_PPU_TRAVAILN3,@VAR_PPU_TRAVAILN4,@VAR_PPU_CODESTAT,@VAR_PPU_NUMEROSS,@VAR_PPU_LIBELLE,@VAR_PPU_PRENOM,@VAR_PPU_ADRESSE1,@VAR_PPU_ADRESSE2,@VAR_PPU_ADRESSE3,@VAR_PPU_CODEPOSTAL,@VAR_PPU_VILLE,
	@VAR_PPU_INDICE,@VAR_PPU_NIVEAU,@VAR_PPU_CONVENTION,@VAR_PPU_CODDEMPLOI,@VAR_PPU_AUXILIAIRE,@VAR_PPU_LIBREPCMB1,@VAR_PPU_LIBREPCMB2,@VAR_PPU_LIBREPCMB3,@VAR_PPU_LIBREPCMB4,@VAR_PPU_QUALIFICATION,@VAR_PPU_COEFFICIENT,@VAR_PPU_LIBELLEEMPLOI,@VAR_PPU_DATEENTREE,@VAR_PPU_DATESORTIE,@VAR_PPU_TRENTIEMEMOD,@VAR_PPU_DENOMINTRENT,@VAR_PPU_NUMERATTRENT,@VAR_PPU_CIVILITE,@VAR_NOM_TABLE);

	FETCH NEXT FROM PAIEENCOURS_CURSOR
	INTO @VAR_PPU_SIREN,@VAR_PPU_ETABLISSEMENT,@VAR_PPU_SALARIE,@VAR_PPU_DATEDEBUT,@VAR_PPU_DATEFIN,@VAR_PPU_TRAVAILN1,@VAR_PPU_TRAVAILN2,@VAR_PPU_TRAVAILN3,@VAR_PPU_TRAVAILN4,@VAR_PPU_CODESTAT,@VAR_PPU_NUMEROSS,@VAR_PPU_LIBELLE,@VAR_PPU_PRENOM,@VAR_PPU_ADRESSE1,@VAR_PPU_CODEPOSTAL,@VAR_PPU_VILLE,
	@VAR_PPU_INDICE,@VAR_PPU_NIVEAU,@VAR_PPU_CONVENTION,@VAR_PPU_CODDEMPLOI,@VAR_PPU_AUXILIAIRE,@VAR_PPU_LIBREPCMB1,@VAR_PPU_LIBREPCMB2,@VAR_PPU_LIBREPCMB3,@VAR_PPU_LIBREPCMB4,@VAR_PPU_QUALIFICATION,@VAR_PPU_COEFFICIENT,@VAR_PPU_LIBELLEEMPLOI,@VAR_PPU_DATEENTREE,@VAR_PPU_DATESORTIE,@VAR_PPU_CIVILITE;
	
END

CLOSE PAIEENCOURS_CURSOR;  
DEALLOCATE PAIEENCOURS_CURSOR; 

GO

--Reprise des rubriques dans SPRINT on peut utiliser un code rubrique dans les REM et dans les COT. On Utilise le champ @VAR_PHB_NATURERUB pour faire la différence

--@VAR_PHB_NATURERUB = AAA = Rémunération
--@VAR_PHB_NATURERUB = COT = Cotisation

--Dans la transco SYNAPPS on indiquera RXXXX pour les rubriques de REM et CXXXX pour les cotisations

--Gestion des rubriques de rémunération

DECLARE

@VAR_PHB_SIREN varchar(35),
@VAR_PHB_ETABLISSEMENT char(3),--obligatoire
@VAR_PHB_SALARIE varchar(10),--obligatoire
@VAR_PHB_DATEDEBUT date,--obligatoire
@VAR_PHB_DATEFIN date,--obligatoire
@VAR_PHB_NATURERUB char(3),--obligatoire
@VAR_PHB_RUBRIQUE char(5),--obligatoire
@VAR_PHB_LIBELLE varchar(35),
@VAR_PHB_IMPRIMABLE char(1),--obligatoire
@VAR_PHB_BASEREM varchar(255),
@VAR_PHB_TAUXREM varchar(255),
@VAR_PHB_COEFFREM varchar(255),
@VAR_PHB_MTREM varchar(255),
@VAR_PHB_BASECOT varchar(255),
@VAR_PHB_TAUXSALARIAL varchar(255),
@VAR_PHB_MTSALARIAL varchar(255),
@VAR_PHB_TAUXPATRONAL varchar(255),
@VAR_PHB_MTPATRONAL varchar(255),
@VAR_PHB_TRAVAILN1 char (3),
@VAR_PHB_TRAVAILN2 char (3),
@VAR_PHB_TRAVAILN3 char (3),
@VAR_PHB_TRAVAILN4 char (3),
@VAR_PHB_CODESTAT char(3),
@VAR_PHB_LIBREPCMB1 char(3),
@VAR_PHB_LIBREPCMB2 char(3),
@VAR_PHB_LIBREPCMB3 char(3),
@VAR_PHB_LIBREPCMB4 char(3),
@VAR_NOM_TABLE char(13);

SET @VAR_NOM_TABLE='HISTOBULLETIN';
SET @VAR_PHB_LIBELLE='Reprise Rémunération';
SET @VAR_PHB_NATURERUB='AAA';
SET @VAR_PHB_IMPRIMABLE='X';


DECLARE HISTOBULLETIN_REMUNERATION_CURSOR CURSOR FOR
SELECT IND_SIREN,PSA_ETABLISSEMENT,IND_MATRICULEHRS,TRANSCO_PPAIE,TRANSCO_PPAIE_FIN,NRUB,BASE,TAUXS,MONTS,PSA_TRAVAILN1,PSA_TRAVAILN2,PSA_TRAVAILN3,PSA_TRAVAILN4,PSA_CODESTAT,PSA_LIBREPCMB1,PSA_LIBREPCMB2,PSA_LIBREPCMB3,PSA_LIBREPCMB4
FROM VENTILATION_INDIVIDUS
LEFT JOIN ENTETEPAIE ON MATRI=IND_MATRICULEHRU AND CEMP=IND_CEMP
LEFT JOIN HR_SPRINT_SALARIES ON IND_MATRICULEHRS=PSA_SALARIE AND IND_SIREN=PSA_SIREN
WHERE LEN(NRUB)>4 AND LEFT (NRUB,1)='R';

OPEN HISTOBULLETIN_REMUNERATION_CURSOR
FETCH NEXT FROM HISTOBULLETIN_REMUNERATION_CURSOR
INTO @VAR_PHB_SIREN,@VAR_PHB_ETABLISSEMENT,@VAR_PHB_SALARIE,@VAR_PHB_DATEDEBUT,@VAR_PHB_DATEFIN,@VAR_PHB_RUBRIQUE,@VAR_PHB_BASEREM,@VAR_PHB_TAUXREM,@VAR_PHB_MTREM,@VAR_PHB_TRAVAILN1,@VAR_PHB_TRAVAILN2,@VAR_PHB_TRAVAILN3,@VAR_PHB_TRAVAILN4,@VAR_PHB_CODESTAT,@VAR_PHB_LIBREPCMB1,@VAR_PHB_LIBREPCMB2,@VAR_PHB_LIBREPCMB3,@VAR_PHB_LIBREPCMB4;

WHILE @@FETCH_STATUS = 0 

	BEGIN--début de la boucle
		
	INSERT INTO HR_SPRINT_HISTOBULLETIN
	VALUES (@VAR_PHB_SIREN,@VAR_PHB_ETABLISSEMENT,@VAR_PHB_SALARIE,@VAR_PHB_DATEDEBUT,@VAR_PHB_DATEFIN,@VAR_PHB_NATURERUB,@VAR_PHB_RUBRIQUE,@VAR_PHB_LIBELLE,@VAR_PHB_IMPRIMABLE,@VAR_PHB_BASEREM,@VAR_PHB_TAUXREM,@VAR_PHB_COEFFREM,--
	@VAR_PHB_MTREM,@VAR_PHB_BASECOT,@VAR_PHB_TAUXSALARIAL,@VAR_PHB_MTSALARIAL,@VAR_PHB_TAUXPATRONAL,@VAR_PHB_MTPATRONAL,@VAR_PHB_TRAVAILN1,@VAR_PHB_TRAVAILN2,@VAR_PHB_TRAVAILN3,@VAR_PHB_TRAVAILN4,@VAR_PHB_CODESTAT,@VAR_PHB_LIBREPCMB1,
	@VAR_PHB_LIBREPCMB2,@VAR_PHB_LIBREPCMB3,@VAR_PHB_LIBREPCMB4,@VAR_NOM_TABLE,'','','','','','','');
	
	FETCH NEXT FROM HISTOBULLETIN_REMUNERATION_CURSOR
	INTO @VAR_PHB_SIREN,@VAR_PHB_ETABLISSEMENT,@VAR_PHB_SALARIE,@VAR_PHB_DATEDEBUT,@VAR_PHB_DATEFIN,@VAR_PHB_RUBRIQUE,@VAR_PHB_BASEREM,@VAR_PHB_TAUXREM,@VAR_PHB_MTREM,@VAR_PHB_TRAVAILN1,@VAR_PHB_TRAVAILN2,@VAR_PHB_TRAVAILN3,@VAR_PHB_TRAVAILN4,@VAR_PHB_CODESTAT,@VAR_PHB_LIBREPCMB1,@VAR_PHB_LIBREPCMB2,@VAR_PHB_LIBREPCMB3,@VAR_PHB_LIBREPCMB4;
			
	END --fin de boucle
CLOSE HISTOBULLETIN_REMUNERATION_CURSOR;  
DEALLOCATE HISTOBULLETIN_REMUNERATION_CURSOR; 
Go

--Gestion des cotisations

DECLARE

@VAR_PHB_SIREN varchar(35),
@VAR_PHB_ETABLISSEMENT char(3),--obligatoire
@VAR_PHB_SALARIE varchar(10),--obligatoire
@VAR_PHB_DATEDEBUT date,--obligatoire
@VAR_PHB_DATEFIN date,--obligatoire
@VAR_PHB_NATURERUB char(3),--obligatoire
@VAR_PHB_RUBRIQUE char(5),--obligatoire
@VAR_PHB_LIBELLE varchar(35),
@VAR_PHB_IMPRIMABLE char(1),--obligatoire
@VAR_PHB_BASEREM varchar(255),
@VAR_PHB_TAUXREM varchar(255),
@VAR_PHB_COEFFREM varchar(255),
@VAR_PHB_MTREM varchar(255),
@VAR_PHB_BASECOT varchar(255),
@VAR_PHB_TAUXSALARIAL varchar(255),
@VAR_PHB_MTSALARIAL varchar(255),
@VAR_PHB_TAUXPATRONAL varchar(255),
@VAR_PHB_MTPATRONAL varchar(255),
@VAR_PHB_TRAVAILN1 char (3),
@VAR_PHB_TRAVAILN2 char (3),
@VAR_PHB_TRAVAILN3 char (3),
@VAR_PHB_TRAVAILN4 char (3),
@VAR_PHB_CODESTAT char(3),
@VAR_PHB_LIBREPCMB1 char(3),
@VAR_PHB_LIBREPCMB2 char(3),
@VAR_PHB_LIBREPCMB3 char(3),
@VAR_PHB_LIBREPCMB4 char(3),
@VAR_NOM_TABLE char(13),
@VAR_PHB_PLAFOND real,
@VAR_PHB_PLAFOND1 real,
@VAR_PHB_PLAFOND2 real,
@VAR_PHB_PLAFOND3 real,
@VAR_PHB_TRANCHE1 real,
@VAR_PHB_TRANCHE2 real,
@VAR_PHB_TRANCHE3 real,
@VAR_IND_MATRICULEHRU varchar(50),
@VAR_IND_CEMP varchar(9),
@VAR_CONTROLE_BASE real,
@VAR_ANOMALIES_COMMENTAIRES varchar(255);

SET @VAR_PHB_LIBELLE='Reprise Cotisation';
SET @VAR_PHB_NATURERUB='COT';
SET @VAR_PHB_IMPRIMABLE='X';
SET @VAR_NOM_TABLE='HISTOBULLETIN'

DECLARE HISTOBULLETIN_COTISATION_CURSOR CURSOR FOR
SELECT IND_SIREN,PSA_ETABLISSEMENT,IND_MATRICULEHRS,TRANSCO_PPAIE,TRANSCO_PPAIE_FIN,NRUB,BASE,TAUXS,MONTS,PSA_TRAVAILN1,PSA_TRAVAILN2,PSA_TRAVAILN3,PSA_TRAVAILN4,PSA_CODESTAT,PSA_LIBREPCMB1,PSA_LIBREPCMB2,PSA_LIBREPCMB3,PSA_LIBREPCMB4,IND_MATRICULEHRU,IND_CEMP
FROM VENTILATION_INDIVIDUS
LEFT JOIN ENTETEPAIE ON MATRI=IND_MATRICULEHRU AND CEMP=IND_CEMP
LEFT JOIN HR_SPRINT_SALARIES ON IND_MATRICULEHRS=PSA_SALARIE AND IND_SIREN=PSA_SIREN
WHERE LEN(NRUB)>4 AND LEFT(NRUB,1)='C' OR LEFT(NRUB,1)='B';

OPEN HISTOBULLETIN_COTISATION_CURSOR
FETCH NEXT FROM HISTOBULLETIN_COTISATION_CURSOR
INTO @VAR_PHB_SIREN,@VAR_PHB_ETABLISSEMENT,@VAR_PHB_SALARIE,@VAR_PHB_DATEDEBUT,@VAR_PHB_DATEFIN,@VAR_PHB_RUBRIQUE,@VAR_PHB_BASECOT,@VAR_PHB_TAUXREM,@VAR_PHB_MTREM,@VAR_PHB_TRAVAILN1,@VAR_PHB_TRAVAILN2,@VAR_PHB_TRAVAILN3,@VAR_PHB_TRAVAILN4,@VAR_PHB_CODESTAT,@VAR_PHB_LIBREPCMB1,@VAR_PHB_LIBREPCMB2,@VAR_PHB_LIBREPCMB3,@VAR_PHB_LIBREPCMB4,@VAR_IND_MATRICULEHRU,@VAR_IND_CEMP;

WHILE @@FETCH_STATUS = 0 

BEGIN

	IF LEFT (@VAR_PHB_RUBRIQUE,1)='C'
	BEGIN
		SET @VAR_PHB_NATURERUB='COT';
	END	
	ELSE
	BEGIN
		SET @VAR_PHB_NATURERUB='BAS';

		IF @VAR_PHB_RUBRIQUE<>'B0050' AND @VAR_PHB_RUBRIQUE<>'B0052' AND @VAR_PHB_NATURERUB='BAS'

		BEGIN
			SELECT @VAR_PHB_PLAFOND=BASE FROM ENTETEPAIE WHERE NRUB='B0050' AND MATRI=@VAR_IND_MATRICULEHRU AND @VAR_PHB_DATEFIN=TRANSCO_PPAIE_FIN AND CEMP=@VAR_IND_CEMP;--rubrique de plafond SS
			SET @VAR_PHB_PLAFOND1=@VAR_PHB_PLAFOND;
			SET @VAR_PHB_PLAFOND2=@VAR_PHB_PLAFOND*3;
			SET @VAR_PHB_PLAFOND3=@VAR_PHB_PLAFOND*4;

			PRINT 'Le plafond SS est de '+CAST(@VAR_PHB_PLAFOND as varchar(255))+' le montant brut est de '+CAST(@VAR_PHB_BASECOT as varchar(255))

			IF CAST(@VAR_PHB_BASECOT as real)<@VAR_PHB_PLAFOND -- alors rémunération < plafond SS
			BEGIN
				SET @VAR_PHB_TRANCHE1=@VAR_PHB_BASECOT;
				SET @VAR_PHB_TRANCHE2='';
				SET @VAR_PHB_TRANCHE3='';
			END
			IF CAST(@VAR_PHB_BASECOT as real)>@VAR_PHB_PLAFOND AND CAST(@VAR_PHB_BASECOT as real)<(@VAR_PHB_PLAFOND1+@VAR_PHB_PLAFOND2)-- alors rémunération < plafond T2
			BEGIN
				SET @VAR_PHB_TRANCHE1=@VAR_PHB_PLAFOND;
				SET @VAR_PHB_TRANCHE2=CAST(@VAR_PHB_BASECOT as real)-@VAR_PHB_PLAFOND;
				SET @VAR_PHB_TRANCHE3='';
			END
			IF CAST(@VAR_PHB_BASECOT as real)>@VAR_PHB_PLAFOND AND CAST(@VAR_PHB_BASECOT as real)>(@VAR_PHB_PLAFOND1+@VAR_PHB_PLAFOND2)-- alors rémunération > plafond T2 
			BEGIN
				SET @VAR_PHB_TRANCHE1=@VAR_PHB_PLAFOND;

				IF CAST(@VAR_PHB_BASECOT as real)>@VAR_PHB_PLAFOND2 -- si > T2
				BEGIN
					SET @VAR_PHB_TRANCHE2=@VAR_PHB_PLAFOND2
					SET @VAR_PHB_TRANCHE3=CAST(@VAR_PHB_BASECOT as real)-@VAR_PHB_TRANCHE2-@VAR_PHB_TRANCHE1;
				END

				ELSE --si >T1 <T3
				BEGIN
					SET @VAR_PHB_TRANCHE2=CAST(@VAR_PHB_BASECOT as real)-@VAR_PHB_TRANCHE1;
				END
			END
			--controle des tranches
			SET @VAR_CONTROLE_BASE=@VAR_PHB_TRANCHE1+@VAR_PHB_TRANCHE2+@VAR_PHB_TRANCHE3;

			IF CAST(@VAR_PHB_BASECOT as real)!=@VAR_CONTROLE_BASE --si controle ko
			BEGIN
				Print 'Controle des bases pour le matricule '+@VAR_PHB_SALARIE+' est ko sur le mois '+Cast(@VAR_PHB_DATEDEBUT as varchar(255))

				SET @VAR_ANOMALIES_COMMENTAIRES='Erreur '+@VAR_PHB_SALARIE+' est ko sur le mois '+Cast(@VAR_PHB_DATEDEBUT as varchar(255))+' le brut est de '+@VAR_PHB_BASECOT+' le total des tranches :'+cast(@VAR_CONTROLE_BASE as varchar(255))+' rubrique '+@VAR_PHB_RUBRIQUE;
				INSERT INTO ANOMALIES
				VALUES ('Controle base de cotisation',@VAR_PHB_SALARIE,@VAR_ANOMALIES_COMMENTAIRES)
			END
	
		END-- fin test rubrique base de cotisation avec tranches
		
	END
	
	INSERT INTO HR_SPRINT_HISTOBULLETIN
	VALUES (@VAR_PHB_SIREN,@VAR_PHB_ETABLISSEMENT,@VAR_PHB_SALARIE,@VAR_PHB_DATEDEBUT,@VAR_PHB_DATEFIN,@VAR_PHB_NATURERUB,RIGHT(@VAR_PHB_RUBRIQUE,4),@VAR_PHB_LIBELLE,@VAR_PHB_IMPRIMABLE,@VAR_PHB_BASEREM,@VAR_PHB_TAUXREM,@VAR_PHB_COEFFREM,--
	@VAR_PHB_MTREM,@VAR_PHB_BASECOT,@VAR_PHB_TAUXSALARIAL,@VAR_PHB_MTSALARIAL,@VAR_PHB_TAUXPATRONAL,@VAR_PHB_MTPATRONAL,@VAR_PHB_TRAVAILN1,@VAR_PHB_TRAVAILN2,@VAR_PHB_TRAVAILN3,@VAR_PHB_TRAVAILN4,@VAR_PHB_CODESTAT,@VAR_PHB_LIBREPCMB1,
	@VAR_PHB_LIBREPCMB2,@VAR_PHB_LIBREPCMB3,@VAR_PHB_LIBREPCMB4,@VAR_PHB_PLAFOND,@VAR_PHB_PLAFOND1,@VAR_PHB_PLAFOND2,@VAR_PHB_PLAFOND3,@VAR_PHB_TRANCHE1,@VAR_PHB_TRANCHE2,@VAR_PHB_TRANCHE3,@VAR_NOM_TABLE);
	
	FETCH NEXT FROM HISTOBULLETIN_COTISATION_CURSOR
	INTO @VAR_PHB_SIREN,@VAR_PHB_ETABLISSEMENT,@VAR_PHB_SALARIE,@VAR_PHB_DATEDEBUT,@VAR_PHB_DATEFIN,@VAR_PHB_RUBRIQUE,@VAR_PHB_BASECOT,@VAR_PHB_TAUXREM,@VAR_PHB_MTREM,@VAR_PHB_TRAVAILN1,@VAR_PHB_TRAVAILN2,@VAR_PHB_TRAVAILN3,@VAR_PHB_TRAVAILN4,@VAR_PHB_CODESTAT,@VAR_PHB_LIBREPCMB1,@VAR_PHB_LIBREPCMB2,@VAR_PHB_LIBREPCMB3,@VAR_PHB_LIBREPCMB4,@VAR_IND_MATRICULEHRU,@VAR_IND_CEMP;
			
	--RAZ Valeur

	SET @VAR_PHB_PLAFOND=0;
	SET @VAR_PHB_PLAFOND1=0;
	SET @VAR_PHB_PLAFOND2=0;
	SET @VAR_PHB_PLAFOND3=0;
	SET @VAR_PHB_TRANCHE1=0;
	SET @VAR_PHB_TRANCHE2=0;
	SET @VAR_PHB_TRANCHE3=0;

END
CLOSE HISTOBULLETIN_COTISATION_CURSOR;  
DEALLOCATE HISTOBULLETIN_COTISATION_CURSOR; 
Go
--Gestion des cumuls

DECLARE

@VAR_PHC_SIREN varchar(255),
@VAR_PHC_ETABLISSEMENT char(3),
@VAR_PHC_SALARIE varchar(10),
@VAR_PHC_DATEDEBUT datetime,
@VAR_PHC_DATEFIN datetime,
@VAR_PHC_REPRISE char(1),
@VAR_PHC_CUMULPAIE char(3),
@VAR_PHC_MONTANT varchar(255),
@VAR_PHC_MONTANT_2 varchar(255),
@VAR_PHC_TRAVAILN1 char(3),
@VAR_PHC_TRAVAILN2 char(3),
@VAR_PHC_TRAVAILN3 char(3),
@VAR_PHC_TRAVAILN4 char(3),
@VAR_PHC_CODESTAT char(3),
@VAR_PHC_LIBREPCMB1 char(3),
@VAR_PHC_LIBREPCMB2 char(3),
@VAR_PHC_LIBREPCMB3 char(3),
@VAR_PHC_LIBREPCMB4 char(3),
@VAR_NOM_TABLE char(13);

SET @VAR_NOM_TABLE='HISTOCUMSAL';

SET @VAR_PHC_REPRISE='X';

DECLARE HISTOCUMSAL_CURSOR CURSOR FOR
SELECT IND_SIREN,PSA_ETABLISSEMENT,IND_MATRICULEHRS,TRANSCO_PPAIE,TRANSCO_PPAIE_FIN,NRUB,BASE,MONTS,PSA_TRAVAILN1,PSA_TRAVAILN2,PSA_TRAVAILN3,PSA_TRAVAILN4,PSA_CODESTAT,PSA_LIBREPCMB1,PSA_LIBREPCMB2,PSA_LIBREPCMB3,PSA_LIBREPCMB4
FROM VENTILATION_INDIVIDUS
LEFT JOIN ENTETEPAIE ON MATRI=IND_MATRICULEHRU AND CEMP=IND_CEMP
LEFT JOIN HR_SPRINT_SALARIES ON IND_MATRICULEHRS=PSA_SALARIE AND IND_SIREN=PSA_SIREN
WHERE LEN(NRUB)<=3;

OPEN HISTOCUMSAL_CURSOR
FETCH NEXT FROM HISTOCUMSAL_CURSOR
INTO @VAR_PHC_SIREN,@VAR_PHC_ETABLISSEMENT,@VAR_PHC_SALARIE,@VAR_PHC_DATEDEBUT,@VAR_PHC_DATEFIN,@VAR_PHC_CUMULPAIE,@VAR_PHC_MONTANT,@VAR_PHC_MONTANT_2,@VAR_PHC_TRAVAILN1,@VAR_PHC_TRAVAILN2,@VAR_PHC_TRAVAILN3,@VAR_PHC_TRAVAILN4,@VAR_PHC_CODESTAT,@VAR_PHC_LIBREPCMB1,@VAR_PHC_LIBREPCMB2,@VAR_PHC_LIBREPCMB3,@VAR_PHC_LIBREPCMB4;

WHILE @@FETCH_STATUS = 0 

	BEGIN--début de la boucle

	IF @VAR_PHC_MONTANT_2=''--Dans SPRINT un champ PHC_MONTANT dans HRU on peut alimenter BASE ou MONTS. Si MONTS <> '' alors on alimente MONTS
	BEGIN
		SET @VAR_PHC_MONTANT=@VAR_PHC_MONTANT_2;
	END
	
	IF CAST(@VAR_PHC_MONTANT as real) < 0.00 --Dans SPRINT on ne signe pas les montants
	BEGIN
		SET @VAR_PHC_MONTANT=CAST(@VAR_PHC_MONTANT as real)*-1;
	END

	INSERT INTO HR_SPRINT_HISTOCUMSAL
	VALUES (@VAR_PHC_SIREN,@VAR_PHC_ETABLISSEMENT,@VAR_PHC_SALARIE,@VAR_PHC_DATEDEBUT,@VAR_PHC_DATEFIN,@VAR_PHC_REPRISE,@VAR_PHC_CUMULPAIE,@VAR_PHC_MONTANT,@VAR_PHC_TRAVAILN1,@VAR_PHC_TRAVAILN2,@VAR_PHC_TRAVAILN3,@VAR_PHC_TRAVAILN4,@VAR_PHC_CODESTAT,@VAR_PHC_LIBREPCMB1,@VAR_PHC_LIBREPCMB2,@VAR_PHC_LIBREPCMB3,@VAR_PHC_LIBREPCMB4,@VAR_NOM_TABLE);
	
	FETCH NEXT FROM HISTOCUMSAL_CURSOR
	INTO @VAR_PHC_SIREN,@VAR_PHC_ETABLISSEMENT,@VAR_PHC_SALARIE,@VAR_PHC_DATEDEBUT,@VAR_PHC_DATEFIN,@VAR_PHC_CUMULPAIE,@VAR_PHC_MONTANT,@VAR_PHC_MONTANT_2,@VAR_PHC_TRAVAILN1,@VAR_PHC_TRAVAILN2,@VAR_PHC_TRAVAILN3,@VAR_PHC_TRAVAILN4,@VAR_PHC_CODESTAT,@VAR_PHC_LIBREPCMB1,@VAR_PHC_LIBREPCMB2,@VAR_PHC_LIBREPCMB3,@VAR_PHC_LIBREPCMB4;
			
	END --fin de boucle
CLOSE HISTOCUMSAL_CURSOR;  
DEALLOCATE HISTOCUMSAL_CURSOR; 


Go

--Reprise compteurs

DECLARE

@VAR_PHC_SIREN varchar(255),
@VAR_PHC_ETABLISSEMENT char(3),
@VAR_PHC_SALARIE varchar(10),
@VAR_PHC_DATEDEBUT datetime,
@VAR_PHC_DATEFIN datetime,
@VAR_PHC_REPRISE char(1),
@VAR_PHC_CUMULPAIE char(3),
@VAR_PHC_MONTANT varchar(255),
@VAR_PHC_MONTANT_2 varchar(255),
@VAR_PHC_TRAVAILN1 char(3),
@VAR_PHC_TRAVAILN2 char(3),
@VAR_PHC_TRAVAILN3 char(3),
@VAR_PHC_TRAVAILN4 char(3),
@VAR_PHC_CODESTAT char(3),
@VAR_PHC_LIBREPCMB1 char(3),
@VAR_PHC_LIBREPCMB2 char(3),
@VAR_PHC_LIBREPCMB3 char(3),
@VAR_PHC_LIBREPCMB4 char(3),
@VAR_NOM_TABLE char(13);

SET @VAR_NOM_TABLE='HISTOCUMSAL';

SET @VAR_PHC_REPRISE='X';

DECLARE COMPTEURS_CURSOR CURSOR FOR
SELECT IND_SIREN,PSA_ETABLISSEMENT,IND_MATRICULEHRS,CONCAT(LEFT(DTRES,6),'01') AS DTRES_DEBUT,DTRES,CDRG,VLRES,PSA_TRAVAILN1,PSA_TRAVAILN2,PSA_TRAVAILN3,PSA_TRAVAILN4,PSA_CODESTAT,PSA_LIBREPCMB1,PSA_LIBREPCMB2,PSA_LIBREPCMB3,PSA_LIBREPCMB4
FROM VENTILATION_INDIVIDUS
LEFT JOIN COMPTEURS ON IND_MATRICULEHRU=MATRI AND CEMP=IND_CEMP
LEFT JOIN HR_SPRINT_SALARIES ON IND_MATRICULEHRS=PSA_SALARIE AND IND_SIREN=PSA_SIREN
WHERE LEN(CDRG)=2

OPEN COMPTEURS_CURSOR
FETCH NEXT FROM COMPTEURS_CURSOR
INTO @VAR_PHC_SIREN,@VAR_PHC_ETABLISSEMENT,@VAR_PHC_SALARIE,@VAR_PHC_DATEDEBUT,@VAR_PHC_DATEFIN,@VAR_PHC_CUMULPAIE,@VAR_PHC_MONTANT,@VAR_PHC_TRAVAILN1,@VAR_PHC_TRAVAILN2,@VAR_PHC_TRAVAILN3,@VAR_PHC_TRAVAILN4,@VAR_PHC_CODESTAT,@VAR_PHC_LIBREPCMB1,@VAR_PHC_LIBREPCMB2,@VAR_PHC_LIBREPCMB3,@VAR_PHC_LIBREPCMB4;

WHILE @@FETCH_STATUS = 0 

	BEGIN--début de la boucle

	IF @VAR_PHC_MONTANT_2=''--Dans SPRINT un champ PHC_MONTANT dans HRU on peut alimenter BASE ou MONTS. Si MONTS <> '' alors on alimente MONTS
	BEGIN
		SET @VAR_PHC_MONTANT=@VAR_PHC_MONTANT_2;
	END
		
	INSERT INTO HR_SPRINT_HISTOCUMSAL
	VALUES (@VAR_PHC_SIREN,@VAR_PHC_ETABLISSEMENT,@VAR_PHC_SALARIE,@VAR_PHC_DATEDEBUT,@VAR_PHC_DATEFIN,@VAR_PHC_REPRISE,@VAR_PHC_CUMULPAIE,@VAR_PHC_MONTANT,@VAR_PHC_TRAVAILN1,@VAR_PHC_TRAVAILN2,@VAR_PHC_TRAVAILN3,@VAR_PHC_TRAVAILN4,@VAR_PHC_CODESTAT,@VAR_PHC_LIBREPCMB1,@VAR_PHC_LIBREPCMB2,@VAR_PHC_LIBREPCMB3,@VAR_PHC_LIBREPCMB4,@VAR_NOM_TABLE);
	
	FETCH NEXT FROM COMPTEURS_CURSOR
	INTO @VAR_PHC_SIREN,@VAR_PHC_ETABLISSEMENT,@VAR_PHC_SALARIE,@VAR_PHC_DATEDEBUT,@VAR_PHC_DATEFIN,@VAR_PHC_CUMULPAIE,@VAR_PHC_MONTANT,@VAR_PHC_TRAVAILN1,@VAR_PHC_TRAVAILN2,@VAR_PHC_TRAVAILN3,@VAR_PHC_TRAVAILN4,@VAR_PHC_CODESTAT,@VAR_PHC_LIBREPCMB1,@VAR_PHC_LIBREPCMB2,@VAR_PHC_LIBREPCMB3,@VAR_PHC_LIBREPCMB4;
			
	END --fin de boucle
CLOSE COMPTEURS_CURSOR;  
DEALLOCATE COMPTEURS_CURSOR; 

--suppression des valeurs à NULL

UPDATE HR_SPRINT_PAIEENCOURS SET PPU_TRAVAILN1='' WHERE PPU_TRAVAILN1 IS NULL;
UPDATE HR_SPRINT_PAIEENCOURS SET PPU_TRAVAILN2='' WHERE PPU_TRAVAILN2 IS NULL;
UPDATE HR_SPRINT_PAIEENCOURS SET PPU_TRAVAILN3='' WHERE PPU_TRAVAILN3 IS NULL;
UPDATE HR_SPRINT_PAIEENCOURS SET PPU_TRAVAILN4='' WHERE PPU_TRAVAILN4 IS NULL;
UPDATE HR_SPRINT_PAIEENCOURS SET PPU_CODESTAT='' WHERE PPU_CODESTAT IS NULL;
UPDATE HR_SPRINT_PAIEENCOURS SET PPU_LIBREPCMB1='' WHERE PPU_LIBREPCMB1 IS NULL;
UPDATE HR_SPRINT_PAIEENCOURS SET PPU_LIBREPCMB2='' WHERE PPU_LIBREPCMB2 IS NULL;
UPDATE HR_SPRINT_PAIEENCOURS SET PPU_LIBREPCMB3='' WHERE PPU_LIBREPCMB3 IS NULL;
UPDATE HR_SPRINT_PAIEENCOURS SET PPU_LIBREPCMB4='' WHERE PPU_LIBREPCMB4 IS NULL;

UPDATE HR_SPRINT_HISTOBULLETIN SET PHB_TRAVAILN1='' WHERE PHB_TRAVAILN1 IS NULL;
UPDATE HR_SPRINT_HISTOBULLETIN SET PHB_TRAVAILN2='' WHERE PHB_TRAVAILN2 IS NULL;
UPDATE HR_SPRINT_HISTOBULLETIN SET PHB_TRAVAILN3='' WHERE PHB_TRAVAILN3 IS NULL;
UPDATE HR_SPRINT_HISTOBULLETIN SET PHB_TRAVAILN4='' WHERE PHB_TRAVAILN4 IS NULL;
UPDATE HR_SPRINT_HISTOBULLETIN SET PHB_CODESTAT='' WHERE PHB_CODESTAT IS NULL;
UPDATE HR_SPRINT_HISTOBULLETIN SET PHB_LIBREPCMB1='' WHERE PHB_LIBREPCMB1 IS NULL;
UPDATE HR_SPRINT_HISTOBULLETIN SET PHB_LIBREPCMB2='' WHERE PHB_LIBREPCMB2 IS NULL;
UPDATE HR_SPRINT_HISTOBULLETIN SET PHB_LIBREPCMB3='' WHERE PHB_LIBREPCMB3 IS NULL;
UPDATE HR_SPRINT_HISTOBULLETIN SET PHB_LIBREPCMB4='' WHERE PHB_LIBREPCMB4 IS NULL;

UPDATE HR_SPRINT_HISTOCUMSAL SET PHC_TRAVAILN1='' WHERE PHC_TRAVAILN1 IS NULL;
UPDATE HR_SPRINT_HISTOCUMSAL SET PHC_TRAVAILN2='' WHERE PHC_TRAVAILN2 IS NULL;
UPDATE HR_SPRINT_HISTOCUMSAL SET PHC_TRAVAILN3='' WHERE PHC_TRAVAILN3 IS NULL;
UPDATE HR_SPRINT_HISTOCUMSAL SET PHC_TRAVAILN4='' WHERE PHC_TRAVAILN4 IS NULL;
UPDATE HR_SPRINT_HISTOCUMSAL SET PHC_CODESTAT='' WHERE PHC_CODESTAT IS NULL;
UPDATE HR_SPRINT_HISTOCUMSAL SET PHC_LIBREPCMB1='' WHERE PHC_LIBREPCMB1 IS NULL;
UPDATE HR_SPRINT_HISTOCUMSAL SET PHC_LIBREPCMB2='' WHERE PHC_LIBREPCMB2 IS NULL;
UPDATE HR_SPRINT_HISTOCUMSAL SET PHC_LIBREPCMB3='' WHERE PHC_LIBREPCMB3 IS NULL;
UPDATE HR_SPRINT_HISTOCUMSAL SET PHC_LIBREPCMB4='' WHERE PHC_LIBREPCMB4 IS NULL;


Go

PRINT 'Fin de traitement :-)'
