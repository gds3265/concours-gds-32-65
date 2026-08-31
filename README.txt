SUIVI DES CONCOURS v0.3.11

Cette version utilise le projet Supabase :
https://ckylznynqsefqkmtjcjf.supabase.co

NOUVEAUTÉS
- Données partagées entre navigateurs / PC / téléphone
- Connexion par compte Supabase
- Concours, règles, animaux, résultats et certificats stockés dans Supabase
- Cache PWA renouvelé (v0.3.11 affichée partout)
- Ajout manuel et import CSV
- Analyses nécessaires automatiquement selon l'âge
- Tout conforme / Tout en cours labo / Tout en attente
- Analyse inutile, positif, à recontrôler, non conforme
- Certificat final
- Remboursement seulement si analyse nécessaire + conforme + animal sur certificat
- Export CSV

INSTALLATION
1. Ouvrir Supabase > SQL Editor.
2. Exécuter tout le contenu de SQL_SETUP.sql UNE SEULE FOIS.
3. Remplacer sur GitHub les anciens fichiers par :
   index.html
   config.js
   manifest.json
   sw.js
4. Attendre le redéploiement GitHub Pages.
5. Ouvrir l'application et se connecter avec un compte utilisateur existant du projet Supabase.

IMPORTANT
Les utilisateurs doivent exister dans Supabase Auth.
Les tables ne sont PAS ouvertes au public : seuls les utilisateurs authentifiés peuvent y accéder.

CORRECTION v0.3.11
- Colonne SQL 'analyse' renommée 'analyse_type' pour éviter le conflit avec le mot-clé PostgreSQL ANALYSE/ANALYZE.

CORRECTION v0.3.11
- Configuration Supabase intégrée directement dans index.html.
- Plus de fichier config.js nécessaire.
- Cache PWA renouvelé.

CORRECTION v0.3.11
- Correction d'une erreur de syntaxe JavaScript qui bloquait l'application avant la connexion.
- Syntaxe JavaScript vérifiée avec Node.js.

CORRECTION v0.3.11
- Formulaires passés en grille responsive pour éviter les champs/boutons hors écran.
- Largeur des champs limitée au conteneur.
- Navigation mobile améliorée.
- Message explicite si aucun concours, aucune règle ou aucun animal.
- Cache renouvelé.

NOUVEAUTÉ v0.3.11 : module de paramétrage général par maladie, demandes par concours, règles BVD pré-enregistrées et logique de méthode de référence pour le remboursement.

NOUVEAUTÉS v0.3.11
- Deux imports séparés dans Animaux :
  1) liste des inscrits partenaire ;
  2) fichier bovins métier.
- La liste partenaire peut ne pas contenir de n° cheptel.
- Rapprochement automatique sur le n° bovin.
- Complément automatique du cheptel, détenteur et date de naissance.
- Signalement :
  * retrouvé / cohérent ;
  * complété par le fichier métier ;
  * détenteur à vérifier ;
  * animal non retrouvé ;
  * pas encore contrôlé.
- Le fichier métier ne crée jamais de nouveaux inscrits.

NOUVEAUTÉS v0.3.11
- Un concours peut contenir plusieurs départements.
- Liste des départements participants.
- Import des inscrits rattaché à un département.
- Import du fichier métier rattaché au même département.
- Contrôle métier effectué uniquement sur les inscrits du département correspondant.
- Export CSV minimal des n° bovins :
  * tout le concours ;
  * ou un département seulement.
- Un seul concours conserve le récap global.

CORRECTION v0.3.11
- Ajout du bloc Départements participants qui manquait dans l'interface.
- Correction de l'erreur 'Cannot set properties of null (setting innerHTML)'.
- Les rendus Paramétrage / Demandes / Départements utilisent maintenant des sélecteurs DOM explicites.
- Le message de démarrage ne suppose plus systématiquement que le SQL est en cause.

CORRECTION v0.3.11
- Délai maximum par défaut avant concours fixé à 21 jours pour les demandes et règles sanitaires.

