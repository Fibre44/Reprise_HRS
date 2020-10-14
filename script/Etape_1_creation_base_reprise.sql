
--Cr�ation base Reprise

USE master;  
GO  
CREATE DATABASE REPRISE_HRU 
ON   
( NAME = REPRISE_HRU_DAT,  
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\REPRISE_HRU.mdf',  
    SIZE = 10,  
    MAXSIZE = 5000,  
    FILEGROWTH = 5 )  

LOG ON  
( NAME = REPRISE_HR_LOG,  
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\REPRISE_HRU.ldf',  
    SIZE = 5MB,  
    MAXSIZE = 2500MB,  
    FILEGROWTH = 5MB );

Print 'Cr�ation base REPRISE_HRU '

GO  

USE REPRISE_HRU 

--Cr�ation des tables HR SPRINT

--Table SALARIES

CREATE TABLE HR_SPRINT_SALARIES
(
PSA_SIREN varchar(35),
PSA_SALARIE varchar(10),
PSA_NUMEROSS varchar(15),
PSA_LIBELLE varchar(35),
PSA_NOMJF varchar(35),
PSA_PRENOM varchar(35),
PSA_ETABLISSEMENT char(3),
PSA_ADRESSE1 varchar(35),
PSA_CODEPOSTAL char(9),
PSA_VILLE varchar(50),
PSA_PAYS varchar(3),
PSA_DATENAISSANCE datetime,
PSA_COMMUNENAISS varchar(35),
PSA_DEPTNAISSANCE char(2),
PSA_PAYSNAISSANCE char(3),
PSA_NATIONALITE char(3),
PSA_SEXE char(1),
PSA_SITUATIONFAMIL char(3),
PSA_DATEENTREE datetime,
PSA_DATEANCIENNETE datetime,
PSA_DATESORTIE datetime,
PSA_CARTESEJOUR varchar(50),
PSA_DATEEXPIRSEJOUR datetime,
PSA_DELIVRPAR varchar(35),
PSA_PERSACHARGE int,
PSA_MODEREGLE char(3),
PSA_AUXILIAIRE varchar(17),
PSA_TELEPHONE varchar(35),
PSA_PORTABLE varchar(35),
PSA_COEFFICIENT varchar(3),
PSA_QUALIFICATION varchar(17),
PSA_CONDEEMPLOI varchar(50),
PSA_LIBELLEEMPLOI varchar(3),
PSA_CODEEMPLOI varchar(4),
PSA_CONVENTION varchar(17),
PSA_HORAIREMOIS real,
PSA_CIVILITE char(3),
PSA_CONGESPAYES char(1),
PSA_SALAIREMOIS1 varchar(35),
PSA_SALAIREMOIS2 varchar(35),
PSA_SALAIREMOIS3 varchar(35),
PSA_SALAIREMOIS4 varchar(35),
PSA_SALAIREMOIS5 varchar(35),
PSA_TRAVAILN1 char(3),
PSA_TRAVAILN2 char(3),
PSA_TRAVAILN3 char(3),
PSA_TRAVAILN4 char(3),
PSA_CODESTAT char(3),
PSA_MOTIFENTREE char(3),
PSA_INDICE char(3),
PSA_NIVEAU char(3),
PSA_PRISEFFECTIF char(1),
PSA_UNITEPRISEFF numeric(19,4),
PSA_REGIMESS char(3),
PSA_DATELIBRE1 datetime,
PSA_DATELIBRE2 datetime,
PSA_DATELIBRE3 datetime,
PSA_DATELIBRE4 datetime,
PSA_BOOLLIBRE1 char(1),
PSA_BOOLLIBRE2 char(1),
PSA_BOOLLIBRE3 char(1),
PSA_BOOLLIBRE4 char(1),
PSA_LIBREPCMB1 char(3),
PSA_LIBREPCMB2 char(3),
PSA_LIBREPCMB3 char(3),
PSA_LIBREPCMB4 char(3),
PSA_ORDREAT char(1),
PSA_CONDEMPLOI char(3),
PSA_DADSPROF char(3),
PSA_DADSCAT char(3),
PSA_TAUXPARTIEL varchar(255),
PSA_REGIMEMAL char(3),
PSA_REGIMEVIP char(3),
PSA_REGIMEAT char(3),
PSA_TYPDSNFRAC char(3),
PSA_DSNFRACTION char(1),
PSA_TYPENATTAUXPAS char(3),
PSA_NATURETAUXPAS char(3),
PSA_UNITETRAVAIL char (2),
PSA_MOTIFSORTIE char(3),
PSA_HORHEBDO real,
PSA_ETATBULLETIN char(3)
);

