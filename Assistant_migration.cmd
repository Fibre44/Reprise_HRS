@echo off
:connexion
    set /p user=Saisir le login SQL :
    set /p password=Saisir le password SQL : 
    set /p server=Saisir l'IP du serveur SQL : 
    set /p database=Saisir le nom de la base :
    echo Tentative de connexion
    sqlcmd -b -S %server% -U %user% -P %password% -d %database% -q exit
    if not errorlevel 1 (
        echo connexion SQL ok
        goto etape
    )
    echo erreur de connexion au serveur SQL
    goto connexion
:etape
    set /p qexport=Souhaitez vous aller directement à l'export ? [1/0] :
    if %qexport%==1 goto debutexport
    set /p razhru=Souhaitez vous faire RAZ des tables HRU ? [1/0] :
    if %razhru%==1 (
        sqlcmd -S %server% -U %user% -P %password% -d %database% -i .\script\Etape_5_RAZ_Tables_HRU.sql
    )
    set /p razhrs=Souhaitez vous faire RAZ des tables HRS ? [1/0] :
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
:param
    ::Création des paramétres
    set /p matricule=Souhaitez vous reprendre les matricules à l identique ? [1/0] :
    ::mode de reprise 1
    if %matricule%==1 goto compta
    set /p matricule=Souhaitez vous reprendre les matricules + CEMP + matricule HRU ? [2/0] :
    ::mode de reprise 2
    if %matricule%==2 goto compta
    set /p matricule=Souhaitez vous reprendre les matricules + CEMP + reodification ? [3/0] :
    ::mode de reprise 3
:compta
    set /p longueur_auxiliaire=Longueur des comptes auxiliaires ? :
    set /p prefixe_auxiliaire=Prefixe auxiliaire ? :
    set /p utilisationanalytique=Utilisez vous l'analytique ?[1/0] :
    if %utilisationanalytique%==0 (
        set axe1="-"
        set axe2="-"
        set axe3="-"
        set axe4="-"
        set axe5="-"
        goto zonelibre
    )
    set /p axe1=Longueur axe 1 ?
    set /p axe2=Longueur axe 2 ?
    set /p axe3=Longueur axe 3 ?
    set /p axe4=Longueur axe 4 ?
    set /p axe5=Longueur axe 5 ?

:zonelibre
    set /p zonelibre=Utilisez vous les zones libres ? [1/0] :
    if %zonelibre%==0 (
        set codestat="-"
        set travailN1="-"
        set travailN2="-"
        set travailN3="-"
        set travailN4="-"
        set boite1="-"
        set boite2="-"
        set boite3="-"
        set boite4="-"
        goto divers
    )
    set codestat="CTA01"
    set travailN1="CTA02"
    set travailN2="CTA03"
    set travailN3="CTA04"
    set travailN4="CTA05"
    set boite1="GCB1"
    set boite2="GCB2"
    set boite3="GCB3"
    set boite4="GCB4"
:divers
    set /p bulletin=Reprenez vous les bulletins ?[1/0] :
    if %bulletin%==1 (
        set bulletin="X"
    )
    if %bulletin%==0 (
        set bulletin="-" 
    )
    set /p partageemploi=Partagez vous les codes emplois ?[1/0] :
    if %partageemploi%==1 (
        set partageemploi="X"
    )
    if %partageemploi%==0 (
        set partageemploi="-" 
    )
    set /p partagezonlibre=Partagez vous les zones libres ?[1/0] :
    if %partagezonlibre%==1 (
        set partagezonlibre="X"
    )
    if %partagezonlibre%==0 (
        set partagezonlibre="-" 
    )
    set /p codebulletinpaie=Si vous utilisez un code bulletin différent de PBG veuillez l'indiquer sinon 0 :
    if %codebulletinpaie%==0 (
        set codebulletinpaie="PBG"
    )
    set /p cp=Utilisez vous des CP ouvrés ?[1/0] :
    if %cp%==1 (
        set cp="2.08"
    )
    if %cp%==0 (
        set cp="2.50"
    )
    echo Vos paramètres
    echo Reprise bulletin : %matricule%
    echo Longueur auxiliaire : %longueur_auxiliaire%
    echo Prefixe auxiliaire : %prefixe_auxiliaire%
    echo Analyique : %utilisationanalytique%
    echo Axe 1 : %axe1%
    echo Axe 2 : %axe2%
    echo Axe 3 : %axe3%
    echo Axe 4 : %axe4%
    echo Axe 5 : %axe5%
    echo Zone libre : %zonelibre%
    echo partage emploi : %partageemploi%
    echo partage zone libre : %partagezonlibre%
    echo CP : %cp%
    set /p lancement=Pour modifier vos choix taper 1 sinon 0 [1/0]
    if %lancement%==1 goto param
    echo Lancement import des paramétres
