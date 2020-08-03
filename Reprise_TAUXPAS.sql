USE REPRISE_HRU
GO

--Reprise des taux PAS

DECLARE

@VAR_CMATR varchar(35),
@VAR_PKT_SIREN varchar(35),
@VAR_PKT_NUMEROSS varchar(15),
@VAR_PKT_SALARIE varchar(10),
@VAR_PKT_IDENTIFIANTIND varchar(35),
@VAR_PKT_PERIODE varchar(6),
@VAR_PKT_CRM varchar(18),
@VAR_PKT_DTPUBLICATION datetime,
@VAR_PKT_TAUXDGFIP varchar(5),
@VAR_NATURECONTROLE varchar(255),
@VAR_RESULTATCONTROLE varchar(255),
@VAR_COMMENTAIRE varchar(255),
@VAR_TAUXPAS_LIGNE_EN_COURS int,
@VAR_TAUXPAS_TOTAL int,
@VAR_PAR_TAUXPAS char(1);

SELECT @VAR_PAR_TAUXPAS=PAR_VALEUR FROM PARAMETRES WHERE PAR_NOM='Reprise Taux Pas';--r�cup�ration si on migre la table

SET @VAR_PKT_DTPUBLICATION='01/01/1900';
SET @VAR_NATURECONTROLE='Cr�ation table PASTAUX';
SET @VAR_TAUXPAS_LIGNE_EN_COURS=1;
SELECT @VAR_TAUXPAS_TOTAL=COUNT(*) FROM TAUXPAS;

IF @VAR_PAR_TAUXPAS='X' --si on reprend la table

BEGIN

WHILE @VAR_TAUXPAS_LIGNE_EN_COURS<=@VAR_TAUXPAS_TOTAL

	BEGIN

	SELECT @VAR_CMATR=MATRI FROM TAUXPAS WHERE @VAR_TAUXPAS_LIGNE_EN_COURS=TAUXPAS_LIGNE;--r�cup�ration du Salari� en cours
	SELECT @VAR_PKT_SIREN=IND_SIREN FROM VENTILATION_INDIVIDUS WHERE IND_MATRICULEHRU=@VAR_CMATR;--r�cup�ration du siren du salari�
	SELECT @VAR_PKT_SALARIE=IND_MATRICULEHRS FROM VENTILATION_INDIVIDUS WHERE IND_MATRICULEHRU=@VAR_CMATR;--r�cup�ration du matricule HRS
	SELECT @VAR_PKT_NUMEROSS=PSA_NUMEROSS FROM HR_SPRINT_SALARIES WHERE PSA_SALARIE=@VAR_PKT_SALARIE;--r�cup�ration du code SS
	SELECT @VAR_PKT_PERIODE=PRTAU FROM TAUXPAS WHERE @VAR_TAUXPAS_LIGNE_EN_COURS=TAUXPAS_LIGNE;--r�cup�ration de la p�riode
	SELECT @VAR_PKT_CRM=IDTAU FROM TAUXPAS WHERE @VAR_TAUXPAS_LIGNE_EN_COURS=TAUXPAS_LIGNE;--r�cup�ration du CRM
	SET @VAR_PKT_IDENTIFIANTIND=@VAR_PKT_SALARIE;
	SELECT @VAR_PKT_TAUXDGFIP=VLTAU FROM TAUXPAS WHERE @VAR_TAUXPAS_LIGNE_EN_COURS=TAUXPAS_LIGNE;--r�cup�ration du taux

	INSERT INTO HR_SPRINT_PASTAUX
	VALUES (@VAR_PKT_SIREN,@VAR_PKT_NUMEROSS,@VAR_PKT_SALARIE,@VAR_PKT_IDENTIFIANTIND,@VAR_PKT_PERIODE,@VAR_PKT_CRM,@VAR_PKT_DTPUBLICATION,@VAR_PKT_TAUXDGFIP);

	UPDATE VENTILATION_INDIVIDUS SET IND_STATUS='Etape PAS', IND_REPRISE_HR_SPRINT_PASTAUX='X' WHERE IND_MATRICULEHRU=@VAR_CMATR AND IND_SIREN=@VAR_PKT_SIREN;

	Print 'Cr�ation du taux PAS ligne en cours '+CAST(@VAR_TAUXPAS_LIGNE_EN_COURS as varchar(255))+'/'+CAST(@VAR_TAUXPAS_TOTAL as varchar(255))

	SET @VAR_TAUXPAS_LIGNE_EN_COURS=@VAR_TAUXPAS_LIGNE_EN_COURS+1;
	END
END--Fin de Si

ELSE 

Print 'La table PASTAUX n est pas reprise'

GO

Print 'Fin reprise TAUXPAS'