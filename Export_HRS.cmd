SET COLONNE1='='
SET COLONNE2='1'
SET SIREN=754015899
sqlcmd -S Serveur -U Login -P MP -i .\script\Export.sql -s "|" -W -h -1
COPY .\En_Tete\SALARIES_EN_TETE.asc + .\fichiers_hrs\SALARIES.asc .\fichiers_hrs\%SIREN%_SALARIES.asc
COPY .\En_Tete\CONTRATTRAVAIL_EN_TETE.asc + .\fichiers_hrs\CONTRATTRAVAIL.asc .\fichiers_hrs\%SIREN%_CONTRATTRAVAIL.asc
COPY .\En_Tete\RIB_EN_TETE.asc + .\fichiers_hrs\RIB.asc .\fichiers_hrs\%SIREN%_RIB.asc
COPY .\En_Tete\DEPORTSAL_EN_TETE.asc + .\fichiers_hrs\DEPORTSAL.asc .\fichiers_hrs\%SIREN%_DEPORTSAL.asc
COPY .\En_Tete\SALARIESCOMPL_EN_TETE.asc + .\fichiers_hrs\SALARIESCOMPL.asc .\fichiers_hrs\%SIREN%_SALARIESCOMPL.asc 
COPY .\En_Tete\ENFANTSALARIE_EN_TETE.asc + .\fichiers_hrs\ENFANTSALARIE.asc .\fichiers_hrs\%SIREN%_ENFANTSALARIE.asc
COPY .\En_Tete\RETENUESALARIE_EN_TETE.asc + .\fichiers_hrs\RETENUESALARIE.asc .\fichiers_hrs\%SIREN%_RETENUESALARIE.asc
COPY .\En_Tete\ABSENCESALARIE_EN_TETE.asc + .\fichiers_hrs\ABSENCESALARIE.asc .\fichiers_hrs\%SIREN%_ABSENCESALARIE.asc
COPY .\En_Tete\CHOIXCOD_EN_TETE.asc + .\fichiers_hrs\CHOIXCOD.asc .\fichiers_hrs\%SIREN%_CHOIXCOD.asc
COPY .\En_Tete\HISTOCUMSAL_EN_TETE.asc + .\fichiers_hrs\HISTOCUMSAL.asc .\fichiers_hrs\%SIREN%_HISTOCUMSAL.asc