:import_param
    sqlcmd -S %server% -U %user% -P %password% -d %database% -i .\script\Import_param.sql
    echo Import des paramétres
    echo Reprise en cours veuillez patienter le traitement peut etre long 15 à 30 minutes heure de début %time%
    sqlcmd -S %server% -U %user% -P %password% -d %database% -i .\script\Reprise_CCN.sql -o .\logs\logs_ccn.txt
    echo Traitement ccn %time%
     sqlcmd -S %server% -U %user% -P %password% -d %database% -i .\script\Reprise_VENTILATIONINDIVIDUS.sql -o .\logs\logs_ventilations.txt
    echo Traitement ventilation salariés %time%
    sqlcmd -S %server% -U %user% -P %password% -d %database% -i .\script\Reprise_CLASSIFICATIONS.sql -o .\logs\logs_classifications.txt
    sqlcmd -S %server% -U %user% -P %password% -d %database% -i .\script\Reprise_CHOIXCOD_MINIMUMCONVENT.sql -o .\logs\logs_choixcod.txt
    echo Traitement classifications %time%
    sqlcmd -S %server% -U %user% -P %password% -d %database% -i .\script\Reprise_ETABLISSEMENTS.sql -o .\logs\logs_etablissements.txt
    echo Traitement etablissements %time%
    sqlcmd -S %server% -U %user% -P %password% -d %database% -i .\script\Reprise_SALARIES.sql -o .\logs\logs_salaries.txt
    echo Traitement salaries %time%
    sqlcmd -S %server% -U %user% -P %password% -d %database% -i .\script\Reprise_CONTRATTRAVAIL.sql -o .\logs\logs_contrats.txt
    echo Traitement contrats travails %time%
    sqlcmd -S %server% -U %user% -P %password% -d %database% -i .\script\Reprise_DEPORTSAL_SALARIECOMPL.sql -o .\logs\logs_salariescompldeportsal.txt
    echo Traitement salariescompl+deportsal %time%
    sqlcmd -S %server% -U %user% -P %password% -d %database% -i .\script\Reprise_ENFANTSALARIE.sql -o .\logs\logs_enfants.txt
    echo Traitement enfants %time%
    sqlcmd -S %server% -U %user% -P %password% -d %database% -i .\script\Reprise_PGHISTODETAIL.sql -o .\logs\logs_pghistodetail.txt
    echo Traitement PGHISTODETAIL %time%
    sqlcmd -S %server% -U %user% -P %password% -d %database% -i .\script\Reprise_RIB.sql -o .\logs\logs_rib.txt
    echo Traitement RIB %time%
    sqlcmd -S %server% -U %user% -P %password% -d %database% -i .\script\Reprise_ANALYTIQUE.sql -o .\logs\logs_analytique.txt
    echo Traitement Analytique %time%
    sqlcmd -S %server% -U %user% -P %password% -d %database% -i .\script\Reprise_TAUXPAS.sql -o .\logs\logs_tauxpas.txt
    echo Traitement TAUXPAS %time%
    sqlcmd -S %server% -U %user% -P %password% -d %database% -i .\script\Reprise_RETENUESALARIE.sql -o .\logs\logs_retenue.txt
    echo Traitement saisie arret %time%
    sqlcmd -S %server% -U %user% -P %password% -d %database% -i.\script\Reprise_ABSENCESALARIE.sql -o .\logs\logs_absence.txt
    echo Traitement absences+CP %time%
    sqlcmd -S %server% -U %user% -P %password% -d %database% -i .\script\Reprise_BULLETINS.sql -o .\logs\logs_bulletin.txt
    echo Traitement bulletins %time%
    sqlcmd -S %server% -U %user% -P %password% -d %database% -i .\script\Reprise_STAT.sql
    echo Fin de la reprise à %time%
    echo Liste des anomalies 
    sqlcmd -b -S %server% -U %user% -P %password% -d %database% -Q "SELECT AN_MATRICULE,AN_COMMENTAIRE FROM ANOMALIES"