CORRECTION v0.3.11
- Import des CSV Windows-1252 / ANSI.
- Lecture CSV robuste avec champs entre guillemets et retours à la ligne internes.
- Reconnaissance des colonnes N° ANIMAL, N°CHEPTEL, Propriétaire, DATE NAISSANCE.
- Ajout de variantes de noms de colonnes.
- Ordre des cadres Animaux :
  1. Importer la liste des inscrits
  2. Exporter les n° bovins
  3. Importer le fichier bovins métier
  4. Contrôler les inscrits

NOUVEAUTÉS v0.3.11
- Récap après import : lignes lues, reconnus, importés, déjà présents, doublons, sans numéro.
- Récap par n° EDE.
- Tri par défaut EDE puis n° bovin, avec autres tris disponibles.

NOUVEAUTÉS v0.3.11
- Regroupe toutes les corrections de la v0.3.6.
- Suivi du certificat :
  * Non reçu
  * Reçu – en attente de validation
  * Validé / prêt à signer
  * Signé
- Date de réception du certificat.
- Date de signature.
- Transmission mail / direct / papier.
- Commentaire.
- Filtre des certificats par statut.
- Récapitulatif des certificats par éleveur.
- Compteur Accueil : certificats reçus à valider.

CORRECTION v0.3.11
- Correction de l'erreur 'ANALYSES is not defined'.
- Cache renouvelé.

NOUVEAUTÉS v0.3.11
- Import métier adapté au format réel GDS : Identifiant bovin = ="FR ...", Exploitation = EDE.
- Nettoyage automatique de FR, espaces et syntaxe Excel ="...".
- Diagnostic de l'import métier : lignes, n° reconnus, rapprochés, non retrouvés, exemple de n° lu.
- Comparaison EDE et date de naissance.
- Points de vérification complémentaires paramétrables au cheptel ou à l'animal.
- Types : qualification, vaccination, document, autre.
- Statuts : À vérifier, Conforme, Non conforme, Non applicable.
- Pré-paramétrage possible pour IBR, BVD, Brucellose, Leucose, Tuberculose.
- Affichage des contrôles dans Certificats et indicateur Contrôles OK / à finir.

CORRECTION v0.3.11
- Rapprochement bovin sur les 10 chiffres du n° national.
- Formats équivalents : FR 6518025393 / FR6518025393 / ="FR 6518025393" / 6518025393.
- N° EDE normalisé sur les chiffres.
- Vérification sur les fichiers fournis : 67 inscrits, 67 animaux métier, 67 correspondances.

NOUVEAUTES v0.3.11
- Analyses : une colonne par maladie demandee, pas les analyses non necessaires.
- Methode prioritaire choisie automatiquement selon age/regles ; alternatives disponibles dans le menu de methode.
- BVD : antigenemie prioritaire ; serum prefere a partir de 3 mois lorsque recevable.
- Tout conforme repare (on_conflict analyse_type).
- Validation sanitaire par maladie : une methode recevable conforme suffit.
- Vue globale Qualifications des cheptels avec tous les EDE et validation en serie.

NOUVEAUTÉS v0.5.9
- Recherche globale par éleveur ou n° cheptel.
- Onglet Animaux renommé Liste inscrits.
- Analyses : vue tout le concours, ajout rapide d'un animal, ajout d'une analyse non prévue.
- Analyses affichées par maladie demandée avec séparation visuelle.
- Qualifications séparées dans leur propre onglet.
- Autres contrôles séparés des certificats et commentaires corrigés.
- Ergonomie des animaux du certificat revue.
- Remboursements agrégés par cheptel et analyse.
- Tarifs par analyse paramétrables.
- Coût unitaire modifiable au cas par cas.
- Cases Justificatif reçu / À rembourser.
- Export CSV pour publipostage.

CORRECTION / ÉVOLUTION v0.5.9
- Correction de l'affichage de l'onglet Autres contrôles.
- Remboursements gérés à l'année civile.
- Filtres : année / concours / éleveur-EDE.
- Vue tous les concours de l'année et tous les éleveurs.
- Vue tous les concours d'un éleveur sur l'année.
- Vue un concours et tous ses éleveurs.
- Tous les montants sont explicitement HT.
- Récap annuel par éleveur avec :
  * détail par concours ;
  * nombre d'analyses éligibles ;
  * total annuel HT.
