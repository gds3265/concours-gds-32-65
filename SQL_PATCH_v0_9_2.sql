-- Suivi Concours v0.9.2
-- Ajoute le statut actif/clos sans supprimer aucun historique.
ALTER TABLE public.concours
ADD COLUMN IF NOT EXISTS actif boolean NOT NULL DEFAULT true;

-- Sécurise les anciennes lignes au cas où.
UPDATE public.concours
SET actif = true
WHERE actif IS NULL;
