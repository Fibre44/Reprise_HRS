SET SIREN=407512185
sqlcmd -S IP -U Login -P Password -i .\script\Ajout_Nom_des_tables.sql
sqlcmd -S IP -U Login -P Password -i .\script\Export.sql -s "|" -W
REN .\fichiers_hrs\SALARIES.asc %SIREN%_SALARIES.asc
REN .\fichiers_hrs\SALARIESCOMPL.asc %SIREN%_SALARIESCOMPL.asc
REN .\fichiers_hrs\DEPORTSAL.asc %SIREN%_DEPORTSAL.asc
REN .\fichiers_hrs\ABSENCESALARIE.asc %SIREN%_ABSENCESALARIE.asc
REN .\fichiers_hrs\PGHISTODETAIL.asc %SIREN%_PGHISTODETAIL.asc
REN .\fichiers_hrs\RIB.asc %SIREN%_RIB.asc
REN .\fichiers_hrs\CONTRATTRAVAIL.asc %SIREN%_CONTRATTRAVAIL.asc
REN .\fichiers_hrs\PAIEENCOURS.asc %SIREN%_PAIEENCOURS.asc
REN .\fichiers_hrs\HISTOBULLETIN.asc %SIREN%_HISTOBULLETIN.asc
REN .\fichiers_hrs\HISTOCUMSAL.asc %SIREN%_HISTOCUMSAL.asc
REN .\fichiers_hrs\ENFANTSALARIE.asc %SIREN%_ENFANTSALARIE.asc
REN .\fichiers_hrs\RETENUESALARIE.asc %SIREN%_RETENUESALARIE.asc
REN .\fichiers_hrs\PARAMETRES.asc %SIREN%_PARAMETRES.asc