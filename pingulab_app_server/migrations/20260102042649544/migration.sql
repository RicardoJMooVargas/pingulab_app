BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "filaments" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "filaments" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "brand" text NOT NULL,
    "materialType" text NOT NULL,
    "color" text NOT NULL,
    "spoolWeightKg" double precision NOT NULL,
    "spoolCost" double precision NOT NULL
);

--
-- ACTION DROP TABLE
--
DROP TABLE "printers" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "printers" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "powerConsumptionWatts" bigint NOT NULL,
    "purchaseCost" double precision NOT NULL,
    "imageBase64" text,
    "available" boolean NOT NULL
);

--
-- ACTION DROP TABLE
--
DROP TABLE "quotes" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "quotes" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "quantity" bigint NOT NULL,
    "pieceWeightGrams" double precision NOT NULL,
    "printHours" double precision NOT NULL,
    "postProcessingCost" double precision,
    "measurements" text,
    "filamentCost" double precision NOT NULL,
    "electricityCost" double precision NOT NULL,
    "suppliesCost" double precision NOT NULL,
    "depreciationCost" double precision NOT NULL,
    "shippingCost" double precision,
    "subtotal" double precision NOT NULL,
    "marginPercent" double precision NOT NULL,
    "total" double precision NOT NULL,
    "status" bigint NOT NULL,
    "imageUrl" text,
    "customerId" bigint,
    "printerId" bigint,
    "shippingId" bigint,
    "createdBy" bigint,
    "updatedBy" bigint
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "users" (
    "id" bigserial PRIMARY KEY,
    "email" text NOT NULL,
    "passwordHash" text NOT NULL,
    "nombre" text NOT NULL,
    "apellido" text,
    "rol" bigint NOT NULL,
    "activo" boolean NOT NULL,
    "created" timestamp without time zone NOT NULL,
    "updated" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "email_unique" ON "users" USING btree ("email");


--
-- MIGRATION VERSION FOR pingulab_app
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pingulab_app', '20260102042649544', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260102042649544', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
