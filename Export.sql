:setvar  SIREN
:out C:\Reprise_FRH\test\salaries.csv  
SELECT PSA_SALARIE,PSA_NUMEROSS,PSA_LIBELLE,PSA_NOMJF,PSA_PRENOM,PSA_ETABLISSEMENT,PSA_ADRESSE1,PSA_CODEPOSTAL,PSA_VILLE,PSA_PAYS,PSA_DATENAISSANCE,PSA_COMMUNENAISS,PSA_DEPTNAISSANCE,PSA_PAYSNAISSANCE,PSA_NATIONALITE,PSA_SEXE,PSA_SITUATIONFAMIL,PSA_DATEENTREE,PSA_DATEANCIENNETE,PSA_DATESORTIE,PSA_CARTESEJOUR,PSA_DATEEXPIRSEJOUR,PSA_DELIVRPAR,PSA_PERSACHARGE,PSA_MODEREGLE,PSA_AUXILIAIRE,PSA_TELEPHONE,PSA_PORTABLE,PSA_COEFFICIENT,PSA_QUALIFICATION,PSA_CONDEEMPLOI,PSA_LIBELLEEMPLOI,PSA_CODEEMPLOI,PSA_CONVENTION,PSA_HORAIREMOIS,PSA_CIVILITE,PSA_CONGESPAYES,PSA_SALAIREMOIS1,PSA_SALAIREMOIS2,PSA_SALAIREMOIS3,PSA_SALAIREMOIS4,PSA_SALAIREMOIS5,PSA_TRAVAILN1,PSA_TRAVAILN2,PSA_TRAVAILN3,PSA_TRAVAILN4,PSA_CODESTAT,PSA_MOTIFENTREE,PSA_INDICE,PSA_NIVEAU,PSA_PRISEFFECTIF,PSA_UNITEPRISEFF,PSA_REGIMESS,PSA_DATELIBRE1,PSA_DATELIBRE2,PSA_DATELIBRE3,PSA_DATELIBRE4,PSA_BOOLLIBRE1,PSA_BOOLLIBRE2,PSA_BOOLLIBRE3,PSA_BOOLLIBRE4,PSA_LIBREPCMB1,PSA_LIBREPCMB2,PSA_LIBREPCMB3,PSA_LIBREPCMB4,PSA_ORDREAT,PSA_CONDEMPLOI,PSA_DADSPROF,PSA_DADSCAT,PSA_TAUXPARTIEL,PSA_REGIMEMAL,PSA_REGIMEVIP,PSA_REGIMEAT,PSA_TYPDSNFRAC,PSA_DSNFRACTION,PSA_TYPENATTAUXPAS,PSA_NATURETAUXPAS,PSA_UNITETRAVAIL,PSA_MOTIFSORTIE,PSA_HORHEBDO,PSA_ETATBULLETIN FROM HR_SPRINT_SALARIES WHERE PSA_SIREN=$(SIREN)
!!:GO  

PRINT 'Export salariés'

GO  

:setvar  SIREN
:out C:\Reprise_FRH\test\contrat.csv  
SELECT * FROM HR_SPRINT_CONTRATTRAVAIL WHERE PCI_SIREN=$(SIREN);
!!:GO  

GO

:setvar  SIREN
:out C:\Reprise_FRH\test\RIB.csv  
SELECT * FROM HR_SPRINT_RIB WHERE R_SIREN=$(SIREN);
!!:GO  

GO   

:setvar  SIREN
:out C:\Reprise_FRH\test\DEPORTSAL.csv  
SELECT * FROM HR_SPRINT_DEPORTSAL WHERE PSE_SIREN=$(SIREN);
!!:GO  

GO     

:setvar  SIREN
:out C:\Reprise_FRH\test\SALARIECOMPL.csv  
SELECT * FROM HR_SPRINT_DEPORTSAL WHERE PSZ_SIREN=$(SIREN);
!!:GO  

GO     

:setvar  SIREN
:out C:\Reprise_FRH\test\PAIEENCOURS.csv  
SELECT * FROM HR_SPRINT_PAIEENCOURS WHERE PPU_SIREN=$(SIREN);
!!:GO  

GO     

:setvar  SIREN
:out C:\Reprise_FRH\test\HISTOBULLETIN.csv  
SELECT * FROM HR_SPRINT_HISTOBULLETIN WHERE PHD_SIREN=$(SIREN);
!!:GO  

GO    

:setvar  SIREN
:out C:\Reprise_FRH\test\HISTOCUMSAL.csv  
SELECT * FROM HR_SPRINT_HISTOCUMSAL WHERE PHC_SIREN=$(SIREN);
!!:GO  

GO     