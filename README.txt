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

NOUVEAUTÉS v0.4.5
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

CORRECTION / ÉVOLUTION v0.4.5
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

CORRECTIONS v0.4.5
- Qualifications visibles par défaut.
- Mise en page Autres contrôles reprise.
- Retrait des qualifications dans Certificats.
- Sexe et nom de l'animal conservés.
- 4 derniers chiffres du bovin affichés en grand.
- Export remboursements détaillé par maladie et méthode.

NOUVEAUTÉS v0.4.5
- Compteurs Accueil recalculés uniquement sur les maladies réellement demandées et les méthodes retenues.
- Résultats manquants / labo / non conformes cohérents avec l'écran Analyses.
- Remboursements : statut Remboursé + date de remboursement.
- Deux récapitulatifs distincts :
  * Remboursable / à payer
  * Déjà remboursé
- Filtre Tout / À rembourser / Remboursé.

CORRECTION v0.4.5
- Export remboursements détaillé par catégorie d'analyse.
- Exemple : BVD Ag : 5 analyses éligibles | IBR : 5 analyses éligibles.
- Ajout de colonnes séparées Nb BVD Ag, Nb BVD PCR, Nb IBR, etc. selon les analyses présentes.
- Total annuel et détail par concours conservés.

NOUVEAUTÉS v0.4.5
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
