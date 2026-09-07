-- Suivi Concours v0.11.7
ALTER TABLE public.concours
ADD COLUMN IF NOT EXISTS remboursements_actifs boolean NOT NULL DEFAULT true;

ALTER TABLE public.concours
ADD COLUMN IF NOT EXISTS bvd_anipi_accepte boolean NOT NULL DEFAULT false;
