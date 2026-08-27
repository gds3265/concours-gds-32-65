SUIVI DES CONCOURS v0.3.10

Cette version utilise le projet Supabase :
https://ckylznynqsefqkmtjcjf.supabase.co

NOUVEAUTÉS
- Données partagées entre navigateurs / PC / téléphone
- Connexion par compte Supabase
- Concours, règles, animaux, résultats et certificats stockés dans Supabase
- Cache PWA renouvelé (v0.3.10 affichée partout)
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

CORRECTION v0.3.10
- Colonne SQL 'analyse' renommée 'analyse_type' pour éviter le conflit avec le mot-clé PostgreSQL ANALYSE/ANALYZE.

CORRECTION v0.3.10
- Configuration Supabase intégrée directement dans index.html.
- Plus de fichier config.js nécessaire.
- Cache PWA renouvelé.

CORRECTION v0.3.10
- Correction d'une erreur de syntaxe JavaScript qui bloquait l'application avant la connexion.
- Syntaxe JavaScript vérifiée avec Node.js.

CORRECTION v0.3.10
- Formulaires passés en grille responsive pour éviter les champs/boutons hors écran.
- Largeur des champs limitée au conteneur.
- Navigation mobile améliorée.
- Message explicite si aucun concours, aucune règle ou aucun animal.
- Cache renouvelé.

NOUVEAUTÉ v0.3.10 : module de paramétrage général par maladie, demandes par concours, règles BVD pré-enregistrées et logique de méthode de référence pour le remboursement.

NOUVEAUTÉS v0.3.10
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

NOUVEAUTÉS v0.3.10
- Un concours peut contenir plusieurs départements.
- Liste des départements participants.
- Import des inscrits rattaché à un département.
- Import du fichier métier rattaché au même département.
- Contrôle métier effectué uniquement sur les inscrits du département correspondant.
- Export CSV minimal des n° bovins :
  * tout le concours ;
  * ou un département seulement.
- Un seul concours conserve le récap global.

CORRECTION v0.3.10
- Ajout du bloc Départements participants qui manquait dans l'interface.
- Correction de l'erreur 'Cannot set properties of null (setting innerHTML)'.
- Les rendus Paramétrage / Demandes / Départements utilisent maintenant des sélecteurs DOM explicites.
- Le message de démarrage ne suppose plus systématiquement que le SQL est en cause.

CORRECTION v0.3.10
- Délai maximum par défaut avant concours fixé à 21 jours pour les demandes et règles sanitaires.

CORRECTION v0.3.10
- Import des CSV Windows-1252 / ANSI.
- Lecture CSV robuste avec champs entre guillemets et retours à la ligne internes.
- Reconnaissance des colonnes N° ANIMAL, N°CHEPTEL, Propriétaire, DATE NAISSANCE.
- Ajout de variantes de noms de colonnes.
- Ordre des cadres Animaux :
  1. Importer la liste des inscrits
  2. Exporter les n° bovins
  3. Importer le fichier bovins métier
  4. Contrôler les inscrits

NOUVEAUTÉS v0.3.10
- Récap après import : lignes lues, reconnus, importés, déjà présents, doublons, sans numéro.
- Récap par n° EDE.
- Tri par défaut EDE puis n° bovin, avec autres tris disponibles.

NOUVEAUTÉS v0.3.10
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

CORRECTION v0.3.10
- Correction de l'erreur 'ANALYSES is not defined'.
- Cache renouvelé.

NOUVEAUTÉS v0.3.10
- Import métier adapté au format réel GDS : Identifiant bovin = ="FR ...", Exploitation = EDE.
- Nettoyage automatique de FR, espaces et syntaxe Excel ="...".
- Diagnostic de l'import métier : lignes, n° reconnus, rapprochés, non retrouvés, exemple de n° lu.
- Comparaison EDE et date de naissance.
- Points de vérification complémentaires paramétrables au cheptel ou à l'animal.
- Types : qualification, vaccination, document, autre.
- Statuts : À vérifier, Conforme, Non conforme, Non applicable.
- Pré-paramétrage possible pour IBR, BVD, Brucellose, Leucose, Tuberculose.
- Affichage des contrôles dans Certificats et indicateur Contrôles OK / à finir.

CORRECTION v0.3.10
- Rapprochement bovin sur les 10 chiffres du n° national.
- Formats équivalents : FR 6518025393 / FR6518025393 / ="FR 6518025393" / 6518025393.
- N° EDE normalisé sur les chiffres.
- Vérification sur les fichiers fournis : 67 inscrits, 67 animaux métier, 67 correspondances.
