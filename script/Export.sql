:setvar  SIREN
:out .\fichiers_hrs\SALARIES.asc  
SELECT $(COLONNE1),$(COLONNE2),SALARIES,PSA_SALARIE,PSA_NUMEROSS,PSA_LIBELLE,PSA_NOMJF,PSA_PRENOM,PSA_ETABLISSEMENT,PSA_ADRESSE1,PSA_CODEPOSTAL,PSA_VILLE,PSA_PAYS,CONVERT(char(10),PSA_DATENAISSANCE,103),PSA_COMMUNENAISS,PSA_DEPTNAISSANCE,PSA_PAYSNAISSANCE,PSA_NATIONALITE,PSA_SEXE,PSA_SITUATIONFAMIL,CONVERT(char(10),PSA_DATEENTREE,103) AS PSA_DATEENTREE,CONVERT(char(10),PSA_DATEANCIENNETE,103) AS PSA_DATEANCIENNETE,CONVERT(char(10),PSA_DATESORTIE,103) AS PSA_DATESORTIE, PSA_CARTESEJOUR,CONVERT(char(10),PSA_DATEEXPIRSEJOUR,103) AS PSA_DATEEXPIRSEJOUR,PSA_DELIVRPAR,PSA_PERSACHARGE,PSA_MODEREGLE,PSA_AUXILIAIRE,PSA_TELEPHONE,PSA_PORTABLE,PSA_COEFFICIENT,PSA_QUALIFICATION,PSA_CONDEEMPLOI,PSA_LIBELLEEMPLOI,PSA_CODEEMPLOI,PSA_CONVENTION,PSA_HORAIREMOIS,PSA_CIVILITE,PSA_CONGESPAYES,PSA_SALAIREMOIS1,PSA_SALAIREMOIS2,PSA_SALAIREMOIS3,PSA_SALAIREMOIS4,PSA_SALAIREMOIS5,PSA_TRAVAILN1,PSA_TRAVAILN2,PSA_TRAVAILN3,PSA_TRAVAILN4,PSA_CODESTAT,PSA_MOTIFENTREE,PSA_INDICE,PSA_NIVEAU,PSA_PRISEFFECTIF,PSA_UNITEPRISEFF,PSA_REGIMESS,PSA_DATELIBRE1,PSA_DATELIBRE2,PSA_DATELIBRE3,PSA_DATELIBRE4,PSA_BOOLLIBRE1,PSA_BOOLLIBRE2,PSA_BOOLLIBRE3,PSA_BOOLLIBRE4,PSA_LIBREPCMB1,PSA_LIBREPCMB2,PSA_LIBREPCMB3,PSA_LIBREPCMB4,PSA_ORDREAT,PSA_CONDEMPLOI,PSA_DADSPROF,PSA_DADSCAT,PSA_TAUXPARTIEL,PSA_REGIMEMAL,PSA_REGIMEVIP,PSA_REGIMEAT,PSA_TYPDSNFRAC,PSA_DSNFRACTION,PSA_TYPENATTAUXPAS,PSA_NATURETAUXPAS,PSA_UNITETRAVAIL,PSA_MOTIFSORTIE,PSA_HORHEBDO,PSA_ETATBULLETIN FROM HR_SPRINT_SALARIES WHERE PSA_SIREN='$(SIREN)'
!!:GO  

GO  

:setvar  SIREN
:out .\fichiers_hrs\CHOIXCOD.asc
SELECT $(COLONNE1),$(COLONNE2),CHOIXCOD,CC_TYPE,CC_CODE,CC_LIBELLE FROM HR_SPRINT_CHOIXCOD WHERE CC_SIREN=$(SIREN) AND CC_TYPE='PLE';

!!:GO  

