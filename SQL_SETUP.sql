-- ============================================================
-- SUIVI DES CONCOURS v0.2
-- À exécuter UNE SEULE FOIS dans Supabase > SQL Editor
-- ============================================================

create extension if not exists pgcrypto;

create table if not exists public.concours (
  id uuid primary key default gen_random_uuid(),
  nom text not null,
  date_concours date not null,
  type_suivi text not null default 'suivi'
    check (type_suivi in ('suivi','gere')),
  created_by uuid default auth.uid(),
  created_at timestamptz not null default now()
);

create table if not exists public.concours_regles (
  id uuid primary key default gen_random_uuid(),
  concours_id uuid not null references public.concours(id) on delete cascade,
  analyse_type text not null,
  age_min_mois integer not null default 0,
  age_max_mois integer,
  delai_max_jours integer not null default 30,
  created_by uuid default auth.uid(),
  created_at timestamptz not null default now()
);

create table if not exists public.concours_animaux (
  id uuid primary key default gen_random_uuid(),
  concours_id uuid not null references public.concours(id) on delete cascade,
  eleveur text not null,
  cheptel text,
  bovin text not null,
  naissance date,
  origine text not null default 'Ajout manuel',
  sur_certificat boolean not null default false,
  created_by uuid default auth.uid(),
  created_at timestamptz not null default now()
);

create unique index if not exists concours_animaux_unique
on public.concours_animaux(concours_id, bovin);

create table if not exists public.concours_resultats (
  id uuid primary key default gen_random_uuid(),
  animal_id uuid not null references public.concours_animaux(id) on delete cascade,
  analyse_type text not null,
  statut text not null default 'attente'
    check (statut in (
      'attente','labo','conforme','nonconforme',
      'positif','recontrole','inutile'
    )),
  date_prelevement date,
  commentaire text,
  created_by uuid default auth.uid(),
  updated_at timestamptz not null default now(),
  unique(animal_id, analyse_type)
);

create table if not exists public.concours_certificats (
  id uuid primary key default gen_random_uuid(),
  concours_id uuid not null references public.concours(id) on delete cascade,
  eleveur text not null,
  date_signature date,
  mode_transmission text,
  commentaire text,
  created_by uuid default auth.uid(),
  updated_at timestamptz not null default now(),
  unique(concours_id, eleveur)
);

-- ------------------------------------------------------------
-- RLS : accès uniquement aux utilisateurs Supabase connectés
-- ------------------------------------------------------------

alter table public.concours enable row level security;
alter table public.concours_regles enable row level security;
alter table public.concours_animaux enable row level security;
alter table public.concours_resultats enable row level security;
alter table public.concours_certificats enable row level security;

drop policy if exists "concours_authenticated_all" on public.concours;
create policy "concours_authenticated_all"
on public.concours for all
to authenticated
using (true)
with check (true);

drop policy if exists "concours_regles_authenticated_all" on public.concours_regles;
create policy "concours_regles_authenticated_all"
on public.concours_regles for all
to authenticated
using (true)
with check (true);

drop policy if exists "concours_animaux_authenticated_all" on public.concours_animaux;
create policy "concours_animaux_authenticated_all"
on public.concours_animaux for all
to authenticated
using (true)
with check (true);

drop policy if exists "concours_resultats_authenticated_all" on public.concours_resultats;
create policy "concours_resultats_authenticated_all"
on public.concours_resultats for all
to authenticated
using (true)
with check (true);

drop policy if exists "concours_certificats_authenticated_all" on public.concours_certificats;
create policy "concours_certificats_authenticated_all"
on public.concours_certificats for all
to authenticated
using (true)
with check (true);


