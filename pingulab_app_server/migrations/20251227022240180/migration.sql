BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "electricity_rates" (
    "id" bigserial PRIMARY KEY,
    "costPerKwh" double precision NOT NULL,
    "active" boolean NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "extra_supplies" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "cost" double precision NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "filaments" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "brand" text NOT NULL,
    "materialType" text NOT NULL,
    "spoolWeightKg" double precision NOT NULL,
    "spoolCost" double precision NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "printers" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "powerConsumptionWatts" bigint NOT NULL,
    "available" boolean NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "quote_extra_supplies" (
    "id" bigserial PRIMARY KEY,
    "quoteId" bigint NOT NULL,
    "extraSupplyId" bigint NOT NULL,
    "quantity" bigint NOT NULL,
    "cost" double precision NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "quote_filaments" (
    "id" bigserial PRIMARY KEY,
    "quoteId" bigint NOT NULL,
    "filamentId" bigint NOT NULL,
    "gramsUsed" double precision NOT NULL,
    "cost" double precision NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "quotes" (
    "id" bigserial PRIMARY KEY,
    "gramsPrinted" double precision NOT NULL,
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
-- ACTION CREATE TABLE
--
CREATE TABLE "shippings" (
    "id" bigserial PRIMARY KEY,
    "shippingType" text NOT NULL,
    "carrierName" text NOT NULL,
    "cost" double precision NOT NULL
);


--
-- MIGRATION VERSION FOR pingulab_app
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pingulab_app', '20251227022240180', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251227022240180', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