PRINT 'Cr�ation table SALARIES'

GO


--Table DEPORTSAL

CREATE TABLE HR_SPRINT_DEPORTSAL

(
PSE_SIREN varchar(35),
PSE_SALARIE varchar(10),
PSE_EMAILPROF varchar(35)

);

PRINT 'Cr�ation table DEPORTSAL'

GO

--SALARIECOMPL

CREATE TABLE HR_SPRINT_SALARIECOMPL

(
PSZ_SIREN varchar(35),
PSZ_SALARIE varchar(10),
PSZ_DIGITALIDENT varchar(50),

);


PRINT 'Cr�ation table SALARIECOMPL'

GO


--CONTRATTRAVAIL

CREATE TABLE HR_SPRINT_CONTRATTRAVAIL

(
PCI_SIREN varchar(35),
PCI_SALARIE varchar(10),
PCI_ORDRE int,
PCI_TYPECONTRAT char(3),
PCI_DEBUTCONTRAT datetime,
PCI_FINCONTRAT datetime,
PCI_ETABLISSEMENT char(3),
PCI_ETABLIEUTRAV char(3), 
PCI_DNASITUATADM char(3),
PCI_PERPAIEMENTSAL char(3),
PCI_INTITULCONTRAT char(3),
PCI_TYPECDD char(3),
PCI_REGIMELOCALDSN char(2),
PCI_QUOTITE varchar(255),
PCI_TYPEINSEE char(3),
PCI_CODEINSEE char(5),
PCI_ANCIENNUM char(35),
PCI_PASEXCLU char(2),
PCI_DNACODUNITEHOR char (2),
PCI_SALARIEREMPL varchar(10),
PCI_LIBELLEEMPLOI varchar(35),
PCI_MOTIFCTINT char(3),
PCI_MOTIFSORTIE char(3),
PCI_SIRETANCIEN varchar(17)
);
PRINT 'Cr�ation table CONTRATRAVAIL'
GO

--TIERS

CREATE TABLE HR_SPRINT_TIERS

(
T_SIREN varchar(35),
T_AUXILIAIRE varchar(35),
T_NATUREAUXILIAIRE char(3),
T_LIBELLE varchar(250),
T_COLLECTIF varchar(35),
T_ABREGE varchar(250),
T_ADRESSE1 varchar(255),
T_CODEPOSTAL char(5),
T_VILLE varchar(35)

);

PRINT 'Cr�ation table TIERS'
GO

--RIB

CREATE TABLE HR_SPRINT_RIB

(
R_SIREN varchar(35),
R_AUXILIAIRE varchar(35),
R_NUMERORIB int,
R_PRINCIPAL char(1),
R_ETABBQ varchar(8),
R_GUICHET varchar(5),
R_NUMEROCOMPTE varchar(20),
R_CLERIB varchar(2),
R_CODEIBAN varchar(70),
R_CODEBIC varchar(35),
R_DOMICILIATION varchar(24),
R_SALAIRE char(1),
R_ACOMPTE char(1),
R_PAYS char(3),
R_DEVISE char(3)

);


PRINT 'Cr�ation table RIB'

GO


