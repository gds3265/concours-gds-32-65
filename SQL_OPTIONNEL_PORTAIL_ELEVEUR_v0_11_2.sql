-- Suivi Concours v0.11.0 — PORTAIL ELEVEUR
create table if not exists public.concours_acces_eleveurs (
  id uuid primary key default gen_random_uuid(),
  concours_id uuid not null references public.concours(id) on delete cascade,
  cheptel text not null, eleveur text not null, email text not null, auth_user_id uuid,
  statut text not null default 'pending' check (statut in ('pending','active','rejected')),
  source text not null default 'admin' check (source in ('admin','import','self')),
  peut_modifier_inscription boolean not null default false, actif boolean not null default true,
  invitation_envoyee_at timestamptz, created_at timestamptz not null default now(), updated_at timestamptz not null default now(),
  unique(concours_id,cheptel,email)
);
alter table public.concours_acces_eleveurs enable row level security;

-- Exclure explicitement les comptes farmer des anciennes politiques ouvertes à "authenticated".
drop policy if exists "concours_authenticated_all" on public.concours;
create policy "concours_authenticated_all" on public.concours for all to authenticated using (coalesce(auth.jwt()->'app_metadata'->>'app_role','') <> 'farmer') with check (coalesce(auth.jwt()->'app_metadata'->>'app_role','') <> 'farmer');
drop policy if exists "concours_animaux_authenticated_all" on public.concours_animaux;
create policy "concours_animaux_authenticated_all" on public.concours_animaux for all to authenticated using (coalesce(auth.jwt()->'app_metadata'->>'app_role','') <> 'farmer') with check (coalesce(auth.jwt()->'app_metadata'->>'app_role','') <> 'farmer');
drop policy if exists "concours_resultats_authenticated_all" on public.concours_resultats;
create policy "concours_resultats_authenticated_all" on public.concours_resultats for all to authenticated using (coalesce(auth.jwt()->'app_metadata'->>'app_role','') <> 'farmer') with check (coalesce(auth.jwt()->'app_metadata'->>'app_role','') <> 'farmer');
drop policy if exists "concours_certificats_authenticated_all" on public.concours_certificats;
create policy "concours_certificats_authenticated_all" on public.concours_certificats for all to authenticated using (coalesce(auth.jwt()->'app_metadata'->>'app_role','') <> 'farmer') with check (coalesce(auth.jwt()->'app_metadata'->>'app_role','') <> 'farmer');
drop policy if exists "concours_regles_authenticated_all" on public.concours_regles;
create policy "concours_regles_authenticated_all" on public.concours_regles for all to authenticated using (coalesce(auth.jwt()->'app_metadata'->>'app_role','') <> 'farmer') with check (coalesce(auth.jwt()->'app_metadata'->>'app_role','') <> 'farmer');
drop policy if exists "concours_regles_catalogue_authenticated_all" on public.concours_regles_catalogue;
create policy "concours_regles_catalogue_authenticated_all" on public.concours_regles_catalogue for all to authenticated using (coalesce(auth.jwt()->'app_metadata'->>'app_role','') <> 'farmer') with check (coalesce(auth.jwt()->'app_metadata'->>'app_role','') <> 'farmer');
drop policy if exists "concours_demandes_authenticated_all" on public.concours_demandes;
create policy "concours_demandes_authenticated_all" on public.concours_demandes for all to authenticated using (coalesce(auth.jwt()->'app_metadata'->>'app_role','') <> 'farmer') with check (coalesce(auth.jwt()->'app_metadata'->>'app_role','') <> 'farmer');
drop policy if exists "concours_points_controle_authenticated_all" on public.concours_points_controle;
create policy "concours_points_controle_authenticated_all" on public.concours_points_controle for all to authenticated using (coalesce(auth.jwt()->'app_metadata'->>'app_role','') <> 'farmer') with check (coalesce(auth.jwt()->'app_metadata'->>'app_role','') <> 'farmer');
drop policy if exists "concours_controles_authenticated_all" on public.concours_controles;
create policy "concours_controles_authenticated_all" on public.concours_controles for all to authenticated using (coalesce(auth.jwt()->'app_metadata'->>'app_role','') <> 'farmer') with check (coalesce(auth.jwt()->'app_metadata'->>'app_role','') <> 'farmer');
drop policy if exists concours_acces_partenaires_authenticated_all on public.concours_acces_partenaires;
create policy concours_acces_partenaires_authenticated_all on public.concours_acces_partenaires for all to authenticated using (coalesce(auth.jwt()->'app_metadata'->>'app_role','') <> 'farmer') with check (coalesce(auth.jwt()->'app_metadata'->>'app_role','') <> 'farmer');
drop policy if exists concours_validations_partenaires_authenticated_all on public.concours_validations_partenaires;
create policy concours_validations_partenaires_authenticated_all on public.concours_validations_partenaires for all to authenticated using (coalesce(auth.jwt()->'app_metadata'->>'app_role','') <> 'farmer') with check (coalesce(auth.jwt()->'app_metadata'->>'app_role','') <> 'farmer');