GO
:setvar  SIREN
:out .\fichiers_hrs\CONTRATTRAVAIL.asc 
SELECT $(COLONNE1),$(COLONNE2),CONTRATTRAVAIL,PCI_SALARIE,PCI_ORDRE,PCI_TYPECONTRAT,CONVERT(char(10),PCI_DEBUTCONTRAT,103) AS PCI_DEBUTCONTRAT,CONVERT(char(10),PCI_FINCONTRAT,103) AS PCI_FINCONTRAT, PCI_ETABLISSEMENT,PCI_ETABLIEUTRAV,PCI_DNASITUATADM,PCI_PERPAIEMENTSAL,PCI_INTITULCONTRAT,PCI_TYPECDD,PCI_REGIMELOCALDSN,PCI_QUOTITE,PCI_TYPEINSEE,PCI_CODEINSEE,PCI_ANCIENNUM,PCI_PASEXCLU,PCI_DNACODUNITEHOR,PCI_SALARIEREMPL,PCI_LIBELLEEMPLOI,PCI_MOTIFCTINT,PCI_MOTIFSORTIE,PCI_SIRETANCIEN FROM HR_SPRINT_CONTRATTRAVAIL WHERE PCI_SIREN=$(SIREN);
!!:GO  

GO

:setvar  SIREN
:out .\fichiers_hrs\DEPORTSAL.asc  
SELECT $(COLONNE1),$(COLONNE2),DEPORTSAL,PSE_SALARIE,PSE_EMAILPROF FROM HR_SPRINT_DEPORTSAL WHERE PSE_SIREN=$(SIREN);
!!:GO  

GO     

:setvar  SIREN
:out .\fichiers_hrs\SALARIESCOMPL.asc  
SELECT $(COLONNE1),$(COLONNE2),SALARIESCOMPL,PSZ_SALARIE,PSZ_DIGITALIDENT FROM HR_SPRINT_SALARIECOMPL WHERE PSZ_SIREN=$(SIREN);
!!:GO  

GO

:setvar  SIREN
:out .\fichiers_hrs\ENFANTSALARIE.asc  
SELECT $(COLONNE1),$(COLONNE2),ENFANTSALARIE,PEF_SALARIE,PEF_ENFANT,PEF_NOM,PEF_PRENOM,CONVERT(char(10),PEF_DATENAISSANCE,103) AS PEF_DATENAISSANCE,PEF_ACHARGE,PEF_NATIONALITE,PEF_SEXE,PEF_TYPEPARENTAL FROM HR_SPRINT_ENFANTSALARIE WHERE PEF_SIREN=$(SIREN);
!!:GO  

GO    

:setvar  SIREN
:out .\fichiers_hrs\PAIEENCOURS.asc  
SELECT * FROM HR_SPRINT_PAIEENCOURS WHERE PPU_SIREN=$(SIREN);
!!:GO  

GO     

:setvar  SIREN
:out.\fichiers_hrs\HISTOBULLETIN.asc 
SELECT * FROM HR_SPRINT_HISTOBULLETIN WHERE PHD_SIREN=$(SIREN);
!!:GO  

GO    

:setvar  SIREN
:out .\fichiers_hrs\HISTOCUMSAL.asc 
SELECT $(COLONNE1),$(COLONNE2),HISTOCUMSAL,PHC_ETABLISSEMENT,PHC_SALARIE,CONVERT(char(10),PHC_DATEDEBUT,103),CONVERT(char(10),PHC_DATEFIN,103),PHC_REPRISE,PHC_CUMULPAIE,PHC_MONTANT,PHC_TRAVAILN1,PHC_TRAVAILN2,PHC_TRAVAILN3,PHC_TRAVAILN4,PHC_CODESTAT,PHC_LIBREPCMB1,PHC_LIBREPCMB2,PHC_LIBREPCMB3,PHC_LIBREPCMB4 FROM HR_SPRINT_HISTOCUMSAL WHERE PHC_SIREN=$(SIREN);
!!:GO  

GO  