-- v0.3.0 : catalogue général et demandes par concours
create table if not exists public.concours_regles_catalogue (id uuid primary key default gen_random_uuid(), maladie text not null, libelle_analyse text not null, matrice text, technique text, age_min_mois integer not null default 0, age_max_mois integer, recevable_validation boolean not null default true, remboursable boolean not null default true, methode_reference_remboursement boolean not null default false, created_by uuid default auth.uid(), created_at timestamptz not null default now());
create table if not exists public.concours_demandes (id uuid primary key default gen_random_uuid(), concours_id uuid not null references public.concours(id) on delete cascade, maladie text not null, delai_max_jours integer not null default 30, created_by uuid default auth.uid(), created_at timestamptz not null default now(), unique(concours_id,maladie));
alter table public.concours_regles_catalogue enable row level security;
alter table public.concours_demandes enable row level security;
drop policy if exists "concours_regles_catalogue_authenticated_all" on public.concours_regles_catalogue;
create policy "concours_regles_catalogue_authenticated_all" on public.concours_regles_catalogue for all to authenticated using (true) with check (true);
drop policy if exists "concours_demandes_authenticated_all" on public.concours_demandes;
create policy "concours_demandes_authenticated_all" on public.concours_demandes for all to authenticated using (true) with check (true);
insert into public.concours_regles_catalogue (maladie,libelle_analyse,matrice,technique,age_min_mois,age_max_mois,recevable_validation,remboursable,methode_reference_remboursement) select * from (values
('BVD','BVD Ag biopsie auriculaire','Biopsie auriculaire','Antigénémie',0,2,true,true,true),
('BVD','BVD PCR biopsie auriculaire','Biopsie auriculaire','PCR',0,2,true,true,false),
('BVD','BVD Ag sérum','Sérum','Antigénémie',0,2,false,false,false),
('BVD','BVD PCR individuelle sérum','Sérum','PCR individuelle',0,2,true,true,false),
('BVD','BVD PCR mélange sérum','Sérum','PCR mélange',0,2,false,false,false),
('BVD','BVD Ag biopsie auriculaire','Biopsie auriculaire','Antigénémie',3,null,true,true,true),
('BVD','BVD PCR biopsie auriculaire','Biopsie auriculaire','PCR',3,null,true,true,false),
('BVD','BVD Ag sérum','Sérum','Antigénémie',3,null,true,true,true),
('BVD','BVD PCR individuelle sérum','Sérum','PCR individuelle',3,null,true,true,false),
('BVD','BVD PCR mélange sérum','Sérum','PCR mélange',3,null,true,true,false)
) as v(maladie,libelle_analyse,matrice,technique,age_min_mois,age_max_mois,recevable_validation,remboursable,methode_reference_remboursement) where not exists (select 1 from public.concours_regles_catalogue where maladie='BVD');


-- ============================================================
-- v0.3.1 - CONTRÔLE DES LISTES D'INSCRITS AVEC LE FICHIER MÉTIER
-- ============================================================

alter table public.concours_animaux
  add column if not exists commune_partenaire text,
  add column if not exists controle_metier text not null default 'pending',
  add column if not exists detenteur_metier text,
  add column if not exists cheptel_metier text,
  add column if not exists naissance_metier date;



-- ============================================================
-- v0.3.2 - MULTI-DEPARTEMENTS
-- ============================================================

create table if not exists public.concours_departements (
  id uuid primary key default gen_random_uuid(),
  concours_id uuid not null references public.concours(id) on delete cascade,
  departement text not null,
  created_by uuid default auth.uid(),
  created_at timestamptz not null default now(),
  unique(concours_id, departement)
);

alter table public.concours_departements enable row level security;

drop policy if exists "concours_departements_authenticated_all" on public.concours_departements;
create policy "concours_departements_authenticated_all"
on public.concours_departements for all
to authenticated
using (true)
with check (true);

alter table public.concours_animaux
  add column if not exists departement text;

create index if not exists concours_animaux_departement_idx
on public.concours_animaux(concours_id, departement);


-- ============================================================
-- v0.3.7 - SUIVI DE RECEPTION / VALIDATION DES CERTIFICATS
-- ============================================================

alter table public.concours_certificats
  add column if not exists statut_certificat text not null default 'non_recu',
  add column if not exists date_reception date;



-- ============================================================
-- v0.3.9 - IMPORT METIER GDS + POINTS DE VERIFICATION
-- ============================================================

alter table public.concours_animaux
  add column if not exists controle_metier_commentaire text;

create table if not exists public.concours_points_controle (
  id uuid primary key default gen_random_uuid(),
  concours_id uuid not null references public.concours(id) on delete cascade,
  niveau text not null check (niveau in ('cheptel','animal')),
  type_controle text not null default 'autre',
  libelle text not null,
  obligatoire boolean not null default true,
  created_by uuid default auth.uid(),
  created_at timestamptz not null default now()
);

create table if not exists public.concours_controles (
  id uuid primary key default gen_random_uuid(),
  concours_id uuid not null references public.concours(id) on delete cascade,
  point_id uuid not null references public.concours_points_controle(id) on delete cascade,
  cle_cible text not null,
  statut text not null default 'a_verifier'
    check (statut in ('a_verifier','conforme','nonconforme','nonapp')),
  commentaire text,
  updated_at timestamptz not null default now(),
  unique(point_id, cle_cible)
);

