BEGIN;

-- Safe, additive migration for production.

CREATE TABLE IF NOT EXISTS "filament_catalog_items" (
    "id" bigserial PRIMARY KEY,
    "materialType" text NOT NULL,
    "color" text NOT NULL,
    "active" boolean NOT NULL DEFAULT true
);

CREATE UNIQUE INDEX IF NOT EXISTS "material_color_unique"
    ON "filament_catalog_items" USING btree ("materialType", "color");

ALTER TABLE "filaments"
    ADD COLUMN IF NOT EXISTS "remainingGrams" double precision;

UPDATE "filaments"
SET "remainingGrams" = ("spoolWeightKg" * 1000)
WHERE "remainingGrams" IS NULL;

ALTER TABLE "filaments"
    ALTER COLUMN "remainingGrams" SET NOT NULL;

CREATE TABLE IF NOT EXISTS "sale_filament_consumptions" (
    "id" bigserial PRIMARY KEY,
    "saleId" bigint NOT NULL,
    "filamentId" bigint NOT NULL,
    "gramsConsumed" double precision NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS "sale_filament_unique"
    ON "sale_filament_consumptions" USING btree ("saleId", "filamentId");

CREATE INDEX IF NOT EXISTS "sale_consumptions"
    ON "sale_filament_consumptions" USING btree ("saleId");


--
-- MIGRATION VERSION FOR pingulab_app
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pingulab_app', '20260406044143144', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260406044143144', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