:setvar  SIREN
:out .\fichiers_hrs\ABSENCESALARIE.asc 
SELECT
$(COLONNE1),$(COLONNE2),ABSENCESALARIE
	  ,[PCN_ETABLISSEMENT]
      ,[PCN_SALARIE]
      ,CONVERT(char(10),[PCN_DATEDEBUT],103)
      ,CONVERT(char(10),[PCN_DATEFIN],103)
      ,[PCN_ORDRE]
      ,[PCN_TYPECONGE]
      ,[PCN_SENSABS]
      ,CONVERT(char(10),[PCN_DATEVALIDITE],103)
      ,[PCN_LIBELLE]
      ,CAST([PCN_JOURS] AS real)
      ,[PCN_HEURES]
      ,CAST([PCN_BASE] AS real)
      ,[PCN_DEBUTDJ]
      ,[PCN_FINDJ]
      ,[PCN_TRAVAILN1]
      ,[PCN_TRAVAILN2]
      ,[PCN_TRAVAILN3]
      ,[PCN_TRAVAILN4]
      ,[PCN_TYPEMVT]
      ,[PCN_PERIODECP]
      ,[PCN_PERIODEPY]
      ,[PCN_TYPEIMPUTE]
      ,[PCN_ETATPOSTPAIE]
      ,[PCN_CODETAPE]
      ,[PCN_NBREMOIS] FROM HR_SPRINT_ABSENCESALARIE WHERE PCN_SIREN=$(SIREN);
!!:GO  

GO   

:setvar  SIREN
:out .\fichiers_hrs\PGHISTODETAIL.asc 
SELECT PHD_SALARIE,PHD_ETABLISSEMENT,PHD_PGINFOSMODIF,PHD_PGTYPEHISTO,PHD_NEWVALEUR,PHD_TYPEVALEUR,PHD_TABLETTE,PHD_PGTYPEINFOLS,PHD_DATEAPPLIC,PHD_TRAITEMENTOK,PHD_CODTABL,PHD_CODEPOP,PHD_POPULATION FROM HR_SPRINT_PGHISTODETAIL WHERE PHD_SIREN=$(SIREN);
!!:GO  

GO  

:out .\fichiers_hrs\PARAMETRES.asc 
SELECT * FROM PARAMETRES;
!!:GO  

GO  

:out .\fichiers_hrs\RETENUESALARIE.asc 
SELECT 
$(COLONNE1),$(COLONNE2),RETENUESALAIRE,
[PRE_SALARIE]
      ,[PRE_ORDRE]
      ,[PRE_LIBELLE]
      ,CONVERT(char(10),[PRE_DATEDEBUT],103) AS PRE_DATEDEBUT
      ,CONVERT(char(10),[PRE_DATEFIN],103) AS PRE_DATEFIN
      ,[PRE_MONTANTTOT]
      ,[PRE_ACTIF]
      ,[PRE_RETENUESAL]
      ,[PRE_REMBMAX]
      ,[PRE_MONTANTMENS]
      ,[PRE_NBMOIS]
  FROM [dbo].[HR_SPRINT_RETENUESALAIRE]
  WHERE PRE_SIREN=$(SIREN);

!!:GO  

GO

:out .\fichiers_hrs\RIB.asc 
SELECT 
$(COLONNE1),$(COLONNE2),RIB
	  ,[R_AUXILIAIRE]
      ,[R_NUMERORIB]
      ,[R_PRINCIPAL]
      ,[R_ETABBQ]
      ,[R_GUICHET]
      ,[R_NUMEROCOMPTE]
      ,[R_CLERIB]
      ,[R_CODEIBAN]
      ,[R_CODEBIC]
      ,[R_DOMICILIATION]
      ,[R_SALAIRE]
      ,[R_ACOMPTE]
      ,[R_PAYS]
      ,[R_DEVISE] FROM HR_SPRINT_RIB WHERE R_SIREN=$(SIREN);
!!:GO  

GO