alter table public.concours_points_controle enable row level security;
alter table public.concours_controles enable row level security;

drop policy if exists "concours_points_controle_authenticated_all" on public.concours_points_controle;
create policy "concours_points_controle_authenticated_all"
on public.concours_points_controle for all to authenticated using (true) with check (true);

drop policy if exists "concours_controles_authenticated_all" on public.concours_controles;
create policy "concours_controles_authenticated_all"
on public.concours_controles for all to authenticated using (true) with check (true);

-- Précharge les qualifications cheptel courantes uniquement s'il n'existe encore aucun point.
insert into public.concours_points_controle (concours_id,niveau,type_controle,libelle,obligatoire)
select c.id,'cheptel','qualification',v.libelle,true
from public.concours c
cross join (values ('Qualification IBR'),('Qualification BVD'),('Qualification Brucellose'),('Qualification Leucose'),('Qualification Tuberculose')) as v(libelle)
where not exists (select 1 from public.concours_points_controle p where p.concours_id=c.id);


-- ============================================================
-- v0.4.0 - REMBOURSEMENTS
-- ============================================================

create table if not exists public.concours_tarifs_analyses (
  id uuid primary key default gen_random_uuid(),
  concours_id uuid not null references public.concours(id) on delete cascade,
  analyse_type text not null,
  cout_unitaire numeric(10,2) not null default 0,
  created_by uuid default auth.uid(),
  created_at timestamptz not null default now(),
  unique(concours_id, analyse_type)
);

create table if not exists public.concours_remboursement_lignes (
  id uuid primary key default gen_random_uuid(),
  concours_id uuid not null references public.concours(id) on delete cascade,
  cheptel text not null,
  analyse_type text not null,
  justificatif_recu boolean not null default false,
  a_rembourser boolean not null default false,
  cout_unitaire_override numeric(10,2),
  quantite_remboursee integer,
  commentaire text,
  created_by uuid default auth.uid(),
  updated_at timestamptz not null default now(),
  unique(concours_id, cheptel, analyse_type)
);

alter table public.concours_tarifs_analyses enable row level security;
alter table public.concours_remboursement_lignes enable row level security;

drop policy if exists "concours_tarifs_analyses_authenticated_all" on public.concours_tarifs_analyses;
create policy "concours_tarifs_analyses_authenticated_all"
on public.concours_tarifs_analyses for all to authenticated using (true) with check (true);

drop policy if exists "concours_remboursement_lignes_authenticated_all" on public.concours_remboursement_lignes;
create policy "concours_remboursement_lignes_authenticated_all"
on public.concours_remboursement_lignes for all to authenticated using (true) with check (true);

-- v0.4.2 - infos animal
alter table public.concours_animaux
  add column if not exists sexe text,
  add column if not exists nom_animal text;


-- ============================================================
-- v0.4.3 - SUIVI DES REMBOURSEMENTS EFFECTUES
-- ============================================================
alter table public.concours_remboursement_lignes
  add column if not exists rembourse boolean not null default false,
  add column if not exists date_rembourse date;


-- ============================================================
-- v0.4.5 - VALIDATION RAPIDE / CONTROLE CERTIFICAT PAPIER
-- ============================================================
alter table public.concours_animaux
  add column if not exists verifie_certificat_papier boolean not null default false;

alter table public.concours_certificats
  add column if not exists mode_validation text;

-- v0.4.9 - statut animal sur certificat
alter table public.concours_animaux
  add column if not exists statut_certificat_animal text not null default 'a_verifier';

update public.concours_animaux
set statut_certificat_animal='present'
where sur_certificat=true
  and statut_certificat_animal='a_verifier';

-- v0.4.14 - simplification des statuts certificats
update public.concours_certificats
set statut_certificat='valide'
where statut_certificat='signe';