- Export publipostage : une ligne par éleveur avec total annuel HT et détail par concours.

CORRECTIONS v0.5.9
- Qualifications visibles par défaut.
- Mise en page Autres contrôles reprise.
- Retrait des qualifications dans Certificats.
- Sexe et nom de l'animal conservés.
- 4 derniers chiffres du bovin affichés en grand.
- Export remboursements détaillé par maladie et méthode.

NOUVEAUTÉS v0.5.9
- Compteurs Accueil recalculés uniquement sur les maladies réellement demandées et les méthodes retenues.
- Résultats manquants / labo / non conformes cohérents avec l'écran Analyses.
- Remboursements : statut Remboursé + date de remboursement.
- Deux récapitulatifs distincts :
  * Remboursable / à payer
  * Déjà remboursé
- Filtre Tout / À rembourser / Remboursé.

CORRECTION v0.5.9
- Export remboursements détaillé par catégorie d'analyse.
- Exemple : BVD Ag : 5 analyses éligibles | IBR : 5 analyses éligibles.
- Ajout de colonnes séparées Nb BVD Ag, Nb BVD PCR, Nb IBR, etc. selon les analyses présentes.
- Total annuel et détail par concours conservés.

NOUVEAUTÉS v0.5.9
- Nouvel onglet Validation rapide, uniquement par éleveur / n° cheptel.
- Mode Validation sur ordinateur :
  * affiche bovins, analyses déjà saisies et qualifications ;
  * bouton Valider les éléments en attente ;
  * ne modifie jamais les statuts déjà renseignés.
- Mode Contrôle certificat papier :
  * saisie obligatoire des 10 chiffres complets ;
  * correspondance exacte avec le listing ;
  * alerte si n° absent ou déjà pointé ;
  * le bovin pointé passe directement Sur certificat final.
- Compteur des bovins vérifiés sur papier.

CORRECTIONS v0.5.9
- Les listes de concours sont maintenant alimentées dans Autres contrôles et Validation rapide.
- Validation rapide déplacée entre Certificats et Remboursements dans la navigation et dans l'application.
- Ajout d'une liste des concours enregistrés avec possibilité de suppression.
- Suppression sécurisée : confirmation + saisie du mot SUPPRIMER.
- La suppression d'un concours supprime automatiquement ses données liées grâce aux relations Supabase en cascade.
- Aucun changement SQL requis.

NOUVEAUTÉS v0.5.9
- Validation rapide : choix Mail / Direct.
- Bouton de validation du certificat :
  * passe le certificat en reçu + validé ;
  * date de réception = date du jour ;
  * date de validation/signature = date du jour ;
  * mode de transmission enregistré.
- Bloc Attention dans Validation rapide si une anomalie ou un point à vérifier existe déjà :
  * qualification non conforme / à vérifier ;
  * analyse positive / non conforme / à recontrôler ;
  * contrôle complémentaire cheptel ou animal non conforme / à vérifier.
- Aucune modification SQL requise.

MODIFICATIONS v0.5.9
- Validation rapide simplifiée en un seul flux.
- Suppression des boutons Validation sur ordinateur / Contrôle certificat papier.
- Suppression des boutons Tous les bovins / Aucun bovin.
- Boutons Sélectionner tout + Valider le certificat aujourd'hui côte à côte.
- La saisie des 10 chiffres du certificat papier reste directement disponible.
- Le bouton Valider le certificat aujourd'hui complète les éléments encore en attente puis valide le certificat.
- Certificats : ajout du n° cheptel dans le récapitulatif.
- Certificats : dates Reçu le et Validé le modifiables directement dans le récapitulatif.
- Aucun changement SQL requis.

