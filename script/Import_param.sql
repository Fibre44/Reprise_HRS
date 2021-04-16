DROP TABLE PARAMETRES --suppression table PARAMETRES AVANT IMPORT

!!:GO  
GO

CREATE TABLE PARAMETRES
(
    PAR_NOM varchar(35),
    PAR_VALEUR varchar(35),
    PAR_COMMENTAIRES varchar(255)
);

!!:GO  
GO

INSERT INTO PARAMETRES VALUES
('AUXI_LONGUEUR',$(longueur_auxiliaire),'La valeur est utilisée pour générer les comptes auxiliaires sur la bonne longueur'),
('RENUMEROTATION_MATRICULE',$(matricule),'Indiquer'),
('AXE_1',$(axe1),'Indiquer la longueur de l axe 1'),
('AXE_2',$(axe2),'Indiquer la longueur de l axe 2'),
('AXE_3',$(axe3),'Indiquer la longueur de l axe 3'),
('AXE_4',$(axe4),'Indiquer la longueur de l axe 4'),
('AXE_5',$(axe5),'Indiquer la longueur de l axe 5');

INSERT INTO PARAMETRES VALUES
('AUXI_PREFIXE','S','Prefixe auxiliaire'),
('GEN_421','421000','La valeur est utilisée pour alimenter la table TIERS. Indiquer le compte de Net à payer'),
('TABLETRAVAILN1',$(travailN1),'Indiquer le nom de la colonne HRU'),
('TABLETRAVAILN2',$(travailN2),'Indiquer le nom de la colonne HRU'),
('TABLETRAVAILN3',$(travailN3),'Indiquer le nom de la colonne HRU'),
('TABLETRAVAILN4',$(travailN4),'Indiquer le nom de la colonne HRU'),
('CODESTAT',$(codestat),'Indiquer le nom de la colonne HRU'),
('TABLETTELIBRE1',$(tablette1),'Indiquer le nom de la colonne HRU'),
('TABLETTELIBRE2',$(tablette2),'Indiquer le nom de la colonne HRU'),
('TABLETTELIBRE3',$(tablette3),'Indiquer le nom de la colonne HRU'),
('TABLETTELIBRE4',$(tablette4),'Indiquer le nom de la colonne HRU'),
('Boite à cocher 1',$(boite1),'Indiquer le nom de la colonne HRU'),
('Boite à cocher 2',$(boite2),'Indiquer le nom de la colonne HRU'),
('Boite à cocher 3',$(boite3),'Indiquer le nom de la colonne HRU'),
('Boite à cocher 4',$(boite4),'Indiquer le nom de la colonne HRU'),
('MULTI_AXE','X','Indiquer X si multi axes dans FRH sinon -'),
('Reprise bulletins',$(bulletin),'Indiquer X pour reprendre les bulletins sinon -'),
('Partage PLE',$(partageemploi),'Indiquer X si partage des libellés emplois'),
('Reprise Taux Pas','-','Indiquer X pour reprendre les taux PAS'),
('Partage Table libre',$(partagezonlibre),'Indiquer X si partage zones libres'),
('Date de démarrage','01/01/2020','Indiquer la date de démarrage du dossier format JJ/MM/AAAA'),
('CET ACQUIS','-','Indiquer le cumul de CET acquis'),
('CET PRIS','-','Indiquer le cumul de CET pris'),
('RTT ACQUIS','-','Indiquer le cumul de RTT acquis'),
('RTT PRIS','-','Indiquer le cumul de RTT PRIS'),
('Acquis CP',$(cp),'Le Nbre de jours acquis CP'),
('Conservation code etb','X','Indiquer X pour conserver le code ETB de SYNAPPS'),
('TRANSCO_PROFIL',$(profils),'Indiquer X pour transcoder les profils'),
('CODE_BULLETIN',$(codebulletinpaie),'Indiquer le code bulletin de paie');

PRINT 'Import des paramètres'
!!:GO  
GO