CREATE TABLE VENTILATION_INDIVIDUS 
(
IND_CEMP varchar(35),
IND_SIREN varchar(35),
IND_MATRICULEHRU varchar(35),
IND_MATRICULEHRS varchar(35),
IND_AUXILIAIRE varchar(35),
IND_STATUS varchar(50),
IND_LIGNE INT IDENTITY(1, 1),
IND_REPRISE_HR_SPRINT_SALARIE char(1),
IND_REPRISE_HR_SPRINT_CONTRATTRAVAIL char(1),
IND_REPRISE_HR_SPRINT_DEPORTSAL char(1),
IND_REPRISE_HR_SPRINT_SALARIECOMPL char(1),
IND_REPRISE_HR_SPRINT_TIERS char(1),
IND_REPRISE_HR_SPRINT_RIB char(1),
IND_REPRISE_HR_SPRINT_AXE char(1),
IND_REPRISE_HR_SPRINT_CVENTIL char(1),
IND_REPRISE_HR_SPRINT_CVENTILENTETE char(1),
IND_REPRISE_HR_SPRINT_CSECTION char(1),
IND_REPRISE_HR_SPRINT_PAIEENCOURS char(1),
IND_REPRISE_HR_SPRINT_HISTOBULLETIN char(1),
IND_REPRISE_HR_SPRINT_HISTOCUMSAL char(1),
IND_REPRISE_HR_SPRINT_ENFANTSALARIE char(1),
IND_REPRISE_HR_SPRINT_PASTAUX char(1),
IND_REPRISE_HR_SPRINT_ABSENCESALARIE char(1),
IND_REPRISE_HR_SPRINT_PGHISTODETAIL char(1)

);

GO

PRINT 'Cr�ation table VENTILATION_INDIVIDUS'


CREATE TABLE JOURNAL_DES_TRAITEMENTS

(

JOU_ID INT IDENTITY(1, 1),
JOU_NATURE varchar(255),
JOU_RESULTAT varchar(2),
JOU_COMMENTAIRE varchar(255)

);
GO

PRINT 'Cr�ation table JOURNAL_DES_TRAITEMENTS'


CREATE TABLE ANOMALIES

(

AN_ID INT IDENTITY(1, 1),
AN_TYPE varchar (255),
AN_MATRICULE varchar (255),
AN_COMMENTAIRE varchar(255)

)
GO

PRINT 'Cr�ation table ANOMALIES'



CREATE TABLE TRAVAIL_RENUMEROTATION_MATRICULE

(
TRAV1_CEMP varchar(35),
TRAV1_MATRICULEHRU varchar(7),
TRAV1_MATRICULEHRS_TEMPORAIRE int,
TRAV1_MATRICULEHRS varchar(10),
);

GO

PRINT 'Cr�ation table TRAVAIL_RENUMEROTATION_MATRICULE'


CREATE TABLE TRANSCO
(

TRA_ID INT IDENTITY(1, 1),
TRA_TYPE varchar(35),
TRA_VALEURHRU varchar(35),
TRA_VALEURHRS varchar(35),
TRA_SIREN varchar(35),
);
GO

PRINT 'Cr�ation table TRANSCO'


CREATE TABLE HR_SPRINT_CHOIXCOD

(
CC_SIREN varchar(35),
CC_TYPE char(3),
CC_CODE char(3),
CC_LIBELLE varchar(35),
CC_ABREGE varchar(35)
);

Go

PRINT 'Cr�ation table HR_SPRINT_CHOIXCOD'

CREATE TABLE PARAMETRES
(

PAR_NOM varchar(35),
PAR_VALEUR varchar(35),
PAR_COMMENTAIRES varchar(255)

);

GO

PRINT 'Cr�ation table PARAMETRES'

INSERT INTO PARAMETRES

VALUES 

