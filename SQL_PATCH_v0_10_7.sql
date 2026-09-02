-- Suivi Concours v0.10.7
-- Délai maximal avant concours pendant lequel la signature du certificat est valable.
ALTER TABLE public.concours
ADD COLUMN IF NOT EXISTS delai_signature_jours integer;

ALTER TABLE public.concours
DROP CONSTRAINT IF EXISTS concours_delai_signature_jours_check;

ALTER TABLE public.concours
ADD CONSTRAINT concours_delai_signature_jours_check
CHECK (delai_signature_jours IS NULL OR delai_signature_jours >= 0);
