# Reprise_HRS

# Objectifs : Les scripts ont pour objectifs de transformer des fichiers au format HRU vers le format HRS
# Périmètre de la reprise HRS

- Salaries,
- Contrat de travail,
- RIB
- Enfant des salariés,
- Convention collective,
- Classification,
- Absences salariés 
- Bulletin de paie
- Historique
- Etablissement
- Ventilation analytiques
- Saisies arrets + pensions alimentaires

# Fichiers HRU nécessaires

- CCNEMPLOYEUR,
- EMAIL,
- EMPLOYEUR,
- ENFANTS,
- ENTETEPAIE,
- ETABLISSEMENT,
- EVENEMENTS,
- GENCONTRAT,
- IMPUTATIONANALYTIQUE,
- INDIVIDU,
- PERMSEJOUR,
- VALIDCONTRAT
- SAISIEARRET
- PENSIONALIMENTAURE
- COMPTEURS
- PEOPLEDOC_SALARIES pour la gestion de People Doc
- TRSCLASSIFICATION1
- TRSCLASSIFICATION2
- TRSCLASSIFICATION3
- TRSCLASSIFICATION4
- TRSCLASSIFICATION5

# Procédure

- Exporter les données depuis Synapps
- Compléter le fichier de paramétrage pour la migration HRS
- Placer les fichiers csv de HRU dans le répértoire sources_hru + le fichier de paramétrage
- Lancer le script d'import (les fichiers dtsx ne sont pas sur github),
- Lancer le script de reprise,
- Lancer le script d'export,