('AUXI_LONGUEUR','10','La valeur est utilis�e pour g�n�rer les comptes auxiliaires sur la bonne longueur'),
('GEN_421','421000','La valeur est utilis�e pour alimenter la table TIERS. Indiquer le compte de Net � payer'),
('AUXI_PREFIXE','S','SAL par default indiquer le pr�fixe pour des codes auxiliaires'),
('TABLETRAVAILN1','CTA02','Indiquer le nom de la colonne HRU'),
('TABLETRAVAILN2','-','Indiquer le nom de la colonne HRU'),
('TABLETRAVAILN3','-','Indiquer le nom de la colonne HRU'),
('TABLETRAVAILN4','CTA04','Indiquer le nom de la colonne HRU'),
('CODESTAT','CTA1','Indiquer le nom de la colonne HRU'),
('TABLETTELIBRE1','-','Indiquer le nom de la colonne HRU'),
('TABLETTELIBRE2','-','Indiquer le nom de la colonne HRU'),
('TABLETTELIBRE4','-','Indiquer le nom de la colonne HRU'),
('Boite � cocher 1','GCB06','Indiquer le nom de la colonne HRU'),
('Boite � cocher 2','GCB02','Indiquer le nom de la colonne HRU'),
('Boite � cocher 3','GCB01','Indiquer le nom de la colonne HRU'),
('Boite � cocher 4','-','Indiquer le nom de la colonne HRU'),
('MULTI_AXE','X','Indiquer X si multi axes dans FRH sinon -'),
('AXE_1','8','Indiquer la longueur de l�axe'),
('AXE_2','2','Indiquer la longueur de l�axe'),
('AXE_3','3','Indiquer la longueur de l�axe'),
('AXE_4','-','Indiquer la longueur de l�axe'),
('AXE_5','-','Indiquer la longueur de l�axe'),
('Renum�rotation matricules','-','Indiquer X pour renum�roter les salari�s. Attention la renum�rotation se fera avec 10 positions en num�rique
Concat�nation 00000+ Code CEMP de HRU + incr�mentation automatique'),
('Reprise bulletins','-','Indiquer X pour reprendre les bulletins sinon -'),
('Partage PLE','X','Indiquer X si partage des libell�s emplois'),
('Reprise Taux Pas','-','Indiquer X pour reprendre les taux PAS'),
('Partage Table libre','X','Indiquer X si partage zones libres'),
('Date de d�marrage' ,'01/01/2020','Indiquer la date de d�marrage du dossier format JJ/MM/AAAA'),
('CET ACQUIS','B1','Indiquer le cumul de CET acquis'),
('CET PRIS','B2','Indiquer le cumul de CET pris'),
('RTT ACQUIS','','Indiquer le cumul de RTT acquis'),
('RTT PRIS','','Indiquer le cumul de RTT PRIS'),
('Acquis CP','2,08','Le Nbre de jours acquis CP'),
('Conservation code etb','X','Indiquer X pour conserver le code ETB de SYNAPPS');

GO

Print 'Ajout des valeurs table PARAMETRES'

CREATE TABLE HR_SPRINT_PAIEENCOURS

(

PPU_SIREN varchar(35),
PPU_ETABLISSEMENT char(3),
PPU_SALARIE varchar(10),
PPU_DATEDEBUT date,
PPU_DATEFIN date,
PPU_TOPCLOTURE char(1),
PPU_TRAVAILN1 char(3),
PPU_TRAVAILN2 char(3),
PPU_TRAVAILN3 char(3),
PPU_TRAVAILN4 char(3),
PPU_CODESTAT char(3),
PPU_NUMEROSS varchar(35),
PPU_LIBELLE varchar(35),
PPU_PRENOM varchar(35),
PPU_ADRESSE1 varchar(35),
PPU_ADRESSE2 varchar(35),
PPU_ADRESSE3 varchar(35),
PPU_CODEPOSTAL varchar(9),
PPU_VILLE varchar(35),
PPU_INDICE varchar(17),
PPU_NIVEAU varchar(17),
PPU_CONVENTION varchar(17),
PPU_CODDEMPLOI varchar(4),
PPU_AUXILIAIRE varchar(17),
PPU_LIBREPCMB1 char(3),
PPU_LIBREPCMB2 char(3),
PPU_LIBREPCMB3 char(3),
PPU_LIBREPCMB4 char(3),
PPU_QUALIFICATION char(3),
PPU_COEFFICIENT char(3),
PPU_LIBELLEEMPLOI char(3),
PPU_DATEENTREE datetime,
PPU_DATESORTIE datetime,
PPU_TRENTIEMEMOD char(1),
PPU_DENOMINTRENT int,
PPU_NUMERATTRENT int,
PPU_CIVILITE char(3),

);

GO

PRINT 'Cr�ation table HR_SPRINT_PAIEENCOURS'


CREATE TABLE HR_SPRINT_HISTOBULLETIN

(

PHB_SIREN varchar(35),
PHB_ETABLISSEMENT char(3),--obligatoire
PHB_SALARIE varchar(10),--obligatoire
PHB_DATEDEBUT date,--obligatoire
PHB_DATEFIN date,--obligatoire
PHB_NATURERUB char(3),--obligatoire
PHB_RUBRIQUE char(5),--obligatoire
PHB_LIBELLE varchar(35),
PHB_IMPRIMABLE char(1),--obligatoire
PHB_BASEREM varchar(255),
PHB_TAUXREM varchar(255),
PHB_COEFFREM varchar(255),
PHB_MTREM varchar(255),
PHB_BASECOT varchar(255),
PHB_TAUXSALARIAL varchar(255),
PHB_MTSALARIAL varchar(255),
PHB_TAUXPATRONAL varchar(255),
PHB_MTPATRONAL varchar(255),
PHB_TRAVAILN1 char (3),
PHB_TRAVAILN2 char (3),
PHB_TRAVAILN3 char (3),
PHB_TRAVAILN4 char (3),
PHB_CODESTAT char(3),
PHB_LIBREPCMB1 char(3),
PHB_LIBREPCMB2 char(3),
PHB_LIBREPCMB3 char(3),
PHB_LIBREPCMB4 char(3),

);

GO

PRINT 'Cr�ation table HR_SPRINT_HISTOBULLETIN'



CREATE TABLE HR_SPRINT_HISTOCUMSAL

(

PHC_SIREN varchar(255),
PHC_ETABLISSEMENT char(3),
PHC_SALARIE varchar(10),
PHC_DATEDEBUT date,
PHC_DATEFIN date,
PHC_REPRISE char(1),
PHC_CUMULPAIE char(3),
PHC_MONTANT varchar(255),
PHC_TRAVAILN1 char(3),
PHC_TRAVAILN2 char(3),
PHC_TRAVAILN3 char(3),
PHC_TRAVAILN4 char(3),
PHC_CODESTAT char(3),
PHC_LIBREPCMB1 char(3),
PHC_LIBREPCMB2 char(3),
PHC_LIBREPCMB3 char(3),
PHC_LIBREPCMB4 char(3),
);

GO

PRINT 'Cr�ation table HR_SPRINT_HISTOCUMSAL'


CREATE TABLE HR_SPRINT_MINIMUMCONVENT

(

PMI_SIREN varchar(35),
PMI_NATURE char(3),
PMI_CONVENTION char(3),
PMI_TYPENATURE char(3),
PMI_CODE varchar(17),
PMI_LIBELLE varchar(35),
PMI_PREDEFINI char(3),
PMI_NODOSSIER char(6),

);

GO

PRINT 'Cr�ation table HR_SPRINT_MINIMUMCONVENT'


CREATE TABLE HR_SPRINT_PASTAUX

(

PKT_SIREN varchar(35),
PKT_NUMEROSS varchar(15),
PKT_SALARIE varchar(10),
PKT_IDENTIFIANTIND varchar(35),
PKT_PERIODE varchar(6),
PKT_CRM varchar(18),
PKT_DTPUBLICATION datetime,
PKT_TAUXDGFIP varchar(5),

);

GO

PRINT 'Cr�ation table HR_SPRINT_PASTAUX'


CREATE TABLE HR_SPRINT_ENFANTSALARIE
(
PEF_SIREN varchar(35),
PEF_SALARIE varchar(10),
PEF_ENFANT int,
PEF_NOM varchar(35),
PEF_PRENOM varchar(35),
PEF_DATENAISSANCE date,
PEF_ACHARGE char(1),
PEF_NATIONALITE char(3),
PEF_SEXE char(1),
PEF_TYPEPARENTAL char(3),
);

GO

PRINT 'Cr�ation table HR_SPRINT_ENFANTSALARIE'

CREATE TABLE HR_SPRINT_ABSENCESALARIE
(
PCN_SIREN varchar(35),
PCN_ETABLISSEMENT char(3),
PCN_SALARIE varchar(10),
PCN_DATEDEBUT date,
PCN_DATEFIN date,
PCN_ORDRE int,
PCN_TYPECONGE char(3),
PCN_SENSABS char(3),
PCN_DATEVALIDITE date,
PCN_LIBELLE varchar(70),
PCN_JOURS real,
PCN_HEURES varchar(255),
PCN_BASE varchar(255),
PCN_DEBUTDJ char(3),
PCN_FINDJ char(3),
PCN_TRAVAILN1 char(3),
PCN_TRAVAILN2 char(3),
PCN_TRAVAILN3 char(3),
PCN_TRAVAILN4 char(3),
PCN_TYPEMVT char(3),
PCN_PERIODECP char(1),
PCN_PERIODEPY char(2),
PCN_TYPEIMPUTE char(3),
PCN_ETATPOSTPAIE char(3),
PCN_CODETAPE char(1),
PCN_NBREMOIS real,
PCN_CODESTAT char(3)
);

Go

PRINT 'Cr�ation table HR_SPRINT_ABSENCESALARIE'


CREATE TABLE HR_SPRINT_ETABLISS
(

ET_SIREN char(35),
ET_ETABLISSEMENT char(3),
ET_LIBELLE varchar(35),
ET_ABREGE varchar(35),
ET_ADRESSE1 varchar(50),
ET_CODEPOSTAL char(5),
ET_VILLE varchar(35),
ET_DIVTERRIT char(5),
ET_PAYS char(3),
ET_LANGUE char(3),
ET_SOCIETE char(3),
ET_JURIDIQUE char(3),
ET_SIRET char(14),
ET_APE char(5),
);

GO

PRINT 'Cr�ation table HR_SPRINT_ETABLISS'


CREATE TABLE HR_SPRINT_PGHISTODETAIL

(
PHD_SIREN char(35),
PHD_SALARIE varchar(10),
PHD_ETABLISSEMENT char(3),
PHD_PGINFOSMODIF varchar(35),
PHD_PGTYPEHISTO char(3),
PHD_NEWVALEUR varchar(35),
PHD_TYPEVALEUR char(1),
PHD_TABLETTE varchar(35),
PHD_PGTYPEINFOLS char(3),
PHD_DATEAPPLIC datetime,
PHD_TRAITEMENTOK char(1),
PHD_CODTABL char(1),
PHD_CODEPOP char(1),
PHD_POPULATION char(1),
PGHISTODETAIL char(13),
PHD_CONTRATTRAV char(1)
);
GO

PRINT 'Cr�ation table HR_SPRINT_PGHISTODETAIL'


CREATE TABLE HR_SPRINT_CVENTIL

(

CVE_SIREN char(35),
CVE_CODE varchar(17),
CVE_AXE char(2),
CVE_TAUXMONTANT varchar(255),
CVE_TAUXQTE1 float,
CVE_TAUXQTE2 float,
CVE_NUMEROVENTIL int,
CVE_MONTANT float,
CVE_SOUSPLAN1 varchar(17),
CVE_SOUSPLAN2 varchar(17),
CVE_SOUSPLAN3 varchar(17),
CVE_SOUSPLAN4 varchar(17),
CVE_SOUSPLAN5 varchar(17),
CVE_SOUSPLAN6 varchar(17),
CVE_TYPE char(3)

);

GO

PRINT 'Cr�ation table HR_SPRINT_CVENTIL'



CREATE TABLE HR_SPRINT_CSECTION

(

CSP_SIREN varchar(35),
CSP_AXE char(2),
CSP_SOUSPLAN char(2),
CSP_SECTION varchar(17),
CSP_ABREGE varchar(35),
CSP_LIBELLE varchar(35)

);
GO

PRINT 'Cr�ation table HR_SPRINT_CSECTION'


--Table CONVENTIONCOLL

CREATE TABLE HR_SPRINT_CONVENTIONCOLL
(
PCV_SIREN varchar(35),
PCV_CONVENTION varchar(17),
PCV_LIBELLE varchar(60),
PCV_PREDEFINI varchar(3),
PCV_NODOSSIER varchar(6),
PCV_IDCC varchar(17)

);

GO

PRINT 'Cr�ation table HR_SPRINT_CONVENTIONCOLL'


CREATE TABLE HR_SPRINT_AXE

(
X_SIREN varchar(35),
X_AXE char(2),
X_LIBELLE char (35),
X_COMPTABLE char(1),
X_CHANTIER char(1),
X_MODEREOUVERTURE char(1),
X_SECTIONATTENTE char (17),
X_REGLESAISIE varchar(35),
X_ABREGE char(17),
X_LONGSECTION int,
X_BOURREANA char(1),
X_SOCIETE char(3),
X_STRUCTURE char(1),
X_GENEATTENTE varchar(17),
X_CPESTRUCT char(1),
X_FERME char(1),
X_SAISIETRANCHE char(1)

);
GO

PRINT 'Cr�ation table HR_SPRINT_AXE'


CREATE TABLE CORRESPONDANCE_HRU_HRS

(

COR_CHAMPHRU char(10),
COR_VALEURHRU char(35),
COR_VALEURHRU_COMMENTAIRE varchar(255),
COR_VALEURHRS char(35),
COR_VALEURHRS_COMMENTAIRE varchar(255),
);

GO

PRINT 'Cr�ation table CORRESPONDANCE_HRU_HRS'


INSERT INTO CORRESPONDANCE_HRU_HRS
VALUES 
('CISEX','01','Homme','M','Homme'),
('CISEX','02','Femme','F','Femme');

GO

CREATE TABLE VALEUR_POSSIBLE_CCN

(

VAL_CODE char(3),
VAL_UTILISER char(1),
VAL_LIGNE  INT IDENTITY
);

PRINT 'Cr�ation table VALEUR_POSSIBLE_CCN'



INSERT INTO VALEUR_POSSIBLE_CCN
VALUES
('001','-'),
('003','-'),
('011','-'),
('013','-'),
('021','-'),
('023','-'),
('031','-');

GO

CREATE TABLE HR_SPRINT_REPRISEVENTILATIONANALYTIQUE

(

VEN_SIREN varchar(35),
VEN_TYPE char(3),
VEN_CODE varchar(10),
VEN_AXE char(2),
VEN_SOUSPLAN char(2),
VEN_SECTION varchar(17),
VEN_POURCENTAGE varchar(255),
VEN_NUMEROVENTILATION int

);

GO

PRINT 'Cr�ation table HR_SPRINT_REPRISEVENTILATIONANALYTIQUE'


CREATE TABLE HR_SPRINT_RETENUESALAIRE

(
PRE_SIREN varchar(35),
PRE_SALARIE varchar(10),
PRE_ORDRE int,
PRE_LIBELLE varchar(35),
PRE_DATEDEBUT date,
PRE_DATEFIN date,
PRE_MONTANTTOT varchar(255),
PRE_ACTIF char(1),
PRE_RETENUESAL char(3),
PRE_REMBMAX char(1),
PRE_MONTANTMENS varchar(255),
PRE_NBMOIS int

);
GO

PRINT 'Cr�ation table HR_SPRINT_RETENUESALAIRE'

CREATE TABLE STATISTIQUES

(

STA_SIREN varchar(17),
STA_TABLE varchar(35),
STA_NBRE_LIGNES int

);

PRINT 'Cr�ation table STATISTIQUES'

GO



