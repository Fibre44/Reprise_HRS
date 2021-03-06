:setvar  SIREN
:out .\temp\SALARIES.asc  
SELECT $(COLONNE1),$(COLONNE2),SALARIES,PSA_SALARIE,PSA_NUMEROSS,PSA_LIBELLE,PSA_NOMJF,PSA_PRENOM,PSA_ETABLISSEMENT,PSA_ADRESSE1,PSA_ADRESSE2,PSA_ADRESSE3,PSA_CODEPOSTAL,PSA_VILLE,PSA_PAYS,CONVERT(char(10),PSA_DATENAISSANCE,103),PSA_COMMUNENAISS,PSA_DEPTNAISSANCE,PSA_PAYSNAISSANCE,PSA_NATIONALITE,PSA_SEXE,PSA_SITUATIONFAMIL,CONVERT(char(10),PSA_DATEENTREE,103) AS PSA_DATEENTREE,CONVERT(char(10),PSA_DATEANCIENNETE,103) AS PSA_DATEANCIENNETE,CONVERT(char(10),PSA_DATESORTIE,103) AS PSA_DATESORTIE, PSA_CARTESEJOUR,CONVERT(char(10),PSA_DATEXPIRSEJOUR,103) AS PSA_DATEEXPIRSEJOUR,PSA_DELIVPAR,PSA_PERSACHARGE,PSA_MODEREGLE,PSA_AUXILIAIRE,PSA_TELEPHONE,PSA_PORTABLE,PSA_COEFFICIENT,PSA_QUALIFICATION,PSA_CONDEMPLOI,PSA_LIBELLEEMPLOI,PSA_CODEEMPLOI,PSA_CONVENTION,PSA_HORAIREMOIS,PSA_CIVILITE,PSA_CONGESPAYES,PSA_SALAIREMOIS1,PSA_SALAIREMOIS2,PSA_SALAIREMOIS3,PSA_SALAIREMOIS4,PSA_SALAIREMOIS5,PSA_TRAVAILN1,PSA_TRAVAILN2,PSA_TRAVAILN3,PSA_TRAVAILN4,PSA_CODESTAT,PSA_MOTIFENTREE,PSA_INDICE,PSA_NIVEAU,PSA_PRISEFFECTIF,PSA_UNITEPRISEFF,PSA_REGIMESS,PSA_DATELIBRE1,PSA_DATELIBRE2,PSA_DATELIBRE3,PSA_DATELIBRE4,PSA_BOOLLIBRE1,PSA_BOOLLIBRE2,PSA_BOOLLIBRE3,PSA_BOOLLIBRE4,PSA_LIBREPCMB1,PSA_LIBREPCMB2,PSA_LIBREPCMB3,PSA_LIBREPCMB4,PSA_ORDREAT,PSA_CONDEMPLOI,PSA_DADSPROF,PSA_DADSCAT,PSA_TAUXPARTIEL,PSA_REGIMEMAL,PSA_REGIMEVIP,PSA_REGIMEAT,PSA_TYPDSNFRAC,PSA_DSNFRACTION,PSA_TYPENATTAUXPAS,PSA_NATURETAUXPAS,PSA_UNITETRAVAIL,PSA_MOTIFSORTIE,PSA_HORHEBDO,PSA_ETATBULLETIN,PSA_HORANNUEL,PSA_CATDADS,PSA_PROFILREM,PSA_PROFIL,PSA_PROFILPRE,PSA_PROFILMUT,PSA_TYPPROFIL,PSA_TYPPROFILMUT,PSA_TYPPROFILPRE,CONVERT(char(10),PSA_ANCIENPOSTE,103)  FROM SALARIES WHERE PSA_DATESORTIE='01/01/1900'
!!:GO  

GO  

:setvar  SIREN
:out .\temp\CHOIXCOD.asc
SELECT $(COLONNE1),$(COLONNE2),CHOIXCOD,CC_TYPE,CC_CODE,CC_LIBELLE FROM HR_SPRINT_CHOIXCOD WHERE CC_SIREN=$(SIREN) AND CC_TYPE='PLE';

!!:GO  

GO

