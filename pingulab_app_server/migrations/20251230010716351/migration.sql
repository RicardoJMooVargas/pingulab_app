BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "quotes" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "quotes" (
    "id" bigserial PRIMARY KEY,
    "pieceWeightGrams" double precision NOT NULL,
    "printHours" double precision NOT NULL,
    "postProcessingCost" double precision,
    "measurements" text,
    "filamentCost" double precision NOT NULL,
    "electricityCost" double precision NOT NULL,
    "suppliesCost" double precision NOT NULL,
    "shippingCost" double precision,
    "subtotal" double precision NOT NULL,
    "marginPercent" double precision NOT NULL,
    "total" double precision NOT NULL,
    "status" bigint NOT NULL,
    "imageUrl" text,
    "printerId" bigint,
    "shippingId" bigint
);


--
-- MIGRATION VERSION FOR pingulab_app
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pingulab_app', '20251230010716351', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251230010716351', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
