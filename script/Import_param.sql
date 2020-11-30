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
--Bug le script force une conversion en INT sur le premier INSERT
INSERT INTO PARAMETRES VALUES
 
('AUXI_LONGUEUR',$(longueur_auxiliaire),'La valeur est utilisée pour générer les comptes auxiliaires sur la bonne longueur'),
('RENUMEROTATION_MATRICULE',$(matricule),'Indiquer');

!!:GO  
GO

INSERT INTO PARAMETRES VALUES
('AUXI_PREFIXE','S','Prefixe auxiliaire'),
('GEN_421','421000','La valeur est utilisée pour alimenter la table TIERS. Indiquer le compte de Net é payer'),
('TABLETRAVAILN1','CTA02','Indiquer le nom de la colonne HRU'),
('TABLETRAVAILN2','-','Indiquer le nom de la colonne HRU'),
('TABLETRAVAILN3','-','Indiquer le nom de la colonne HRU'),
('TABLETRAVAILN4','CTA04','Indiquer le nom de la colonne HRU'),
('CODESTAT','CTA1','Indiquer le nom de la colonne HRU'),
('TABLETTELIBRE1','-','Indiquer le nom de la colonne HRU'),
('TABLETTELIBRE2','-','Indiquer le nom de la colonne HRU'),
('TABLETTELIBRE4','-','Indiquer le nom de la colonne HRU'),
('Boite à cocher 1','GCB06','Indiquer le nom de la colonne HRU'),
('Boite à cocher 2','GCB02','Indiquer le nom de la colonne HRU'),
('Boite à cocher 3','GCB01','Indiquer le nom de la colonne HRU'),
('Boite à cocher 4','-','Indiquer le nom de la colonne HRU'),
('MULTI_AXE','X','Indiquer X si multi axes dans FRH sinon -'),
('AXE_1','8','Indiquer la longueur de l axe'),
('AXE_2','2','Indiquer la longueur de l axe'),
('AXE_3','3','Indiquer la longueur de l axe'),
('AXE_4','-','Indiquer la longueur de l axe'),
('AXE_5','-','Indiquer la longueur de l axe'),
('Reprise bulletins','-','Indiquer X pour reprendre les bulletins sinon -'),
('Partage PLE','X','Indiquer X si partage des libellés emplois'),
('Reprise Taux Pas','-','Indiquer X pour reprendre les taux PAS'),
('Partage Table libre','X','Indiquer X si partage zones libres'),
('Date de démarrage' ,'01/01/2020','Indiquer la date de démarrage du dossier format JJ/MM/AAAA'),
('CET ACQUIS','B1','Indiquer le cumul de CET acquis'),
('CET PRIS','B2','Indiquer le cumul de CET pris'),
('RTT ACQUIS','','Indiquer le cumul de RTT acquis'),
('RTT PRIS','','Indiquer le cumul de RTT PRIS'),
('Acquis CP','2,08','Le Nbre de jours acquis CP'),
('Conservation code etb','X','Indiquer X pour conserver le code ETB de SYNAPPS'),
('TRANSCO_PROFIL','-','Indiquer X pour transcoder les profils');
!!:GO  
GO