:setvar  SIREN
:out .\temp\VENTIL.asc
SELECT VEN_TYPE,VEN_CODE,VEN_AXE,VEN_SOUSPLAN,VEN_SECTION,VEN_POURCENTAGE,VEN_NUMEROVENTILATION FROM HR_SPRINT_REPRISEVENTILATIONANALYTIQUE WHERE VEN_SIREN=$(SIREN);

!!:GO  

GO

:setvar  SIREN
:out .\temp\MINIMUMCONVENT.asc
SELECT $(COLONNE1),$(COLONNE2),MINIMUMCONVENT,PMI_NATURE,PMI_CONVENTION,PMI_TYPENATURE,PMI_CODE,PMI_LIBELLE,PMI_PREDEFINI,PMI_NODOSSIER FROM HR_SPRINT_MINIMUMCONVENT;

!!:GO  

GO
:setvar  SIREN
:out .\temp\CONTRATTRAVAIL.asc 
SELECT $(COLONNE1),$(COLONNE2),CONTRATTRAVAIL,PCI_SALARIE,PCI_ORDRE,PCI_TYPECONTRAT,CONVERT(char(10),PCI_DEBUTCONTRAT,103) AS PCI_DEBUTCONTRAT,CONVERT(char(10),PCI_FINCONTRAT,103) AS PCI_FINCONTRAT, PCI_ETABLISSEMENT,PCI_ETABLIEUTRAV,PCI_DNASITUATADM,PCI_PERPAIEMENTSAL,PCI_INTITULCONTRAT,PCI_TYPECDD,PCI_REGIMELOCALDSN,PCI_QUOTITE,PCI_TYPEINSEE,PCI_CODEINSEE,PCI_ANCIENNUM,PCI_PASEXCLU,PCI_DNACODUNITEHOR,PCI_SALARIEREMPL,PCI_LIBELLEEMPLOI,PCI_MOTIFCTINT,PCI_MOTIFSORTIE,PCI_SIRETANCIEN,CONVERT(char(10),PCI_DATEANCSIRET,103),PCI_STATUTBOETH FROM HR_SPRINT_CONTRATTRAVAIL WHERE PCI_SIREN=$(SIREN);
!!:GO  

GO

:setvar  SIREN
:out .\temp\DEPORTSAL.asc  
SELECT $(COLONNE1),$(COLONNE2),DEPORTSAL,PSE_SALARIE,PSE_EMAILPROF FROM HR_SPRINT_DEPORTSAL WHERE PSE_SIREN=$(SIREN);
!!:GO  

GO     

:setvar  SIREN
:out .\temp\SALARIESCOMPL.asc  
SELECT $(COLONNE1),$(COLONNE2),SALARIESCOMPL,PSZ_SALARIE,PSZ_DIGITALIDENT,CONVERT(char(10),[PSZ_ANCIENCOLLEGE],103),CONVERT(char(10),[PSZ_ANCIENGROUPE],103) FROM HR_SPRINT_SALARIECOMPL WHERE PSZ_SIREN=$(SIREN);
!!:GO  

GO

:setvar  SIREN
:out .\temp\ENFANTSALARIE.asc  
SELECT $(COLONNE1),$(COLONNE2),ENFANTSALARIE,PEF_SALARIE,PEF_ENFANT,PEF_NOM,PEF_PRENOM,CONVERT(char(10),PEF_DATENAISSANCE,103) AS PEF_DATENAISSANCE,PEF_ACHARGE,PEF_NATIONALITE,PEF_SEXE,PEF_TYPEPARENTAL FROM HR_SPRINT_ENFANTSALARIE WHERE PEF_SIREN=$(SIREN);
!!:GO  

GO    

:setvar  SIREN
:out .\temp\PAIEENCOURS.asc  
SELECT * FROM HR_SPRINT_PAIEENCOURS WHERE PPU_SIREN=$(SIREN);
!!:GO  

GO     

:setvar  SIREN
:out.\temp\HISTOBULLETIN.asc 
SELECT * FROM HR_SPRINT_HISTOBULLETIN WHERE PHD_SIREN=$(SIREN);
!!:GO  

GO    