:debutexport
    echo Liste des SIREN
    sqlcmd -b -S %server% -U %user% -P %password% -d %database% -Q "SELECT [Raison Sociale],Siren FROM EMPLOYEUR"
    set COLONNE1='='
    set COLONNE2='1'
    set /p SIREN=Taper le SIREN à exporter :
    echo Vous avez selectionné le %SIREN%
    ::Controler que le SIREN existe sinon le script crash
    sqlcmd -S %server% -U %user% -P %password% -d %database% -i .\script\Export.sql -s "|" -W -h -1
    mkdir .\fichiers_hrs\%SIREN%
    copy .\Entete\SALARIES_EN_TETE.asc + .\temp\SALARIES.asc .\fichiers_hrs\%SIREN%\%SIREN%_SALARIES.asc
    copy .\Entete\CONTRATTRAVAIL_EN_TETE.asc + .\temp\CONTRATTRAVAIL.asc .\fichiers_hrs\%SIREN%\%SIREN%_CONTRATTRAVAIL.asc
    copy .\Entete\RIB_EN_TETE.asc + .\temp\RIB.asc .\fichiers_hrs\%SIREN%\%SIREN%_RIB.asc
    copy .\Entete\DEPORTSAL_EN_TETE.asc + .\temp\DEPORTSAL.asc .\fichiers_hrs\%SIREN%\%SIREN%_DEPORTSAL.asc
    copy .\Entete\SALARIESCOMPL_EN_TETE.asc + .\temp\SALARIESCOMPL.asc .\fichiers_hrs\%SIREN%\%SIREN%_SALARIESCOMPL.asc 
    copy .\Entete\ENFANTSALARIE_EN_TETE.asc + .\temp\ENFANTSALARIE.asc .\fichiers_hrs\%SIREN%\%SIREN%_ENFANTSALARIE.asc
    copy .\Entete\RETENUESALARIE_EN_TETE.asc + .\temp\RETENUESALARIE.asc .\fichiers_hrs\%SIREN%\%SIREN%_RETENUESALARIE.asc
    copy .\Entete\ABSENCESALARIE_EN_TETE.asc + .\temp\ABSENCESALARIE.asc .\fichiers_hrs\%SIREN%\%SIREN%_ABSENCESALARIE.asc
    copy .\Entete\CHOIXCOD_EN_TETE.asc + .\temp\CHOIXCOD.asc .\fichiers_hrs\%SIREN%\%SIREN%_CHOIXCOD.asc
    copy .\Entete\HISTOCUMSAL_EN_TETE.asc + .\temp\HISTOCUMSAL.asc .\fichiers_hrs\%SIREN%\%SIREN%_HISTOCUMSAL.asc
    cd .\temp
    echo Ouverture du dossier temp
    del *.asc
    echo Suppresion des fichiers temporaires
    echo Fin d'export
    :: ajouter une sortie de boucle
    set /p export=Pour exporter un autre SIREN taper 1 sinon 0 pour quitter :
    if %export% ==1 goto debutexport
    else echo Fin de traitement
exit
