-- Suivi Concours v0.11.23
-- Gestion des rôles internes depuis l'application.
-- Une seule exécution nécessaire.

create table if not exists public.concours_utilisateurs (
  email text primary key,
  role text not null default 'simplifie'
    check (role in ('simplifie','intermediaire','gestion_complete')),
  actif boolean not null default true,
  updated_at timestamptz not null default now(),
  updated_by text
);

alter table public.concours_utilisateurs enable row level security;

-- Fonction de sécurité : les administrateurs historiques et les profils
-- "gestion_complete" peuvent administrer les rôles.
create or replace function public.concours_is_full_manager()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select
    exists (
      select 1
      from public.concours_admins a
      where a.user_id = auth.uid()
         or lower(coalesce(a.email,'')) = lower(coalesce(auth.jwt()->>'email',''))
    )
    or exists (
      select 1
      from public.concours_utilisateurs u
      where lower(u.email) = lower(coalesce(auth.jwt()->>'email',''))
        and u.actif = true
        and u.role = 'gestion_complete'
    );
$$;

grant execute on function public.concours_is_full_manager() to authenticated;

drop policy if exists "concours_utilisateurs_select" on public.concours_utilisateurs;
create policy "concours_utilisateurs_select"
on public.concours_utilisateurs
for select
to authenticated
using (
  lower(email) = lower(coalesce(auth.jwt()->>'email',''))
  or public.concours_is_full_manager()
);

drop policy if exists "concours_utilisateurs_insert" on public.concours_utilisateurs;
create policy "concours_utilisateurs_insert"
on public.concours_utilisateurs
for insert
to authenticated
with check (public.concours_is_full_manager());

drop policy if exists "concours_utilisateurs_update" on public.concours_utilisateurs;
create policy "concours_utilisateurs_update"
on public.concours_utilisateurs
for update
to authenticated
using (public.concours_is_full_manager())
with check (public.concours_is_full_manager());

drop policy if exists "concours_utilisateurs_delete" on public.concours_utilisateurs;
create policy "concours_utilisateurs_delete"
on public.concours_utilisateurs
for delete
to authenticated
using (public.concours_is_full_manager());
