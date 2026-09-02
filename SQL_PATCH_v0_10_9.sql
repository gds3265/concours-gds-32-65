-- Suivi Concours v0.10.9
ALTER TABLE public.concours_animaux ADD COLUMN IF NOT EXISTS code_race text;
ALTER TABLE public.concours_animaux ADD COLUMN IF NOT EXISTS race_libelle text;
ALTER TABLE public.concours ADD COLUMN IF NOT EXISTS commentaire_gestion text;
