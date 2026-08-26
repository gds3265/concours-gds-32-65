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