NOUVEAUTÉS v0.5.9
- Logo GDS 32-65 intégré.
- Suivi certificats : recherche par n° cheptel ou nom.
- Clic sur N° cheptel ou Éleveur pour trier croissant/décroissant.
- Validation rapide et Certificats : statuts À vérifier / Présent / Non présent / Refusé.
- Non présent et Refusé sont exclus du certificat final et des remboursements.
- Contrôle papier exact 10 chiffres => Présent.

CORRECTIONS v0.5.9
- Libellé Présent remplacé par Validé.
- Libellé Non présent remplacé par Pas sur certif.
- À vérifier n'est plus proposé comme choix dans Validation rapide / Certificats.
- Tant qu'un bovin reste sans statut final, la validation globale du certificat est bloquée.
- Les statuts finaux possibles sont uniquement :
  * Validé
  * Pas sur certif
  * Refusé
- Aucun changement SQL requis.

CORRECTIONS v0.5.9
- Validation rapide : enregistrement fiable du certificat en reçu / validé.
- Sélectionner tout : tous les bovins passent réellement en Validé.
- Suppression du conflit entre ancien sur_certificat et nouveau statut animal.
- Le récapitulatif des certificats se recharge après validation.
- Le statut d'erreur de synchronisation est remis à jour après succès.
- Aucun changement SQL requis.

CORRECTIONS v0.5.9
- Le certificat est enregistré avant la complétion automatique des analyses.
- Vérification après rechargement que statut et dates ont bien été récupérés depuis Supabase.
- Analyses et qualifications mises à jour en lots.
- Le bandeau de synchronisation affiche le détail réel d'une erreur API.
- Aucun changement SQL requis.

MODIFICATIONS v0.5.9
- Validation rapide déplacée avant Certificats dans la navigation et dans l'application.
- Dans Validation rapide, Entrée dans le champ N° cheptel / éleveur lance directement la recherche.
- Aucun changement SQL requis.

MODIFICATIONS v0.5.9
- Statuts certificats simplifiés à :
  * Non reçu
  * Reçu / en attente
  * Validé
- Suppression de Signé et Validé / prêt à signer.
- Les anciens certificats Signé sont convertis en Validé.


v0.5.9 : espace partenaires, accès par concours, vérification facultative et validation finale simplifiée.

NOUVEAUTÉS v0.5.9 — MODE PARTENAIRE AUTOMATIQUE
- L'adresse email du compte Supabase connecté est comparée aux invitations partenaires.
- Si le compte est invité, l'application bascule automatiquement en mode partenaire.
- Les onglets internes GDS sont masqués dans ce mode.
- Le partenaire ne voit que les concours qui lui sont attribués.
- Recherche cheptel / éleveur / bovin.
- Vue regroupée par cheptel et bovin.
- Vérification facultative, validation finale et commentaires.
- Compteurs Validés / En attente.
IMPORTANT : cette version applique la restriction dans l'interface. Le verrouillage RLS complet des tables métier sera traité séparément afin de ne pas bloquer les comptes GDS existants.

NOUVEAUTÉS v0.5.9
- Création d'un vrai compte partenaire directement depuis l'application.
- Saisie email + mot de passe initial + organisme + concours + droits.
- Création sécurisée via Supabase Edge Function.
- La service_role reste exclusivement côté Supabase.
- Table concours_admins : seuls les comptes GDS explicitement autorisés peuvent créer des partenaires.
- Association automatique du nouvel utilisateur Auth à concours_acces_partenaires.
- Aucun mot de passe partenaire n'est stocké dans l'application.

NOUVEAUTÉS v0.5.9 — IMPORT CSV INTELLIGENT
- Reconnaissance des colonnes indépendamment de leur intitulé.
- Détection d'un n° bovin par valeurs à 10 chiffres.
- Détection d'un n° EDE/cheptel par valeurs à 8 chiffres.
- Exclusion des colonnes date pour éviter de confondre une date avec un EDE.
- Nouveaux alias reconnus : NUMANIM, DATE_NAISS, N°Travail, DETENTEUR, etc.
- Si l'EDE est absent, tentative de rapprochement prudente par nom de détenteur/éleveur avec les cheptels déjà connus du concours.
- Si aucun rapprochement sûr n'est possible, le bovin reste importé sans EDE.
- Un import métier ultérieur peut compléter l'EDE grâce au rapprochement exact sur les 10 chiffres du bovin.
- Résumé d'import enrichi avec les colonnes détectées et le nombre de rapprochements par nom.
AUCUN SQL SUPPLÉMENTAIRE.

