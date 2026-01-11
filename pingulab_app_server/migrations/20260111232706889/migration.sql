BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "quote_categories" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "description" text,
    "icon" text,
    "color" text,
    "active" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "name_unique" ON "quote_categories" USING btree ("name");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "quote_version_filaments" (
    "id" bigserial PRIMARY KEY,
    "quoteVersionId" bigint NOT NULL,
    "filamentId" bigint NOT NULL,
    "gramsUsed" double precision NOT NULL,
    "cost" double precision NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "quote_version_supplies" (
    "id" bigserial PRIMARY KEY,
    "quoteVersionId" bigint NOT NULL,
    "extraSupplyId" bigint NOT NULL,
    "quantity" bigint NOT NULL,
    "cost" double precision NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "quote_versions" (
    "id" bigserial PRIMARY KEY,
    "quoteId" bigint NOT NULL,
    "versionNumber" bigint NOT NULL,
    "versionName" text,
    "isPrimary" boolean NOT NULL,
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
    "printerId" bigint,
    "shippingId" bigint,
    "createdBy" bigint,
    "created" timestamp without time zone NOT NULL,
    "notes" text
);

-- Indexes
CREATE UNIQUE INDEX "quote_version_unique" ON "quote_versions" USING btree ("quoteId", "versionNumber");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "quotes" ADD COLUMN "categoryId" bigint;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "sales" (
    "id" bigserial PRIMARY KEY,
    "quoteId" bigint NOT NULL,
    "quoteVersionId" bigint,
    "saleStatus" bigint NOT NULL,
    "paymentStatus" bigint NOT NULL,
    "totalAmount" double precision NOT NULL,
    "paidAmount" double precision NOT NULL,
    "pendingAmount" double precision NOT NULL,
    "scheduledDeliveryDate" timestamp without time zone,
    "actualDeliveryDate" timestamp without time zone,
    "deliveryNotes" text,
    "reminderSent" boolean NOT NULL,
    "reminderDate" timestamp without time zone,
    "customerId" bigint,
    "customerName" text,
    "createdBy" bigint,
    "updatedBy" bigint,
    "created" timestamp without time zone NOT NULL,
    "updated" timestamp without time zone,
    "notes" text
);

-- Indexes
CREATE INDEX "quote_sale" ON "sales" USING btree ("quoteId");


--
-- MIGRATION VERSION FOR pingulab_app
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pingulab_app', '20260111232706889', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260111232706889', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