-- v0.5.0 - espace partenaires
create table if not exists public.concours_acces_partenaires (
 id uuid primary key default gen_random_uuid(),
 concours_id uuid not null references public.concours(id) on delete cascade,
 organisme text not null,email text not null,type_partenaire text not null default 'autre',
 permissions jsonb not null default '{}'::jsonb,actif boolean not null default true,
 created_by uuid default auth.uid(),created_at timestamptz not null default now(),updated_at timestamptz not null default now(),
 unique(concours_id,email)
);
create table if not exists public.concours_validations_partenaires (
 id uuid primary key default gen_random_uuid(),
 acces_partenaire_id uuid not null references public.concours_acces_partenaires(id) on delete cascade,
 cible_type text not null check(cible_type in ('cheptel','animal')),cible_cle text not null,
 statut_verification text not null default 'attente' check(statut_verification in ('attente','conforme','nonconforme')),
 statut_validation text not null default 'attente' check(statut_validation in ('attente','conforme','nonconforme')),
 commentaire text,updated_at timestamptz not null default now(),updated_by uuid default auth.uid(),
 unique(acces_partenaire_id,cible_type,cible_cle)
);
alter table public.concours_acces_partenaires enable row level security;
alter table public.concours_validations_partenaires enable row level security;
drop policy if exists concours_acces_partenaires_authenticated_all on public.concours_acces_partenaires;
create policy concours_acces_partenaires_authenticated_all on public.concours_acces_partenaires for all to authenticated using(true) with check(true);
drop policy if exists concours_validations_partenaires_authenticated_all on public.concours_validations_partenaires;
create policy concours_validations_partenaires_authenticated_all on public.concours_validations_partenaires for all to authenticated using(true) with check(true);


-- ============================================================
-- v0.5.2 - COMPTES PARTENAIRES CREES DEPUIS L'APPLICATION
-- ============================================================

alter table public.concours_acces_partenaires
  add column if not exists auth_user_id uuid unique;

create table if not exists public.concours_admins (
  user_id uuid primary key,
  email text,
  created_at timestamptz not null default now()
);

alter table public.concours_admins enable row level security;

drop policy if exists "concours_admins_self_read" on public.concours_admins;
create policy "concours_admins_self_read"
on public.concours_admins for select
to authenticated
using (auth.uid() = user_id);

-- IMPORTANT :
-- Pour autoriser un compte interne GDS à créer des comptes partenaires,
-- ajouter son UUID Supabase Auth dans concours_admins.
-- Exemple depuis l'éditeur SQL :
--
-- insert into public.concours_admins(user_id,email)
-- select id,email from auth.users
-- where email='VOTRE_EMAIL_GDS'
-- on conflict (user_id) do update set email=excluded.email;


-- ============================================================
-- v0.6.1 - PERIMETRE PARTENAIRES PAR DEPARTEMENT + INVITATION
-- ============================================================

alter table public.concours_acces_partenaires
  add column if not exists departements text[] not null default '{}'::text[];

alter table public.concours_acces_partenaires
  add column if not exists invitation_envoyee_at timestamptz;

-- Convention :
-- departements = tableau vide => tous les départements du concours
-- departements = {'65'} => uniquement le 65
-- departements = {'32','65'} => uniquement 32 et 65


-- ============================================================
-- v0.6.3 - PARTICIPATION / AJOUTS PARTENAIRES
-- ============================================================

alter table public.concours_animaux
  add column if not exists statut_participation text not null default 'engage';

alter table public.concours_animaux
  add column if not exists participation_commentaire text;

alter table public.concours_animaux
  add column if not exists ajoute_par_partenaire boolean not null default false;

alter table public.concours_animaux
  add column if not exists partenaire_modification_email text;

alter table public.concours_animaux
  add column if not exists partenaire_modification_at timestamptz;

-- Valeurs utilisées par l'application pour statut_participation :
-- engage          = bovin actuellement engagé / attendu
-- non_participant = l'engagement est conservé mais le bovin n'assistera pas
-- retire          = retiré de la liste active, conservé pour la traçabilité


-- ============================================================
-- v0.7.0 - CONTROLE A L'ENTREE DU CONCOURS
-- ============================================================

alter table public.concours_animaux
  add column if not exists entree_statut text not null default 'attente';

alter table public.concours_animaux
  add column if not exists entree_controle_at timestamptz;

alter table public.concours_animaux
  add column if not exists entree_controle_par text;

alter table public.concours_animaux
  add column if not exists entree_motif_refus text;

alter table public.concours_animaux
  add column if not exists entree_commentaire text;

-- entree_statut :
-- attente = pas encore contrôlé à l'entrée
-- present = accepté / arrivé
-- refuse  = refusé à l'entrée
-- absent  = attendu mais absent


-- v0.9.2 : concours actifs / clos
-- Suivi Concours v0.9.2
-- Ajoute le statut actif/clos sans supprimer aucun historique.
ALTER TABLE public.concours
ADD COLUMN IF NOT EXISTS actif boolean NOT NULL DEFAULT true;

-- Sécurise les anciennes lignes au cas où.
UPDATE public.concours
SET actif = true
WHERE actif IS NULL;
