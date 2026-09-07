-- Suivi Concours v0.11.9
-- Le BVD ANIPI est désormais un point de vérification et ne nécessite plus de colonne dédiée sur concours.
-- Cette colonne est nécessaire uniquement pour pouvoir exclure un concours des remboursements.

ALTER TABLE public.concours
ADD COLUMN IF NOT EXISTS remboursements_actifs boolean NOT NULL DEFAULT true;

-- Si une ancienne version a déjà créé bvd_anipi_accepte, on la laisse en place :
-- elle n'est plus utilisée par l'application et sa présence ne gêne pas.