NOUVEAUTÉS v0.5.9
- Aide visible dans 1. Importer la liste des inscrits.
- Entêtes recommandées : NUMANIM, DATE_NAISS, N°Travail, DETENTEUR.
- Rappel qu'une colonne EDE à 8 chiffres est détectée automatiquement.
- Onglet Partenaires déplacé juste après Certificats.
- Aucun SQL supplémentaire.

NOUVEAUTÉS v0.5.9 — QUALIFICATIONS EN MASSE
- Tout est regroupé dans l'onglet Qualifications.
- Export CSV des n° EDE uniques du concours.
- Import automatique d'un fichier IBR, BVD ou SIGAL Bru/Leu/Tub.
- IBR : conforme uniquement si A ou AA sans date de fin.
- BVD : non conforme si NC, I1, I2 ou I3 sans date de fin.
- SIGAL : Brucellose, Leucose et Tuberculose conformes uniquement si OI.
- Les EDE du concours absents du fichier sont placés À vérifier.
- Les résultats importés alimentent directement les qualifications cheptel.
- Si une qualification nécessaire n'existe pas encore, elle est créée automatiquement.
- Le commentaire conserve le code trouvé et l'origine de l'import.
- Aucun SQL supplémentaire.

NOUVEAUTÉS v0.5.9 — CORRECTION IMPORT QUALIFICATIONS
- Lecture des fichiers séparés par ; , tabulation ou |.
- Recherche automatique de la vraie ligne d'entête dans les 20 premières lignes.
- Détection IBR/BVD sur toutes les colonnes liées à la maladie, pas uniquement Code maladie.
- Détection complémentaire via le libellé de qualification et, en dernier recours, le nom du fichier.
- Entêtes qualification plus tolérantes.
- Message d'erreur enrichi avec les entêtes réellement détectées.
- Aucun SQL supplémentaire.

NOUVEAUTÉS v0.5.9
- Trois imports séparés dans Qualifications : IBR, BVD, SIGAL.
- BVD : EDE absent du fichier = conforme.
- IBR : EDE absent = à vérifier.
- SIGAL : EDE absent = à vérifier.
- Lecture CSV renforcée avec essais automatiques de plusieurs séparateurs.
- Résumé distinct pour chaque import.
- Aucun SQL supplémentaire.

NOUVEAUTÉS v0.5.9 — CORRECTION RAPPROCHEMENT QUALIFICATIONS
- Priorité à la colonne "Code maladie" plutôt qu'à "Maladie sélectionnée".
- Les valeurs descriptives du type "IBR - IBR" ou "BVD - B.V.D (...)" sont acceptées.
- Correction du bug qui rejetait toutes les lignes avant le rapprochement EDE.
- BVD : ajout de NS comme code non conforme actif ("Troupeau non conforme BVD"), avec NC/I1/I2/I3.
- BVD : un EDE du concours absent du fichier reste conforme.
- Le résumé affiche maintenant le nombre de lignes qualifications réellement reconnues.
- Aucun SQL supplémentaire.

NOUVEAUTÉS v0.5.9 — CORRECTION FICHIERS QUALIFICATIONS EXCEL
- Correction du parseur pour les cellules Excel au format ="valeur".
- Les guillemets de ="65039026", ="IBR", ="AA", etc. ne perturbent plus le découpage des colonnes.
- IBR : les EDE et codes AA/A sont maintenant lus correctement.
- BVD : un fichier contenant uniquement les entêtes est accepté comme extraction valide sans anomalie.
- BVD entête seule = tous les EDE du concours conformes.
- Nettoyage renforcé des cellules Excel ="...".
- Aucun SQL supplémentaire.
