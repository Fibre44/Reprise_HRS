@echo off
set /p user=Saisir le login SQL : 
set /p password=Saisir le password SQL : 
set /p server=Saisir le nom du serveur SQL : 
set /p database=Saisir le nom de la base :
set /p qexport=Souhaitez aller directement à l'export ? [1/0] :
if %qexport%==1 goto debutexport
set /p razhru=Souhaitez vous faire RAZ des tables HRU ? [1/0] :
if %razhru%==1 (
    sqlcmd -S %server% -U %user% -P %password% -d %database% -i .\script\Etape_5_RAZ_Tables_HRU.sql
)
set /p razhrs=Souhaitez vous faire RAZ des tables HRs ? [1/0] :
if %razhrs%==1 (
    sqlcmd -S %server% -U %user% -P %password% -d %database% -i .\script\Etape_4_RAZ_Tables_HRS.sql
)
set /p importhru=Lancer l'import des tables HRU ? [1/0] :
if %importhru%==1 (

    dtexec /f ".\dtsx\INDIVIDU.dtsx" /l "DTS.LogProviderTextFile;.\logs\log_individu.txt"
    dtexec /f ".\dtsx\EMAIL.dtsx" /l "DTS.LogProviderTextFile;.\logs\log_email.txt"    
    dtexec /f ".\dtsx\EMPLOYEUR.dtsx" /l "DTS.LogProviderTextFile;.\logs\log_employeur.txt"    
    dtexec /f ".\dtsx\VALIDCONTRAT.dtsx" /l "DTS.LogProviderTextFile;.\logs\log_validcontrat.txt"
    dtexec /f ".\dtsx\GENCONTRAT.dtsx" /l "DTS.LogProviderTextFile;.\logs\log_gencontrat.txt"
    dtexec /f ".\dtsx\ENFANTS.dtsx" /l "DTS.LogProviderTextFile;.\logs\log_enfants.txt"  
    dtexec /f ".\dtsx\EVENEMENTS.dtsx" /l "DTS.LogProviderTextFile;.\logs\log_evenements.txt"    
    dtexec /f ".\dtsx\PERMISSEJOUR.dtsx" /l "DTS.LogProviderTextFile;.\logs\log_permissejour.txt"
    dtexec /f ".\dtsx\TAUXPAS.dtsx" /l "DTS.LogProviderTextFile;.\logs\log_tauxpas.txt"
    dtexec /f ".\dtsx\ENTETEPAIE.dtsx" /l "DTS.LogProviderTextFile;.\logs\log_entetepaie.txt"    
    dtexec /f ".\dtsx\ETABLISSEMENTS.dtsx" /l "DTS.LogProviderTextFile;.\logs\log_etablissements.txt"    
    dtexec /f ".\dtsx\SAISIEARRET.dtsx" /l "DTS.LogProviderTextFile;.\logs\log_saisiearret.txt"  
    dtexec /f ".\dtsx\PENSIONALIMENTAIRE.dtsx" /l "DTS.LogProviderTextFile;.\logs\log_pensionalimentaire.txt"  
    dtexec /f ".\dtsx\COMPTEURS.dtsx" /l "DTS.LogProviderTextFile;.\logs\log_compteurs.txt"    
    dtexec /f ".\dtsx\CLASSIF1.dtsx" /l "DTS.LogProviderTextFile;.\logs\log_classif1.txt"     
    dtexec /f ".\dtsx\CLASSIF3.dtsx" /l "DTS.LogProviderTextFile;.\logs\log_classif3.txt" 
    dtexec /f ".\dtsx\CLASSIF4.dtsx" /l "DTS.LogProviderTextFile;.\logs\log_classif4.txt"        
    dtexec /f ".\dtsx\CLASSIF5.dtsx" /l "DTS.LogProviderTextFile;.\logs\log_classif5.txt"     
    dtexec /f ".\dtsx\IMPUTATIONANALYTIQUE.dtsx" /l "DTS.LogProviderTextFile;.\logs\log_analytique.txt"
    dtexec /f ".\dtsx\CCN.dtsx" /l "DTS.LogProviderTextFile;.\logs\log_CCN.txt"   
    sqlcmd -S %server% -U %user% -P %password% -d %database% -i .\script\Modifications_tables_HRU.sql
    sqlcmd -S %server% -U %user% -P %password% -d %database% -i .\script\Ajout_Nom_des_tables.sql
)
::Création des paramétres
set /p matricule=Souhaitez vous reprendre les matricules à l identique ? [1/0] :
::mode de reprise 1
if %matricule%==1 goto compta
set /p matricule=Souhaitez vous reprendre les matricules + CEMP avec recodification ? [2/0] :
::mode de reprise 2
if %matricule%==2 goto compta
set /p matricule=Souhaitez vous reprendre les matricules + CEMP + recodification ? [3/0] :
::mode de reprise 3
if %matricule%==3 
:compta
set /p longueur_auxiliaire=Longueur des comptes auxiliaires ?
set /p prefixe_auxiliaire=Prefixe auxiliaire ?
::import paramétres
sqlcmd -S %server% -U %user% -P %password% -d %database% -i .\script\Import_param.sql
echo Import des paramétres
echo Reprise en cours veuillez patienter
sqlcmd -S %server% -U %user% -P %password% -d %database% -i .\script\Reprise_CCN.sql -i .\script\Reprise_VENTILATIONINDIVIDUS.sql -i .\script\Reprise_CLASSIFICATIONS.sql -i .\script\Reprise_CHOIXCOD_MINIMUMCONVENT.sql -i .\script\Reprise_ETABLISSEMENTS.sql -i .\script\Reprise_SALARIES.sql -i .\script\Reprise_CONTRATTRAVAIL.sql -i .\script\Reprise_DEPORTSAL_SALARIECOMPL.sql -i .\script\Reprise_ENFANTSALARIE.sql -i .\script\Reprise_PGHISTODETAIL.sql -i .\script\Reprise_RIB.sql -i .\script\Reprise_ANALYTIQUE.sql -i .\script\Reprise_TAUXPAS.sql -i .\script\Reprise_RETENUESALARIE.sql -i .\script\Reprise_ABSENCESALARIE.sql -i .\script\Reprise_BULLETINS.sql -i .\script\Reprise_STAT.sql -o .\logs\logs.txt
echo Fin de la reprise
:debutexport
set COLONNE1='='
set COLONNE2='1'
set /p SIREN=Taper le SIREN à exporter :
echo Vous avez selectionné le %SIREN%
::Controler que le SIREN existe sinon le script crash
sqlcmd -S %server% -U %user% -P %password% -d %database% -i .\script\Export.sql -s "|" -W -h -1
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
echo Fin d'export
:: ajouter une sortie de boucle
set /p export=Pour exporter un autre SIREN taper 1 :
if %export% ==1 goto debutexport
else echo Fin de traitement
exit