drop policy if exists concours_acces_eleveurs_internal_all on public.concours_acces_eleveurs;
create policy concours_acces_eleveurs_internal_all on public.concours_acces_eleveurs for all to authenticated using (coalesce(auth.jwt()->'app_metadata'->>'app_role','') <> 'farmer') with check (coalesce(auth.jwt()->'app_metadata'->>'app_role','') <> 'farmer');
create policy concours_acces_eleveurs_self_select on public.concours_acces_eleveurs for select to authenticated using (coalesce(auth.jwt()->'app_metadata'->>'app_role','')='farmer' and actif and (auth_user_id=auth.uid() or lower(email)=lower(coalesce(auth.jwt()->>'email',''))));
create policy concours_farmer_select on public.concours for select to authenticated using (coalesce(auth.jwt()->'app_metadata'->>'app_role','')='farmer' and exists(select 1 from public.concours_acces_eleveurs ae where ae.concours_id=concours.id and ae.actif and (ae.auth_user_id=auth.uid() or lower(ae.email)=lower(coalesce(auth.jwt()->>'email','')))));
create policy concours_animaux_farmer_select on public.concours_animaux for select to authenticated using (coalesce(auth.jwt()->'app_metadata'->>'app_role','')='farmer' and exists(select 1 from public.concours_acces_eleveurs ae where ae.concours_id=concours_animaux.concours_id and ae.cheptel=concours_animaux.cheptel and ae.statut='active' and ae.actif and (ae.auth_user_id=auth.uid() or lower(ae.email)=lower(coalesce(auth.jwt()->>'email','')))));
create policy concours_animaux_farmer_insert on public.concours_animaux for insert to authenticated with check (coalesce(auth.jwt()->'app_metadata'->>'app_role','')='farmer' and exists(select 1 from public.concours_acces_eleveurs ae where ae.concours_id=concours_animaux.concours_id and ae.cheptel=concours_animaux.cheptel and ae.statut='active' and ae.actif and ae.peut_modifier_inscription and (ae.auth_user_id=auth.uid() or lower(ae.email)=lower(coalesce(auth.jwt()->>'email','')))));
create policy concours_resultats_farmer_select on public.concours_resultats for select to authenticated using (coalesce(auth.jwt()->'app_metadata'->>'app_role','')='farmer' and exists(select 1 from public.concours_animaux a join public.concours_acces_eleveurs ae on ae.concours_id=a.concours_id and ae.cheptel=a.cheptel where a.id=concours_resultats.animal_id and ae.statut='active' and ae.actif and (ae.auth_user_id=auth.uid() or lower(ae.email)=lower(coalesce(auth.jwt()->>'email','')))));
create policy concours_certificats_farmer_select on public.concours_certificats for select to authenticated using (coalesce(auth.jwt()->'app_metadata'->>'app_role','')='farmer' and exists(select 1 from public.concours_acces_eleveurs ae where ae.concours_id=concours_certificats.concours_id and ae.eleveur=concours_certificats.eleveur and ae.statut='active' and ae.actif and (ae.auth_user_id=auth.uid() or lower(ae.email)=lower(coalesce(auth.jwt()->>'email','')))));
create policy concours_demandes_farmer_select on public.concours_demandes for select to authenticated using (coalesce(auth.jwt()->'app_metadata'->>'app_role','')='farmer' and exists(select 1 from public.concours_acces_eleveurs ae where ae.concours_id=concours_demandes.concours_id and ae.actif and (ae.auth_user_id=auth.uid() or lower(ae.email)=lower(coalesce(auth.jwt()->>'email','')))));
create policy concours_regles_farmer_select on public.concours_regles for select to authenticated using (coalesce(auth.jwt()->'app_metadata'->>'app_role','')='farmer' and exists(select 1 from public.concours_acces_eleveurs ae where ae.concours_id=concours_regles.concours_id and ae.actif and (ae.auth_user_id=auth.uid() or lower(ae.email)=lower(coalesce(auth.jwt()->>'email','')))));
create policy concours_regles_catalogue_farmer_select on public.concours_regles_catalogue for select to authenticated using (coalesce(auth.jwt()->'app_metadata'->>'app_role','')='farmer');
create policy concours_points_farmer_select on public.concours_points_controle for select to authenticated using (coalesce(auth.jwt()->'app_metadata'->>'app_role','')='farmer' and exists(select 1 from public.concours_acces_eleveurs ae where ae.concours_id=concours_points_controle.concours_id and ae.actif and (ae.auth_user_id=auth.uid() or lower(ae.email)=lower(coalesce(auth.jwt()->>'email','')))));
create policy concours_controles_farmer_select on public.concours_controles for select to authenticated using (coalesce(auth.jwt()->'app_metadata'->>'app_role','')='farmer' and exists(select 1 from public.concours_acces_eleveurs ae where ae.concours_id=concours_controles.concours_id and ae.statut='active' and ae.actif and concours_controles.cle_cible='cheptel:'||ae.cheptel and (ae.auth_user_id=auth.uid() or lower(ae.email)=lower(coalesce(auth.jwt()->>'email','')))));