:setvar  SIREN
:out .\temp\HISTOCUMSAL.asc 
SELECT $(COLONNE1),$(COLONNE2),HISTOCUMSAL,PHC_ETABLISSEMENT,PHC_SALARIE,CONVERT(char(10),PHC_DATEDEBUT,103),CONVERT(char(10),PHC_DATEFIN,103),PHC_REPRISE,PHC_CUMULPAIE,PHC_MONTANT,PHC_TRAVAILN1,PHC_TRAVAILN2,PHC_TRAVAILN3,PHC_TRAVAILN4,PHC_CODESTAT,PHC_LIBREPCMB1,PHC_LIBREPCMB2,PHC_LIBREPCMB3,PHC_LIBREPCMB4 FROM HR_SPRINT_HISTOCUMSAL WHERE PHC_SIREN=$(SIREN);
!!:GO  

GO  

:setvar  SIREN
:out .\temp\ABSENCESALARIE.asc 
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
      ,[PCN_NBREMOIS]
	  --,PCN_GUID
	  FROM HR_SPRINT_ABSENCESALARIE WHERE PCN_SIREN=$(SIREN);
!!:GO  

GO   

:setvar  SIREN
:out .\temp\PGHISTODETAIL.asc 
SELECT $(COLONNE1),$(COLONNE2),PGHISTODETAIL,PHD_SALARIE,PHD_ETABLISSEMENT,PHD_PGINFOSMODIF,PHD_PGTYPEHISTO,PHD_NEWVALEUR,PHD_TYPEVALEUR,PHD_TABLETTE,PHD_PGTYPEINFOLS,CONVERT(char(10),PHD_DATEAPPLIC,103),PHD_TRAITEMENTOK,PHD_CODTABL,PHD_CODEPOP,PHD_POPULATION FROM HR_SPRINT_PGHISTODETAIL WHERE PHD_SIREN=$(SIREN);
!!:GO  

GO  

:out .\temp\PARAMETRES.asc 
SELECT * FROM PARAMETRES;
!!:GO  

GO  

:out .\temp\RETENUESALAIRE.asc 
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

:out .\temp\RIB.asc 
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

:out .\temp\Analytique.txt 
SELECT VEN_TYPE,VEN_CODE,VEN_AXE,VEN_SOUSPLAN,VEN_SECTION,VEN_POURCENTAGE,VEN_NUMEROVENTILATION
FROM HR_SPRINT_REPRISEVENTILATIONANALYTIQUE WHERE VEN_SIREN=$(SIREN);
!!:GO  

GO

:out .\temp\HISTOBULLETIN.asc 
SELECT $(COLONNE1),$(COLONNE2),HISTOBULLETIN,PHB_ETABLISSEMENT,PHB_SALARIE,CONVERT(char(10),[PHB_DATEDEBUT],103),CONVERT(char(10),[PHB_DATEFIN],103),PHB_NATURERUB,PHB_RUBRIQUE,PHB_LIBELLE,PHB_IMPRIMABLE,PHB_BASECOT,PHB_PLAFOND,PHB_PLAFOND1,PHB_PLAFOND2,PHB_PLAFOND3,PHB_TRANCHE1,PHB_TRANCHE2,PHB_TRANCHE3 FROM HR_SPRINT_HISTOBULLETIN WHERE PHB_SIREN=$(SIREN);
!!:GO  

GO

:out .\temp\PAIEENCOURS.asc 

SELECT $(COLONNE1),$(COLONNE2),PAIEENCOURS,PPU_ETABLISSEMENT,PPU_SALARIE,CONVERT(char(10),[PPU_DATEDEBUT],103),CONVERT(char(10),[PPU_DATEFIN],103),PPU_TOPCLOTURE,PPU_NUMEROSS,PPU_LIBELLE,PPU_PRENOM,PPU_ADRESSE1,PPU_ADRESSE2,PPU_ADRESSE3,PPU_CODEPOSTAL,PPU_VILLE,PPU_INDICE,PPU_NIVEAU,PPU_CONVENTION,PPU_CODDEMPLOI,PPU_AUXILIAIRE,PPU_COEFFICIENT,PPU_LIBELLEEMPLOI,CONVERT(char(10),[PPU_DATEENTREE],103),CONVERT(char(10),[PPU_DATESORTIE],103) FROM HR_SPRINT_PAIEENCOURS WHERE PPU_SIREN=$(SIREN);

!!:GO  

GO

