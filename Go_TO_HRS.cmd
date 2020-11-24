@echo off
set /p user=Taper le login SQL : 
set /p password=Taper le password SQL : 
set /p server=Taper le nom du serveur SQL : 
set /p database=Taper le nom de la base : 
echo Reprise en cours veuillez patienter
sqlcmd -S %server% -U %user% -P %password% -i .\script\Reprise_CCN.sql -i .\script\Reprise_VENTILATIONINDIVIDUS.sql -i .\script\Reprise_CLASSIFICATIONS.sql -i .\script\Reprise_CHOIXCOD_MINIMUMCONVENT.sql -i .\script\Reprise_ETABLISSEMENTS.sql -i .\script\Reprise_SALARIES.sql -i .\script\Reprise_CONTRATTRAVAIL.sql -i .\script\Reprise_DEPORTSAL_SALARIECOMPL.sql -i .\script\Reprise_ENFANTSALARIE.sql -i .\script\Reprise_PGHISTODETAIL.sql -i .\script\Reprise_RIB.sql -i .\script\Reprise_ANALYTIQUE.sql -i .\script\Reprise_TAUXPAS.sql -i .\script\Reprise_RETENUESALARIE.sql -i .\script\Reprise_ABSENCESALARIE.sql -i .\script\Reprise_BULLETINS.sql -i .\script\Reprise_STAT.sql -o .\logs\logs.txt
echo Fin de la reprise
SET COLONNE1='='
SET COLONNE2='1'
set /p SIREN=Taper le SIREN :
echo Vous avez selectionné %SIREN%
sqlcmd -S 10.113.24.6 -U NicolasDenis -P NDenis!2020 -i .\script\Export.sql -s "|" -W -h -1
mkdir .\fichiers_hrs\%SIREN%
COPY .\Entete\SALARIES_EN_TETE.asc + .\fichiers_hrs\SALARIES.asc .\fichiers_hrs\%SIREN%\%SIREN%_SALARIES.asc
COPY .\Entete\CONTRATTRAVAIL_EN_TETE.asc + .\fichiers_hrs\CONTRATTRAVAIL.asc .\fichiers_hrs\%SIREN%\%SIREN%_CONTRATTRAVAIL.asc
COPY .\Entete\RIB_EN_TETE.asc + .\fichiers_hrs\RIB.asc .\fichiers_hrs\%SIREN%\%SIREN%_RIB.asc
COPY .\Entete\DEPORTSAL_EN_TETE.asc + .\fichiers_hrs\DEPORTSAL.asc .\fichiers_hrs\%SIREN%\%SIREN%_DEPORTSAL.asc
COPY .\Entete\SALARIESCOMPL_EN_TETE.asc + .\fichiers_hrs\SALARIESCOMPL.asc .\fichiers_hrs\%SIREN%\%SIREN%_SALARIESCOMPL.asc 
COPY .\Entete\ENFANTSALARIE_EN_TETE.asc + .\fichiers_hrs\ENFANTSALARIE.asc .\fichiers_hrs\%SIREN%\%SIREN%_ENFANTSALARIE.asc
COPY .\Entete\RETENUESALARIE_EN_TETE.asc + .\fichiers_hrs\RETENUESALARIE.asc .\fichiers_hrs\%SIREN%\%SIREN%_RETENUESALARIE.asc
COPY .\Entete\ABSENCESALARIE_EN_TETE.asc + .\fichiers_hrs\ABSENCESALARIE.asc .\fichiers_hrs\%SIREN%\%SIREN%_ABSENCESALARIE.asc
COPY .\Entete\CHOIXCOD_EN_TETE.asc + .\fichiers_hrs\CHOIXCOD.asc .\fichiers_hrs\%SIREN%\%SIREN%_CHOIXCOD.asc
COPY .\Entete\HISTOCUMSAL_EN_TETE.asc + .\fichiers_hrs\HISTOCUMSAL.asc .\fichiers_hrs\%SIREN%\%SIREN%_HISTOCUMSAL.asc
